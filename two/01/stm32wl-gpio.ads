with System;
with Interfaces;

use type Interfaces.Unsigned_32;

package STM32WL.GPIO is
   pragma Preelaborate;

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
      BS_0  : Boolean; -- Set pin 0.
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
      BR_0  : Boolean; -- Clear pin 0.
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
      BS_0  at 0 range  0 ..  0;
      BS_1  at 0 range  1 ..  1;
      BS_2  at 0 range  2 ..  2;
      BS_3  at 0 range  3 ..  3;
      BS_4  at 0 range  4 ..  4;
      BS_5  at 0 range  5 ..  5;
      BS_6  at 0 range  6 ..  6;
      BS_7  at 0 range  7 ..  7;
      BS_8  at 0 range  8 ..  8;
      BS_9  at 0 range  9 ..  9;
      BS_10 at 0 range 10 .. 10;
      BS_11 at 0 range 11 .. 11;
      BS_12 at 0 range 12 .. 12;
      BS_13 at 0 range 13 .. 13;
      BS_14 at 0 range 14 .. 14;
      BS_15 at 0 range 15 .. 15;
      BR_0  at 0 range 16 .. 16;
      BR_1  at 0 range 17 .. 17;
      BR_2  at 0 range 18 .. 18;
      BR_3  at 0 range 19 .. 19;
      BR_4  at 0 range 20 .. 20;
      BR_5  at 0 range 21 .. 21;
      BR_6  at 0 range 22 .. 22;
      BR_7  at 0 range 23 .. 23;
      BR_8  at 0 range 24 .. 24;
      BR_9  at 0 range 25 .. 25;
      BR_10 at 0 range 26 .. 26;
      BR_11 at 0 range 27 .. 27;
      BR_12 at 0 range 28 .. 28;
      BR_13 at 0 range 29 .. 29;
      BR_14 at 0 range 30 .. 30;
      BR_15 at 0 range 31 .. 31;
   end record;

   type GPIO_Peripheral is record
      MODER   : MODER_Register;
      OTYPER  : Interfaces.Unsigned_32;
      OSPEEDR : Interfaces.Unsigned_32;
      PUPDR   : Interfaces.Unsigned_32;
      IDR     : Interfaces.Unsigned_32;
      ODR     : Interfaces.Unsigned_32;
      BSRR    : BSRR_Register;
      LCKR    : Interfaces.Unsigned_32;
      AFRL    : Interfaces.Unsigned_32;
      AFRH    : Interfaces.Unsigned_32;
      BRR     : Interfaces.Unsigned_32;
   end record with
     Size => 11 * 32;

   for GPIO_Peripheral use record
      MODER   at 16#00# range 0 .. 31;
      OTYPER  at 16#04# range 0 .. 31;
      OSPEEDR at 16#08# range 0 .. 31;
      PUPDR   at 16#0C# range 0 .. 31;
      IDR     at 16#10# range 0 .. 31;
      ODR     at 16#14# range 0 .. 31;
      BSRR    at 16#18# range 0 .. 31;
      LCKR    at 16#1C# range 0 .. 31;
      AFRL    at 16#20# range 0 .. 31;
      AFRH    at 16#24# range 0 .. 31;
      BRR     at 16#28# range 0 .. 31;
   end record;

   GPIOB : GPIO_Peripheral with
     Volatile, Import, Address => System'To_Address (16#4800_0400#);

end STM32WL.GPIO;
