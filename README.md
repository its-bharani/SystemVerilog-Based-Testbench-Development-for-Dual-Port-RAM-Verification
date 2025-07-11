# SystemVerilog-Based-Testbench-Development-for-Dual-Port-RAM-Verification
---

##  Introduction

This project involves the **design and verification** of a synchronous **RAM** module using **SystemVerilog**. The RAM has separate **read** and **write** ports and supports:

- **64-bit data width**
- **12-bit address width** (4096 memory locations)
- **Concurrent read and write operations**
- **Synchronous operation with clock**

The main objective is to ensure the **functional correctness** of the design using a **self-checking testbench** and to measure both **functional coverage** and **code coverage** simulated in **QUESTASIM**. This verification environment follows a modular, UVM-style architecture but is built manually using SystemVerilog constructs for clarity and learning purposes.

---

##  Testbench Components

The testbench includes the following components:

###  Transaction Class
- Defines a transaction with fields: `wr`, `rd`, `wr_add`, `rd_add`, `in`, `out`.
- Includes constraints to generate only valid read/write operations.

###  Generator
- Randomly generates valid `reg_trans` objects.
- Sends transactions to the write driver via a mailbox.

###  Write Driver
- Drives input signals (`wr`, `wr_add`, `in`) to the DUT based on the transaction received.

###  Read Driver
- Drives read address and `rd` signal to the DUT for triggering read operations.

###  Write Monitor
- Observes and captures write-related activity on the DUT inputs.
- Sends observed transactions to the reference model if needed.

###  Read Monitor
- Captures output data from the DUT when a read occurs.
- Sends actual read results to the scoreboard.

###  Reference Model
- Models the behavior of an ideal RAM.
- Computes expected outputs for given read transactions.

### Scoreboard
- Compares the DUT's output with the reference model's expected output.
- Flags mismatches for debug.

### Environment
- Instantiates and connects all components using mailboxes.
- Coordinates data flow among generator, drivers, monitors, scoreboard, and reference model.

### Test
- Starts the environment and triggers generation of multiple transactions.
- Gathers functional and code coverage at the end.

---

## Results

| Metric              | Status   |
|---------------------|----------|
| Functional Coverage | 94% +    |
| Code Coverage       | 100%     |
| Errors              | 0        |
| Warnings            | 0        |
| Assertion Failures  | 0        |

## CODE COVERAGE

<img width="1919" height="926" alt="image" src="https://github.com/user-attachments/assets/cf3c6512-61cc-46b5-abdb-4d6cd4d9d227" />


<img width="1907" height="909" alt="image" src="https://github.com/user-attachments/assets/ae01e17d-df5d-4edc-88c9-e7658d247ba0" />


## FUNCTIONAL COVERAGE

<img width="1110" height="276" alt="image" src="https://github.com/user-attachments/assets/4c2a2c1a-2657-48eb-98ba-18bcd006f0cd" />

## SIMULATION RESULTS

<img width="1138" height="915" alt="image" src="https://github.com/user-attachments/assets/46919a28-85d9-4164-9358-4d9631e94c6b" />




