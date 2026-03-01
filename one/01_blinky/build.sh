#!/usr/bin/env bash

set -eux

mkdir -p build

arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc system.ads -o build/system.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc ada.ads -o build/ada.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc interfac.ads -o build/interfac.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatp -nostdinc main.adb -o build/main.o
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb crt0.S -o build/crt0.o
arm-eabi-ld -T linker.ld -nostdlib build/crt0.o build/main.o -o build/blink.elf
