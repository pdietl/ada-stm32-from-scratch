with System;
with Interfaces;

use type Interfaces.Unsigned_32;

package STM32WL.RCC is
   pragma Preelaborate;

   type AHB2ENR_Register is record
      GPIOAEN : Boolean;
      GPIOBEN : Boolean;
      GPIOCEN : Boolean;
      GPIOHEN : Boolean;
   end record with
     Size => 32, Volatile_Full_Access;

   for AHB2ENR_Register use record
      GPIOAEN at 0 range 0 .. 0;
      GPIOBEN at 0 range 1 .. 1;
      GPIOCEN at 0 range 2 .. 2;
      GPIOHEN at 0 range 7 .. 7;
   end record;

   type RCC_Peripheral is record
      CR           : Interfaces.Unsigned_32;
      ICSCR        : Interfaces.Unsigned_32;
      CFGR         : Interfaces.Unsigned_32;
      PLLCFGR      : Interfaces.Unsigned_32;
      CIER         : Interfaces.Unsigned_32;
      CIFR         : Interfaces.Unsigned_32;
      CICR         : Interfaces.Unsigned_32;
      AHB1RSTR     : Interfaces.Unsigned_32;
      AHB2RSTR     : Interfaces.Unsigned_32;
      AHB3RSTR     : Interfaces.Unsigned_32;
      APB1RSTR1    : Interfaces.Unsigned_32;
      APB1RSTR2    : Interfaces.Unsigned_32;
      APB2RSTR     : Interfaces.Unsigned_32;
      APB3RSTR     : Interfaces.Unsigned_32;
      AHB1ENR      : Interfaces.Unsigned_32;
      AHB2ENR      : AHB2ENR_Register;
      AHB3ENR      : Interfaces.Unsigned_32;
      APB1ENR1     : Interfaces.Unsigned_32;
      APB1ENR2     : Interfaces.Unsigned_32;
      APB2ENR      : Interfaces.Unsigned_32;
      APB3ENR      : Interfaces.Unsigned_32;
      AHB1SMENR    : Interfaces.Unsigned_32;
      AHB2SMENR    : Interfaces.Unsigned_32;
      AHB3SMENR    : Interfaces.Unsigned_32;
      APB1SMENR1   : Interfaces.Unsigned_32;
      APB1SMENR2   : Interfaces.Unsigned_32;
      APB2SMENR    : Interfaces.Unsigned_32;
      APB3SMENR    : Interfaces.Unsigned_32;
      CCIPR        : Interfaces.Unsigned_32;
      BDCR         : Interfaces.Unsigned_32;
      CSR          : Interfaces.Unsigned_32;
      EXTCFGR      : Interfaces.Unsigned_32;
      C2AHB1ENR    : Interfaces.Unsigned_32;
      C2AHB2ENR    : Interfaces.Unsigned_32;
      C2AHB3ENR    : Interfaces.Unsigned_32;
      C2APB1ENR1   : Interfaces.Unsigned_32;
      C2APB1ENR2   : Interfaces.Unsigned_32;
      C2APB2ENR    : Interfaces.Unsigned_32;
      C2APB3ENR    : Interfaces.Unsigned_32;
      C2AHB1SMENR  : Interfaces.Unsigned_32;
      C2AHB2SMENR  : Interfaces.Unsigned_32;
      C2AHB3SMENR  : Interfaces.Unsigned_32;
      C2APB1SMENR1 : Interfaces.Unsigned_32;
      C2APB1SMENR2 : Interfaces.Unsigned_32;
      C2APB2SMENR  : Interfaces.Unsigned_32;
      C2APB3SMENR  : Interfaces.Unsigned_32;
   end record with
     Size => 16#188# * 8;

   for RCC_Peripheral use record
      CR           at 16#000# range 0 .. 31;
      ICSCR        at 16#004# range 0 .. 31;
      CFGR         at 16#008# range 0 .. 31;
      PLLCFGR      at 16#00C# range 0 .. 31;
      -- 0x010 - 0x014 reserved
      CIER         at 16#018# range 0 .. 31;
      CIFR         at 16#01C# range 0 .. 31;
      CICR         at 16#020# range 0 .. 31;
      -- 0x024 reserved
      AHB1RSTR     at 16#028# range 0 .. 31;
      AHB2RSTR     at 16#02C# range 0 .. 31;
      AHB3RSTR     at 16#030# range 0 .. 31;
      -- 0x034 reserved
      APB1RSTR1    at 16#038# range 0 .. 31;
      APB1RSTR2    at 16#03C# range 0 .. 31;
      APB2RSTR     at 16#040# range 0 .. 31;
      APB3RSTR     at 16#044# range 0 .. 31;
      AHB1ENR      at 16#048# range 0 .. 31;
      AHB2ENR      at 16#04C# range 0 .. 31;
      AHB3ENR      at 16#050# range 0 .. 31;
      -- 0x054 reserved
      APB1ENR1     at 16#058# range 0 .. 31;
      APB1ENR2     at 16#05C# range 0 .. 31;
      APB2ENR      at 16#060# range 0 .. 31;
      APB3ENR      at 16#064# range 0 .. 31;
      AHB1SMENR    at 16#068# range 0 .. 31;
      AHB2SMENR    at 16#06C# range 0 .. 31;
      AHB3SMENR    at 16#070# range 0 .. 31;
      -- 0x074 reserved
      APB1SMENR1   at 16#078# range 0 .. 31;
      APB1SMENR2   at 16#07C# range 0 .. 31;
      APB2SMENR    at 16#080# range 0 .. 31;
      APB3SMENR    at 16#084# range 0 .. 31;
      CCIPR        at 16#088# range 0 .. 31;
      -- 0x08C reserved
      BDCR         at 16#090# range 0 .. 31;
      CSR          at 16#094# range 0 .. 31;
      -- 0x098 - 0x104 reserved
      EXTCFGR      at 16#108# range 0 .. 31;
      -- 0x10C - 0x144 reserved
      C2AHB1ENR    at 16#148# range 0 .. 31;
      C2AHB2ENR    at 16#14C# range 0 .. 31;
      C2AHB3ENR    at 16#150# range 0 .. 31;
      -- 0x154 reserved
      C2APB1ENR1   at 16#158# range 0 .. 31;
      C2APB1ENR2   at 16#15C# range 0 .. 31;
      C2APB2ENR    at 16#160# range 0 .. 31;
      C2APB3ENR    at 16#164# range 0 .. 31;
      C2AHB1SMENR  at 16#168# range 0 .. 31;
      C2AHB2SMENR  at 16#16C# range 0 .. 31;
      C2AHB3SMENR  at 16#170# range 0 .. 31;
      -- 0x174 reserved
      C2APB1SMENR1 at 16#178# range 0 .. 31;
      C2APB1SMENR2 at 16#17C# range 0 .. 31;
      C2APB2SMENR  at 16#180# range 0 .. 31;
      C2APB3SMENR  at 16#184# range 0 .. 31;
   end record;

   RCC : RCC_Peripheral with
     Volatile, Import, Address => System'To_Address (16#5800_0000#);

end STM32WL.RCC;
