#!/usr/bin/env bash

set -eux

arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc system.ads
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc ada.ads
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatg -nostdinc interfac.ads
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb -gnatp -nostdinc main.adb
arm-eabi-gcc -c -mcpu=cortex-m4 -mthumb crt0.S -o crt0.o
arm-eabi-ld -T linker.ld -nostdlib crt0.o main.o -o blink.elf
