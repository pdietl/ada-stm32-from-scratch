with System;

package STM32WL.SYST is
   pragma Preelaborate;

   type Clock_Source is (External, Processor) with
     Size => 1;

   for Clock_Source use (External => 0, Processor => 1);

   type CSR_Register is record
      ENABLE    : Boolean;
      TICKINT   : Boolean;
      CLKSOURCE : Clock_Source;
      COUNTFLAG : Boolean;
   end record with
     Size => 32, Volatile_Full_Access;

   for CSR_Register use record
      ENABLE    at 0 range  0 ..  0;
      TICKINT   at 0 range  1 ..  1;
      CLKSOURCE at 0 range  2 ..  2;
      COUNTFLAG at 0 range 16 .. 16;
   end record;

   type RVR_Register is mod 2**24 with
     Size => 32, Volatile_Full_Access;

   type CVR_Register is mod 2**24 with
     Size => 32, Volatile_Full_Access;

   type SYST_Peripheral is record
      CSR : CSR_Register;
      RVR : RVR_Register;
      CVR : CVR_Register;
   end record with
     Size => 3 * 32;

   for SYST_Peripheral use record
      CSR at 16#00# range 0 .. 31;
      RVR at 16#04# range 0 .. 31;
      CVR at 16#08# range 0 .. 31;
   end record;

   SYST : SYST_Peripheral with
     Volatile, Import, Address => System'To_Address (16#E000_E010#);

end STM32WL.SYST;
