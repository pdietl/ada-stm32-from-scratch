package System is
   pragma Pure;

   type Address is private;
   Null_Address : constant Address;

   Storage_Unit : constant := 8;       -- bits per byte
   Word_Size    : constant := 32;      -- bits per word
   Memory_Size  : constant := 2 ** 32; -- addressable memory

   --  priority support (minimal, no tasking)

   Max_Priority           : constant := 30;
   Max_Interrupt_Priority : constant := 31;

   subtype Any_Priority       is Integer      range 0  .. 31;
   subtype Priority           is Any_Priority range 0  .. 30;
   subtype Interrupt_Priority is Any_Priority range 31 .. 31;

   Default_Priority : constant Priority := 15;

private
   type Address is mod Memory_Size;
   Null_Address : constant Address := 0;
end System;
