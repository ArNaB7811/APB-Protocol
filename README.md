# APB Slave Module (Verilog)
This repository contains the Verilog implementation and testbench for an APB (Advanced Peripheral Bus) Slave Module. The design follows the APB protocol specification used in ARM AMBA systems for simple peripheral interfaces.

## Files Included
`1` APB_Slave.v: Verilog implementation of the APB slave module.

`2` APB_testbench.v: Testbench to simulate and verify the functionality of the APB slave.

## Features
* Implements standard APB protocol signals:

PADDR, PWDATA, PWRITE, PSEL, PENABLE, PRDATA, PREADY

* Handles both read and write operations.

* Synchronous reset and clock-based data handling.

* Simple internal memory/register simulation for data storage.

# Testbench
The testbench (APB_testbench.v) includes:

* Clock and reset signal generation.

* Randomized data for write operations.

* Multiple test scenarios for verifying:

* Write transactions

* Read transactions

* Timing and protocol behavior

# Output
![image alt](https://github.com/ArNaB7811/APB-Protocol/blob/61de3009a935fd2ab49bf5352d92b35001b7a64a/Screenshot%202025-07-11%20195126.png)
