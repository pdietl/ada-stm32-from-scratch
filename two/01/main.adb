with STM32WL.GPIO;
with STM32WL.RCC;
with STM32WL.SYST;

with SysTick_Handler;

pragma Unreferenced (SysTick_Handler);

use STM32WL.GPIO;
use STM32WL.RCC;
use STM32WL.SYST;

procedure Main is

   procedure Configure_SysTick is
   begin
      -- First disable the system timer.
      SYST.CSR.ENABLE := False;
      -- Next set the reload value (register value is **unknown** on reset).
      SYST.RVR        := 399_999;
      -- Writing anything to SYST_CVR clears both the register and the
      -- COUNTFLAG status bit (in the SYST_CSR register) to zero. This
      -- causes the SysTick logic to reload SYST_CVR from SYST_RVR on
      -- the next timer clock tick.
      SYST.CVR        := 0;
      -- Fire up the timer!
      SYST.CSR        :=
        (ENABLE => True, TICKINT => True, CLKSOURCE => Processor,
         others => False);
   end Configure_SysTick;

begin
   -- Enable GPIOB peripheral clock.
   RCC.AHB2ENR := (GPIOBEN => True, others => False);

   -- Configure PB9, PB11, PB15 as outputs (Green, Red, Blue LEDs).
   GPIOB.MODER.Pin_9  := Output;
   GPIOB.MODER.Pin_11 := Output;
   GPIOB.MODER.Pin_15 := Output;

   Configure_SysTick;

   -- The SysTick handler takes it from here.
   loop
      null;
   end loop;
end Main;
