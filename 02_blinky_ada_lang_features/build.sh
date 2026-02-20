#!/usr/bin/env bash

set -euxo pipefail

declare -r CC=arm-eabi-gcc

ada_compile() {
  "$CC" -c -mcpu=cortex-m4 -mthumb -gnatk255 "$@"
}

ada_compile -gnatg -nostdinc system.ads
ada_compile -gnatg -nostdinc ada.ads
ada_compile -gnatg -nostdinc interfac.ads
ada_compile -gnatp -nostdinc main.adb
ada_compile crt0.S -o crt0.o

arm-eabi-ld -T linker.ld -nostdlib crt0.o main.o -o blink.elf
