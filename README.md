# RISC-V Steel Architecture Tests

This repository contains the unit tests used to verify the correct implementation of the RISC-V specifications by RISC-V Steel Processor Core IP. It is a fork of the [RISC-V Architecture Test] repository with all the required adaptations to run the tests on RISC-V Steel.

RISC-V Steel currently uses the `old-framework-2.x` as its test framework. It will soon move to the newer [RISCOF].

## How to run the tests

### Pre-requisites

This test framework assumes you have the [RISC-V GNU Toolchain] installed in `/opt/riscv`.

- RISC-V Steel [Software Guide] contains instructions on how to install and configure the [RISC-V GNU Toolchain].

You will also need [Verilator] version 5.021 or higher. The Verilator binary must be added to your `PATH`.

- You find the steps to install the latest version of [Verilator] in its [Documentation] webpage.

### Instructions

Once you have the pre-requisites installed, run from a terminal:

```
git clone https://github.com/riscv-steel/riscv-arch-test
cd riscv-arch-test
git submodule update --init
make
```

[RISC-V Architecture Test]: https://github.com/riscv-non-isa/riscv-arch-test
[RISCOF]: https://riscof.readthedocs.io/en/stable/
[RISC-V GNU Toolchain]: https://github.com/riscv-collab/riscv-gnu-toolchain
[Software Guide]: https://riscv-steel.github.io/riscv-steel/software_guide/
[Verilator]: https://veripool.org/guide/latest/install.html
[Documentation]: https://veripool.org/guide/latest/install.html
