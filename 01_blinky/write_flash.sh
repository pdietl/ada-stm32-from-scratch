#!/usr/bin/env bash

set -eux

STM32_Programmer_CLI --connect port=swd reset=hwrst --write blink.elf --hardrst
