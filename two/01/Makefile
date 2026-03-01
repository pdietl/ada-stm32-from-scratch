MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TOOLCHAIN_PREFIX := arm-eabi-

VPATH  := $(MAKEFILE_DIR)
CC     := $(TOOLCHAIN_PREFIX)gcc
LD     := $(TOOLCHAIN_PREFIX)ld

ARCH_FLAGS    := -mcpu=cortex-m4 -mthumb
GNAT_SEARCH   := -nostdinc -gnatk255 -I$(MAKEFILE_DIR)
RUNTIME_FLAGS := $(ARCH_FLAGS) -gnatg $(GNAT_SEARCH)
APP_FLAGS     := $(ARCH_FLAGS) -gnatp -gnat2022 $(GNAT_SEARCH)

LINKER_SCRIPT := linker.ld
TARGET        := blink.elf

.PHONY: all clean flash erase

all: $(TARGET)

$(TARGET): crt0.o main.o $(LINKER_SCRIPT)
	$(LD) -T $(filter %.ld,$^) -nostdlib $(filter %.o,$^) -o $@

# GNAT produces both a .o and .ali from a single compilation.
# Grouped targets (&:) tell make these are joint outputs of one
# recipe, preventing redundant invocations.

# Runtime units
system.o system.ali &: system.ads
	$(CC) -c $(RUNTIME_FLAGS) $< -o $(basename $@).o

ada.o ada.ali &: ada.ads system.ali
	$(CC) -c $(RUNTIME_FLAGS) $< -o $(basename $@).o

interfac.o interfac.ali &: interfac.ads system.ali
	$(CC) -c $(RUNTIME_FLAGS) $< -o $(basename $@).o

# Application packages
stm32wl.o stm32wl.ali &: stm32wl.ads system.ali
	$(CC) -c $(APP_FLAGS) $< -o $(basename $@).o

stm32wl-gpio.o stm32wl-gpio.ali &: stm32wl-gpio.ads stm32wl.ali system.ali interfac.ali
	$(CC) -c $(APP_FLAGS) $< -o $(basename $@).o

stm32wl-rcc.o stm32wl-rcc.ali &: stm32wl-rcc.ads stm32wl.ali system.ali interfac.ali
	$(CC) -c $(APP_FLAGS) $< -o $(basename $@).o

main.o main.ali &: main.adb system.ali interfac.ali stm32wl-gpio.ali stm32wl-rcc.ali
	$(CC) -c $(APP_FLAGS) $< -o $(basename $@).o

# Assembly startup code
%.o: %.S
	$(CC) -c $(ARCH_FLAGS) $< -o $@

flash: $(TARGET)
	STM32_Programmer_CLI --connect port=swd reset=hwrst --write $(TARGET) --hardrst

erase:
	STM32_Programmer_CLI --connect port=swd --erase all --hardrst

clean:
	rm -f *.o *.ali $(TARGET)
