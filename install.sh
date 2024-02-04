#!/usr/bin/env bash

for file in work/rv32i_m/I/*.elf.hex; do
  stub=${file%.elf.hex};
  cp ${file} riscv-steel/hardware/core/tests/unit_tests/programs/$(basename $stub).hex;
done
for file in work/rv32i_m/privilege/*.elf.hex; do
  stub=${file%.elf.hex};
  cp ${file} riscv-steel/hardware/core/tests/unit_tests/programs/$(basename $stub).hex;
done
for file in riscv-test-suite/rv32i_m/I/references/*.reference_output; do
  stub=${file%.reference_output};
  cp ${file} riscv-steel/hardware/core/tests/unit_tests/references/$(basename $stub).reference.hex;
done
for file in riscv-test-suite/rv32i_m/privilege/references/*.reference_output; do
  stub=${file%.reference_output};
  cp ${file} riscv-steel/hardware/core/tests/unit_tests/references/$(basename $stub).reference.hex;
done