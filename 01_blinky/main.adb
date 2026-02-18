with System;
with Interfaces; use type Interfaces.Unsigned_32;

procedure Main is

   RCC_AHB2ENR : Interfaces.Unsigned_32
     with Volatile, Address => System'To_Address (16#5800_004C#);

   GPIOB_MODER : Interfaces.Unsigned_32
     with Volatile, Address => System'To_Address (16#4800_0400#);

   GPIOB_BSRR : Interfaces.Unsigned_32
     with Volatile, Address => System'To_Address (16#4800_0418#);

   procedure Crude_Delay is
     Counter : Interfaces.Unsigned_32 := 0
        with Volatile;
   begin
     for I in 1 .. 100_000 loop
       Counter := Counter + 1;
     end loop;
   end Crude_Delay;

begin

   RCC_AHB2ENR := RCC_AHB2ENR or 16#0000_0002#;

   GPIOB_MODER := (GPIOB_MODER and not 16#C000_0000#) or 16#4000_0000#;

   loop
      GPIOB_BSRR := 16#0000_8000#;

      Crude_Delay;

      GPIOB_BSRR := 16#8000_0000#;

      Crude_Delay;
   end loop;

end Main;
