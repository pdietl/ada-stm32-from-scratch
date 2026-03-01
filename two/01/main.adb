with System;
with Interfaces;
with STM32WL.GPIO;

use type Interfaces.Unsigned_32;
use STM32WL.GPIO;

procedure Main is

   RCC_AHB2ENR : Interfaces.Unsigned_32 with
     Volatile, Address => System'To_Address (16#5800_004C#);

   procedure Crude_Delay is
      Counter : Interfaces.Unsigned_32 := 0 with
        Volatile;
   begin
      for I in 1 .. 500_000 loop
         Counter := @ + 1;
      end loop;
   end Crude_Delay;

begin
   -- Enable GPIOB peripheral clock.
   RCC_AHB2ENR := @ or 16#0000_0002#;

   GPIOB.MODER.Pin_9 := Output;

   loop
      GPIOB.BSRR := (BS_9 => True, others => False);

      Crude_Delay;

      GPIOB.BSRR := (BR_9 => True, others => False);

      Crude_Delay;
   end loop;
end Main;
