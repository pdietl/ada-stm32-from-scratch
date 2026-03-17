package System is
   pragma Pure;

   type Address is private;
   Null_Address : constant Address;

   --  Number of bits in smallest addressable unit of memory.
   --  Yypically this is eight bits.
   Storage_Unit : constant := 8;
   Word_Size    : constant := 32;
   Memory_Size  : constant := 2**32;

   --  Minimal priority support (no tasking).
   Max_Priority           : constant := 30;
   Max_Interrupt_Priority : constant := Max_Priority + 1;

   subtype AnyPriority is Integer range 0 .. Max_Interrupt_Priority;
   subtype Priority is AnyPriority range AnyPriority'First .. Max_Priority;
   subtype Interrupt_Priority is
     AnyPriority range Max_Interrupt_Priority .. Max_Interrupt_Priority;

   Default_Priority : constant Priority := 15;

private
   type Address is mod Memory_Size;
   Null_Address : constant Address := 0;
end System;
