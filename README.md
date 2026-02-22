# ada-stm32-from-scratch

Bare-metal Ada on STM32 — built from first principles with no pre-built runtimes or BSPs.

Target board: **NUCLEO-WL55JC1** (STM32WL55JCI6, Cortex-M4 core)

## Prerequisites

- Linux (tested on Ubuntu)
- [Alire](https://alire.ada.dev/) (Ada package manager and toolchain installer)
- [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) (provides `STM32_Programmer_CLI` for flashing via SWD)

## Toolchain Setup

### 1. Install Alire

Download the latest release from [alire.ada.dev](https://alire.ada.dev/) and place the `alr` binary somewhere in your `PATH`.

### 2. Install the ARM cross-compiler

```bash
alr toolchain --select gnat_arm_elf
```

This downloads a GNAT ARM ELF cross-compiler managed by Alire. It does **not** add the tools to your `PATH` automatically.

### 3. Install STM32CubeProgrammer

Download and install [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) from ST. Note: the download requires a free ST account login.

After installation, add the `bin/` directory from your STM32CubeProgrammer install location to your `PATH`. For example, if you installed to the default location:

```bash
export PATH="/path/to/STM32CubeProgrammer/bin:$PATH"
```

This provides the `STM32_Programmer_CLI` executable used by `write_flash.sh` and `erase_flash.sh`.

### 4. Add the toolchain to your PATH

Alire stores toolchains under `~/.local/share/alire/toolchains/`. Find your installed version and export the `bin/` directory:

```bash
# List what's installed:
ls ~/.local/share/alire/toolchains/

# Export the bin directory (adjust the version suffix to match yours):
export PATH="$HOME/.local/share/alire/toolchains/gnat_arm_elf_15.2.1_a5e9cfb1/bin:$PATH"
```

To make both exports permanent, add them to your `~/.bashrc` or `~/.zshrc`.

### 5. Verify

```bash
arm-eabi-gcc --version
STM32_Programmer_CLI --version
```

You should see something like `arm-eabi-gcc (GCC) 15.2.0` and the STM32CubeProgrammer version info.

## Project Structure

Each example is a self-contained directory with its own hand-written ZFP runtime, linker script, startup code, and build script. No shared libraries or dependencies between examples — each one stands alone.

```
01_blinky/                      Minimal raw-register LED blink
02_blinky_ada_lang_features/    Typed GPIO access with enums and record layouts
```

### Files common to each example

| File | Purpose |
|------|---------|
| `system.ads` | Minimal `System` package (address type, word size, priority ranges) |
| `ada.ads` | Empty parent package required by Ada language rules |
| `interfac.ads` | `Interfaces` package with `Unsigned_8/16/32` and bitwise operators |
| `crt0.S` | Cortex-M4 vector table, `.data` copy from flash, `.bss` zeroing, call to `_ada_main` |
| `linker.ld` | Memory layout: 256KB flash at 0x0800_0000, 32KB SRAM at 0x2000_0000 |
| `main.adb` | Application entry point |
| `build.sh` | Compiles all units and links the ELF |
| `clean.sh` | Removes build artifacts (`.o`, `.ali`, `.elf`) |
| `write_flash.sh` | Flashes `blink.elf` to the board via SWD |
| `erase_flash.sh` | Full chip erase |

## Building and Flashing

```bash
cd 01_blinky
./build.sh
./write_flash.sh
```

### What `build.sh` does

The build scripts call `arm-eabi-gcc` and `arm-eabi-ld` directly — no `gprbuild`, no Alire build system, no pre-installed runtime. This is intentional: we're learning how GNAT works under the hood. All build artifacts go into a `build/` subdirectory.

```bash
mkdir -p build

# Compile runtime units (need -gnatg for runtime compilation, -nostdinc to skip pre-installed runtime)
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc system.ads -o build/system.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc ada.ads -o build/ada.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc interfac.ads -o build/interfac.o

# Compile application code (-gnatp suppresses runtime checks since our ZFP has no check handlers)
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatp -nostdinc main.adb -o build/main.o

# Assemble startup code
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb crt0.S -o build/crt0.o

# Link
arm-eabi-ld -T linker.ld -nostdlib build/crt0.o build/main.o -o build/blink.elf
```

### Compiler flags explained

| Flag | Purpose |
|------|---------|
| `-mcpu=cortex-m4 -mthumb` | Target Cortex-M4 in Thumb instruction set |
| `-gnatg` | GNAT internal mode — required when compiling runtime source (`system.ads`, etc.) |
| `-gnatp` | Suppress all runtime checks (no check handlers exist in our ZFP) |
| `-gnatk255` | Allow filenames up to 255 characters (needed for child packages like `stm32wl-gpio.ads`) |
| `-nostdinc` | Don't search for a pre-installed runtime — use only what's in the current directory |
| `-nostdlib` | Don't link against any standard libraries |

## Examples

### 01_blinky

Minimal LED blink using raw register writes. Blue LED (PB15) toggled with a busy-wait delay. Demonstrates the absolute minimum needed to get Ada running on bare metal: a ZFP runtime, a vector table, a linker script, and direct memory-mapped I/O.

### 02_blinky_ada_lang_features

Three-LED chaser (Blue/Red/Green) using Ada's type system for register access. Introduces:
- Enumeration types with representation clauses for GPIO pin modes
- Record types with bit-level representation clauses mapping to hardware registers
- `Volatile_Full_Access` to ensure whole-register reads/writes
- Named aggregate syntax for BSRR set/reset operations
- Child packages (`STM32WL.GPIO`) for peripheral definitions
