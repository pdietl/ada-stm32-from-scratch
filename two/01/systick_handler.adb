with STM32WL.GPIO; use STM32WL.GPIO;

package body SysTick_Handler is

   type LED_Phase is mod 3;

   Phase : LED_Phase := 0;

   -- Blue = PB15, Green = PB9, Red = PB11

   procedure SysTick_Handler is
   begin
      GPIOB.BSRR :=
        (BR_9  => True, BR_11 => True, BR_15 => True, BS_9 => Phase = 1,
         BS_11 => Phase = 2, BS_15 => Phase = 0, others => False);
      Phase      := @ + 1;
   end SysTick_Handler;

end SysTick_Handler;
