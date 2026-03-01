/* linker.ld — STM32WL55JC, targeting Cortex-M4 core only */

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 256K
  SRAM1 (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
  /* SRAM2 at 0x20008000 (32K) — we'll ignore it for now */
}

/* Stack grows downward from top of SRAM1 */
_stack_top = ORIGIN(SRAM1) + LENGTH(SRAM1);

ENTRY(_reset_handler);

SECTIONS
{
  .text :
  {
    KEEP(*(.vectors))     /* Vector table must be first */
    *(.text*)
    *(.rodata*)
  } > FLASH

  /* Initialized data — stored in flash, copied to RAM at startup */
  _data_load = LOADADDR(.data);

  .data :
  {
    _data_start = .;
    *(.data*)
    _data_end = .;
  } > SRAM1 AT > FLASH

  .bss (NOLOAD) :
  {
    _bss_start = .;
    *(.bss*)
    *(COMMON)
    _bss_end = .;
  } > SRAM1
}
