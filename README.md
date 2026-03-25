# UVM Memory Verification Testbench

A complete **Universal Verification Methodology (UVM)** based testbench for verifying a synchronous SRAM memory module written in SystemVerilog. The DUT (Design Under Test) is an 8-bit wide, 32-deep memory with a valid/ready handshaking protocol.

---

## 📁 Project Structure

```
├── memory.v              # DUT: Synchronous memory module (8-bit x 32-depth)
├── common.sv             # Shared macros and utility class (match/mismatch counters)
├── mem_tx.sv             # UVM sequence item (transaction object)
├── mem_interf.sv         # SystemVerilog interface with clocking blocks
├── mem_seq.sv            # Sequencer typedef
├── mem_sequence.sv       # Sequence: N writes followed by N reads at same addresses
├── mem_dri.sv            # UVM driver
├── mem_mon.sv            # UVM monitor
├── mem_cov.sv            # UVM coverage collector
├── mem_scb.sv            # UVM scoreboard (reference model)
├── mem_agent.sv          # UVM agent (driver + monitor + coverage + sequencer)
├── mem_env.sv            # UVM environment (agent + scoreboard)
├── mem_assertion.sv      # SVA assertions module (bound to DUT)
├── run_test.sv           # Test classes (base_test, wr_test, Nw_Nr)
├── top.sv                # Top-level testbench module
├── run.do                # QuestaSim compile & simulate script
└── wave.do               # QuestaSim waveform setup script
```

---

## 🧩 DUT Overview

**File:** `memory.v`

| Parameter    | Value         |
|--------------|---------------|
| Data Width   | 8 bits        |
| Depth        | 32 locations  |
| Address Size | 5 bits (clog2)|
| Protocol     | valid / ready handshake |

The memory performs a **write** when `valid=1` and `wr_rd=1`, and a **read** when `valid=1` and `wr_rd=0`. It asserts `ready=1` to acknowledge the transaction.

---

## 🏗️ Testbench Architecture

```
┌─────────────────────────────────────────┐
│                   tb (top)              │
│  ┌──────────────────────────────────┐   │
│  │            mem_env               │   │
│  │  ┌──────────────────────────┐    │   │
│  │  │        mem_agent         │    │   │
│  │  │  ┌────┐ ┌────┐ ┌─────┐   │    │   │
│  │  │  │seq │ │dri │ │ mon │   │    │   │
│  │  │  └────┘ └────┘ └──┬──┘   │    │   │
│  │  │                   │cov   │    │   │
│  │  └───────────────────┼──── ─┘    │   │
│  │                      │           │   │
│  │  ┌───────────────┐   │           │   │
│  │  │   mem_scb     │◄──┘           │   │
│  │  └───────────────┘               │   │
│  └──────────────────────────────────┘   │
│                                         │
│  ┌──────┐    ┌────────────┐             │
│  │  DUT │◄───│ mem_interf │             │
│  │ (mem)│    └────────────┘             │
│  └──┬───┘                               │
│     │ bind                              │
│  ┌──▼──────────┐                        │
│  │ mem_asser   │  (SVA assertions)      │
│  └─────────────┘                        │
└─────────────────────────────────────────┘
```

---

## ✅ Features

- **Full UVM component hierarchy** — transaction, sequencer, driver, monitor, scoreboard, coverage, agent, environment, and test.
- **Valid/Ready handshake protocol** modeled in the driver and monitored in the monitor.
- **Scoreboard** maintains an internal reference memory model and compares read data against expected values, reporting match/mismatch counts.
- **Functional Coverage** on `wr_rd` (read/write bins) and address range via a covergroup.
- **SVA Assertions** bound to the DUT to check that write data and read data are valid (non-X/Z) during acknowledged transactions.
- **Clocking blocks** (`dri_cb`, `mon_cb`) in the interface for proper synchronization.
- **Parameterized** via macros (`WIDTH`, `DEPTH`, `ADDR_SIZE`, `N`).

---

## 🧪 Test Cases

| Test Class  | Description |
|------------ |-------------|
| `base_test` | Base test; builds the environment |
| `wr_test`   | Runs N writes followed by N reads using `mem_sequence` |
| `Nw_Nr`     | Same as `wr_test` but also reports final match/mismatch count in `report_phase` |

The default test run is `Nw_Nr` (configured in `top.sv`).

**Sequence behavior (`mem_sequence`):**
1. Perform `N` randomized write transactions.
2. Perform `N` read transactions to the same addresses written above.
3. Scoreboard verifies each read data matches the written data.

---

## 🚀 How to Run (QuestaSim)

### Prerequisites
- **QuestaSim** (tested with 10.7c)
- **UVM 1.2** library (`uvm-1.2/src`)

### Steps

1. Open QuestaSim and navigate to the project directory.
2. Run the simulation script:
   ```tcl
   do run.do
   ```
   This will:
   - Compile `top.sv` with UVM include path
   - Launch simulation with assertion debug enabled
   - Load the waveform setup (`wave.do`)
   - Run the full simulation

### Adjusting Parameters

Edit `common.sv` to change:
```systemverilog
`define WIDTH    8    // data bus width in bits
`define DEPTH    32   // number of memory locations
`define N        2    // number of write/read pairs per test
```

---

## 📊 Coverage & Assertions

### Functional Coverage (`mem_cov.sv`)
- `wr_rd == 1` → WRITES bin
- `wr_rd == 0` → READS bin
- Address range `[0:DEPTH]` → ADDR bin

### SVA Assertions (`mem_assertion.sv`)
- **write**: On a valid+ready write transaction, `wdata` must be non-unknown.
- **ready_r**: On a valid+ready read transaction, `rdata` must be non-unknown.

---

## 📝 Notes

- The UVM DPI library path in `run.do` is set for Windows (`win64`). Update if running on Linux.
- The `run.do` script assumes UVM 1.2 is located at `C:/UVM/uvm-1.2/src`. Adjust the `+incdir+` path as needed.
- The testbench uses `uvm_config_db` to pass the virtual interface to the driver and monitor.

---

## 📄 License

This project is open-source and free to use for educational and verification practice purposes.
