with System;

package STM32WL.SYST with
  Preelaborate
is
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

   type TENMS_Field is mod 2**24 with
     Size => 24;

   type CALIB_Register is record
      TENMS : TENMS_Field;
      SKEW  : Boolean;
      NOREF : Boolean;
   end record with
     Size => 32, Volatile_Full_Access;

   for CALIB_Register use record
      TENMS at 0 range  0 .. 23;
      SKEW  at 0 range 30 .. 30;
      NOREF at 0 range 31 .. 31;
   end record;

   type SYST_Peripheral is record
      CSR   : CSR_Register;
      RVR   : RVR_Register;
      CVR   : CVR_Register;
      CALIB : CALIB_Register;
   end record with
     Size => 4 * 32, Alignment => 4, Volatile;

   for SYST_Peripheral use record
      CSR   at 16#00# range 0 .. 31;
      RVR   at 16#04# range 0 .. 31;
      CVR   at 16#08# range 0 .. 31;
      CALIB at 16#0C# range 0 .. 31;
   end record;

   SYST : SYST_Peripheral with
     Import, Address => System'To_Address (16#E000_E010#);

end STM32WL.SYST;
