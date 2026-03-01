with Interfaces;
with STM32WL.GPIO;
with STM32WL.RCC;

use type Interfaces.Unsigned_32;
use STM32WL.GPIO;
use STM32WL.RCC;

procedure Main is

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
   RCC.AHB2ENR := (GPIOBEN => True, others => False);

   GPIOB.MODER.Pin_9 := Output;

   loop
      GPIOB.BSRR := (BS_9 => True, others => False);

      Crude_Delay;

      GPIOB.BSRR := (BR_9 => True, others => False);

      Crude_Delay;
   end loop;
end Main;
