/* crt0.S — Minimal Cortex-M4 startup for Ada ZFP */

    .syntax unified
    .cpu cortex-m4
    .thumb

    .section .vectors, "a"
    .align 2
    .global _vectors

_vectors:
    .word _stack_top          /* Initial SP value */
    .word _reset_handler      /* Reset vector */
    /* We'll add fault handlers later. For now, loop-on-fault. */
    .word _fault_handler      /* NMI */
    .word _fault_handler      /* HardFault */
    .word _fault_handler      /* MemManage */
    .word _fault_handler      /* BusFault */
    .word _fault_handler      /* UsageFault */

    .section .text
    .thumb_func
    .global _reset_handler

_reset_handler:
    /* Copy .data from flash to SRAM */
    ldr r0, =_data_start
    ldr r1, =_data_end
    ldr r2, =_data_load
1:
    cmp r0, r1
    bge 2f
    ldr r3, [r2], #4
    str r3, [r0], #4
    b 1b
2:

    /* Zero .bss */
    ldr r0, =_bss_start
    ldr r1, =_bss_end
    movs r2, #0
3:
    cmp r0, r1
    bge 4f
    str r2, [r0], #4
    b 3b
4:

    /* Jump to Ada main subprogram */
    bl _ada_main

    /* If main returns, hang */
    b .

    .thumb_func
    .global _fault_handler
_fault_handler:
    b .
