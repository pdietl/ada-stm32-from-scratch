#!/usr/bin/env bash

set -euxo pipefail

declare -r CC=arm-eabi-gcc

ada_compile() {
  "$CC" -c -mcpu=cortex-m4 -mthumb -gnatk255 "$@"
}

mkdir -p build

ada_compile -gnatg -nostdinc system.ads -o build/system.o
ada_compile -gnatg -nostdinc ada.ads -o build/ada.o
ada_compile -gnatg -nostdinc interfac.ads -o build/interfac.o
ada_compile -gnatp -nostdinc main.adb -o build/main.o
ada_compile crt0.S -o build/crt0.o

arm-eabi-ld -T linker.ld -nostdlib build/crt0.o build/main.o -o build/blink.elf
