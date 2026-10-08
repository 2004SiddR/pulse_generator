# Verilog Pulse Generator Design & Behavioral Simulation

A Verilog implementation of a synchronous modulo-11 pulse generator (counter-based) designed and simulated using AMD Xilinx Vivado.

---

##  Project Overview

This project implements a **Modulo-11 Pulse Generator** in Verilog HDL. The module increments a 4-bit register (`q`) on every positive clock edge. When the counter reaches `10` (`4'd10` or hex `a`), it asserts a single-cycle high output signal (`pulse`) and resets the internal state to `0` on the next active edge.

### Key Features
- **Module Architecture**: Synchronous 4-bit counter with active-high synchronous reset.
- **Pulse Generation**: Output `pulse` goes High for exactly 1 clock period whenever `q == 10`.
- **Target FPGA Architecture**: AMD Artix-7 (XC7A35TCPG236-1).

---

##  Module Interface & Logic

### Module Port List

| Signal Name | Direction | Type   | Description                                |
| :---        | :---      | :---   | :---                                       |
| `clk`       | Input     | Wire   | System Clock Input                         |
| `reset`     | Input     | Wire   | Synchronous Active-High Reset              |
| `q[3:0]`    | Output    | Reg    | 4-bit Counter Output State (`0` to `10`)   |
| `pulse`     | Output    | Wire   | Single-cycle active-high pulse output      |

### Next-State & Output Logic
```verilog
assign q_next = (q == 10) ? 4'd0 : q + 4'd1;  
assign pulse  = (q == 10) ? 1'b1 : 1'b0;  
```

---

##  Synthesized Design Architecture

The synthesized RTL netlist maps the Verilog logic into physical Xilinx FPGA primitives, including flip-flops (`FDRE`), lookup tables (`LUT1` through `LUT5`), and I/O buffers (`IBUF`, `OBUF`).

<img width="947" height="482" alt="schematic" src="https://github.com/user-attachments/assets/d53e09cf-de5c-4671-9df1-c938c6bf9dbf" />


---

##  Simulation & Waveform Analysis

The design was verified using behavioral simulation in Vivado with a 50 MHz clock  (T = 20ns).

<img width="956" height="203" alt="waveform" src="https://github.com/user-attachments/assets/77a3c743-feaa-45b4-97b2-0d1b201c8a3f" />


### Key Observations:
1. **Reset Behavior**: When `reset = 1`, `q` resets synchronously to `0`.
2. **Counting Cycle**: `q` increments sequentially from `0` to `9` and then to `a` (10).
3. **Pulse Generation**: The `pulse` output asserts high precisely when `q = a` (10) and drops back to `0` when `q` wraps around to `0`.

---

##  How to Run

1. Open **AMD Vivado 2024.1** (or compatible version).
2. Create a new RTL Project targeting the **Artix-7 XC7A35TCPG236-1** board/part.
3. Add `pulse_generator_design.v` to **Design Sources**.
4. Add `pulse_generator_tb.v` to **Simulation Sources**.
5. Click on **Run Simulation** > **Run Behavioral Simulation**.
