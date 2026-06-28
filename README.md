# 8-Bit Accumulator Processor

An 8-bit accumulator-based **Harvard** microprocessor in Verilog, built as a CND internship
team project. Seven instructions (`ADD, SUB, OR, AND, LOAD, STORE, NOP`), single clock, no
branches (the PC just counts up). Target toolchain: **Quartus**; simulated with **Icarus Verilog**.

> Built by an 8-person team — one block each. The golden rule: **use the exact port names from
> [`docs/PORT_SPEC.md`](docs/PORT_SPEC.md)** and the blocks snap together. The top level is
> already wired.

## Repository layout

```
Micro-Processor/
├── rtl/                     # synthesizable design (one module per block)
│   ├── pc.v                 # program counter (up-counter)
│   ├── prog_mem.v           # 256x8 program ROM ($readmemh program.txt)
│   ├── ir.v                 # instruction register
│   ├── control_unit.v       # opcode decoder
│   ├── alu.v                # 4-bit ALU + Z/C flags
│   ├── mux2.v               # 4-bit 2:1 mux (pre-wired)
│   ├── acc.v                # accumulator + flag latch
│   ├── data_mem.v           # 16x4 RAM + memory-mapped I/O
│   └── accumulator_cpu.v    # TOP LEVEL (already wired — don't change ports)
├── tb/                      # one testbench per block + top-level demo bench
├── program.txt             # demo program (loaded by prog_mem)
├── Makefile                # iverilog build/run helpers
└── .gitignore
```

## Block ownership

| Block          | Module             | Effort | Owner |
|----------------|--------------------|--------|-------|
| PC             | `pc`               | XS     |       |
| Program memory | `prog_mem`         | XS     |       |
| IR             | `ir`               | XS     |       |
| Control unit   | `control_unit`     | S      |       |
| ALU            | `alu`              | M      |       |
| Mux            | `mux2`             | XS     |       |
| ACC            | `acc`              | S      |       |
| Data memory    | `data_mem`         | M      |       |

Each owner fills in their module body (skeleton + hints are already in the file) **plus a
self-checking testbench** in `tb/`.

## The demo program

| # | Assembly | Meaning                         | hex |
|---|----------|---------------------------------|-----|
| 0 | LOAD 0   | ACC ← mem[0]                    | 40  |
| 1 | ADD 1    | ACC ← mem[1] + ACC              | 01  |
| 2 | STORE 5  | mem[5] ← ACC                    | 85  |
| 3 | SUB 2    | ACC ← mem[2] − ACC              | 12  |
| 4 | AND 3    | ACC ← mem[3] & ACC              | 23  |
| 5 | OR 4     | ACC ← mem[4] \| ACC             | 34  |
| 6 | STORE F  | out_port ← ACC (0xF)            | 8F  |
| 7 | NOP      | hold                            | F0  |

**Expected result:** `out_port = 6`, `mem[5] = 5`. (The IR is registered, so each result
lands one clock after its instruction is fetched.)

