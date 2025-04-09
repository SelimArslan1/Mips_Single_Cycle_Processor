# MIPS Single-Cycle Processor (SystemVerilog)

This project is a 32-bit single-cycle MIPS processor implemented in **SystemVerilog**. It follows the architecture and design principles from the book _Digital Design and Computer Architecture_ by **David Money Harris and Sarah L. Harris**.

## Overview

The processor supports a subset of the MIPS instruction set, including:
- **R-type** instructions (e.g., `add`, `sub`, `and`, `or`, `slt`)
- **I-type** instructions (e.g., `lw`, `sw`, `beq`, `addi`)
- **J-type** instructions (`j`)
- New R-Type **jalsub** instruction

The entire datapath, control logic, and memory interfaces are implemented in SystemVerilog.
