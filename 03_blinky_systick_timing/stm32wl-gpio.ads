with System;
with Interfaces;

use type Interfaces.Unsigned_32;

package STM32WL.GPIO is
   type Pin_Mode is (Input, Output, Alternate, Analog) with
     Size => 2;
   for Pin_Mode use
     (Input => 2#00#, Output => 2#01#, Alternate => 2#10#, Analog => 2#11#);

   type MODER_Register is record
      Pin_0  : Pin_Mode;
      Pin_1  : Pin_Mode;
      Pin_2  : Pin_Mode;
      Pin_3  : Pin_Mode;
      Pin_4  : Pin_Mode;
      Pin_5  : Pin_Mode;
      Pin_6  : Pin_Mode;
      Pin_7  : Pin_Mode;
      Pin_8  : Pin_Mode;
      Pin_9  : Pin_Mode;
      Pin_10 : Pin_Mode;
      Pin_11 : Pin_Mode;
      Pin_12 : Pin_Mode;
      Pin_13 : Pin_Mode;
      Pin_14 : Pin_Mode;
      Pin_15 : Pin_Mode;
   end record with
     Size => 32, Volatile_Full_Access;

   for MODER_Register use record
      Pin_0  at 0 range  0 ..  1;
      Pin_1  at 0 range  2 ..  3;
      Pin_2  at 0 range  4 ..  5;
      Pin_3  at 0 range  6 ..  7;
      Pin_4  at 0 range  8 ..  9;
      Pin_5  at 0 range 10 .. 11;
      Pin_6  at 0 range 12 .. 13;
      Pin_7  at 0 range 14 .. 15;
      Pin_8  at 0 range 16 .. 17;
      Pin_9  at 0 range 18 .. 19;
      Pin_10 at 0 range 20 .. 21;
      Pin_11 at 0 range 22 .. 23;
      Pin_12 at 0 range 24 .. 25;
      Pin_13 at 0 range 26 .. 27;
      Pin_14 at 0 range 28 .. 29;
      Pin_15 at 0 range 30 .. 31;
   end record;

   type BSRR_Register is record
      BS_0  : Boolean;
      BS_1  : Boolean;
      BS_2  : Boolean;
      BS_3  : Boolean;
      BS_4  : Boolean;
      BS_5  : Boolean;
      BS_6  : Boolean;
      BS_7  : Boolean;
      BS_8  : Boolean;
      BS_9  : Boolean;
      BS_10 : Boolean;
      BS_11 : Boolean;
      BS_12 : Boolean;
      BS_13 : Boolean;
      BS_14 : Boolean;
      BS_15 : Boolean;
      BR_0  : Boolean;
      BR_1  : Boolean;
      BR_2  : Boolean;
      BR_3  : Boolean;
      BR_4  : Boolean;
      BR_5  : Boolean;
      BR_6  : Boolean;
      BR_7  : Boolean;
      BR_8  : Boolean;
      BR_9  : Boolean;
      BR_10 : Boolean;
      BR_11 : Boolean;
      BR_12 : Boolean;
      BR_13 : Boolean;
      BR_14 : Boolean;
      BR_15 : Boolean;
   end record with
     Size => 32, Volatile_Full_Access;

   for BSRR_Register use record
   end record;

end STM32WL.GPIO;
