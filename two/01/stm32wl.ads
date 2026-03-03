with System;

package STM32WL with
  Pure
is
   pragma Compile_Time_Error
     (System.Storage_Unit /= 8,
      "The peripherals represented in this package assume that Storage_Unit = 8!");
end STM32WL;
