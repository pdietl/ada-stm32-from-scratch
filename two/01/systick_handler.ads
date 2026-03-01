package SysTick_Handler is
   pragma Preelaborate;

   procedure SysTick_Handler with
     Export, Convention => C, External_Name => "_systick_handler";

end SysTick_Handler;
