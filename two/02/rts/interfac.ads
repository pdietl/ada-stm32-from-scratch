package Interfaces is
   pragma Pure;

   type Unsigned_8 is mod 2**8 with
     Size => 8;

   type Unsigned_16 is mod 2**16 with
     Size => 16;

   type Unsigned_32 is mod 2**32 with
     Size => 32;

end Interfaces;
