with System;
with Interfaces;
with STM32WL.GPIO;

use type Interfaces.Unsigned_32;

procedure Main is
   use STM32WL.GPIO;

   RCC_AHB2ENR : Interfaces.Unsigned_32 with
     Volatile, Address => System'To_Address (16#5800_004C#);
   procedure Crude_Delay is
      Counter : Interfaces.Unsigned_32 := 0 with
        Volatile;
   begin
      for I in 1 .. 100_000 loop
         Counter := Counter + 1;
      end loop;
   end Crude_Delay;
begin
   RCC_AHB2ENR := RCC_AHB2ENR or 16#0000_0002#;

   GPIOB.MODER.Pin_15 := Output;
   GPIOB.MODER.Pin_11 := Output;
   GPIOB.MODER.Pin_9  := Output;

   loop
      GPIOB.BSRR :=
        (BR_15 => True, BR_11 => True, BS_9 => True, others => False);

      Crude_Delay;

      GPIOB.BSRR :=
        (BR_15 => True, BS_11 => True, BR_9 => True, others => False);

      Crude_Delay;

      GPIOB.BSRR :=
        (BS_15 => True, BR_11 => True, BR_9 => True, others => False);

      Crude_Delay;
   end loop;
end Main;
