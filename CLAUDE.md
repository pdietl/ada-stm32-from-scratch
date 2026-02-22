# Ada STM32 From Scratch — Project Guide

## Project Overview
Bare-metal Ada/SPARK learning project targeting the NUCLEO-WL55JC1 board (STM32WL55JCI6, Cortex-M4 core only). Building everything from first principles — hand-written ZFP runtime, manual compilation, no pre-built BSPs.

## Owner
Pete — embedded systems engineer experienced with STM32/Cortex-M4, Zephyr, C/C++, CAN bus. Learning Ada/SPARK from scratch.

## Teaching Rules
- **Socratic method**: Guide, don't hand over code. Ask questions, draw C/ARM parallels.
- **Introduce concepts only when needed**: Don't front-load Ada theory.
- **Correct directly**: When something is wrong, say so plainly.
- **Formal methods background**: Pete knows Hoare logic, WP calculus, Frama-C, FOL proofs, SAT/SMT. Map SPARK concepts to Frama-C equivalents, don't re-explain the theory.

## Hardware
- **MCU**: STM32WL55JCI6 (dual-core CM4+CM0+, using CM4 only)
- **Reference manual**: RM0453
- **Flash**: 256KB @ 0x0800_0000
- **SRAM1**: 32KB @ 0x2000_0000, **SRAM2**: 32KB @ 0x2000_8000
- **LEDs**: Blue=PB15, Green=PB9, Red=PB11
- **Default clock**: MSI 4MHz (no PLL setup)
- **RCC base**: 0x5800_0000 (AHB3), RCC_AHB2ENR offset 0x4C, GPIOBEN=bit 1
- **GPIOB base**: 0x4800_0400 (AHB2)
- **SysTick**: SYST_CSR=0xE000_E010, SYST_RVR=0xE000_E014, SYST_CVR=0xE000_E018

## Toolchain
- **Compiler**: `gnat_arm_elf` via Alire (`alr toolchain --select gnat_arm_elf`)
- **Toolchain path**: `~/.local/share/alire/toolchains/gnat_arm_elf_<version>/bin/`
- **Add to PATH**: `export PATH="$HOME/.local/share/alire/toolchains/gnat_arm_elf_<version>/bin:$PATH"`
- **Flash tool**: `STM32_Programmer_CLI` (ST-provided, SWD connection)
- **No GPR/Alire build system**: Direct `arm-eabi-gcc` and `arm-eabi-ld` invocations via `build.sh`

## Compiler Flags
- `-gnatg`: Compile runtime units (system.ads, ada.ads, interfaces.ads)
- `-gnatp`: Suppress runtime checks (for application code)
- `-gnatk255`: Allow long filenames (needed for child packages like `stm32wl-gpio.ads`)
- `-nostdinc`: No pre-installed runtime — use our hand-written one
- `-mcpu=cortex-m4 -mthumb`: Target Cortex-M4 in Thumb mode

## Project Structure
Each phase is a self-contained directory with its own runtime, linker script, and build script:
- `01_blinky/` — Minimal raw-register blink (Phase 1)
- `02_blinky_ada_lang_features/` — Typed GPIO register access with enums and record layouts (Phase 2)
- Future phases will continue this pattern

## Build & Flash (per example directory)
```bash
./build.sh          # Compile and link
./write_flash.sh    # Flash via SWD
./clean.sh          # Remove build artifacts
./erase_flash.sh    # Full chip erase
```

## Key Files in Each Example
- `system.ads`, `ada.ads`, `interfac.ads` — Hand-written ZFP runtime
- `crt0.S` — Cortex-M4 vector table, .data copy, .bss zero, call to `_ada_main`
- `linker.ld` — Flash/SRAM memory layout
- `main.adb` — Application entry point (exported as `_ada_main`)
- `stm32wl*.ads` — Peripheral definition packages (Phase 2+)

## Ada Concepts Already Covered
Packages, child packages, `with`/`use`/`use type`, modular types, enumeration representation clauses, record representation clauses, bit-level layouts, `Volatile`/`Volatile_Full_Access`, `Address`/`Import`/`Export` aspects, aggregates with `others`, `pragma Pure`/`Preelaborate`, GNAT `.ali` files, runtime tiers (ZFP through full)

## Current Phase
Phase 4: SysTick interrupt-driven LED chaser (not yet started in code)
