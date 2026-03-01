#!/usr/bin/env bash

set -eux

STM32_Programmer_CLI --connect port=swd --erase all --hardrst
