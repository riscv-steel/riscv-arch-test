#!/bin/bash

printf "Comparing signatures to reference files ... \n\n";
FAIL=0
RUN=0

EXPECTED_FAILS="misalign-beq-01 misalign-bge-01 misalign-bgeu-01 misalign-blt-01 misalign-bltu-01 misalign-bne-01 misalign-jal-01 misalign2-jalr-01"

for ref in ${SUITEDIR}/references/*.reference_output;
do 
    base=$(basename ${ref})
    stub=${base//".reference_output"/}

    if [ "${stub}" = "*" ]; then
        echo "No Reference Files ${SUITEDIR}/references/*.reference_output"
        break
    fi

    sig=${WORK}/rv${XLEN}i_m/${RISCV_DEVICE}/${stub}.signature.output
    dif=${WORK}/rv${XLEN}i_m/${RISCV_DEVICE}/${stub}.diff

    RUN=$((${RUN} + 1))
    
    #
    # Ensure both files exist
    #
    if [ -f ${ref} ] && [ -f ${sig} ]; then 
        echo -n "Check $(printf %-24s ${stub}) "
    else
        echo -e  "Check $(printf %-24s ${stub}) \e[33m ... IGNORE \e[39m"
        continue
    fi
    #diff --ignore-case --strip-trailing-cr ${ref} ${sig} &> /dev/null
    diff --ignore-case --ignore-trailing-space --strip-trailing-cr <(grep -o '^[^#]*' ${ref}) ${sig} &> /dev/null
    if [ $? == 0 ]
    then
        echo -e "\e[32m ... OK \e[39m"
    else
        skip=0
        for ef in ${EXPECTED_FAILS}; do
            if [ ${stub} == ${ef} ]; then
                echo -e "\e[32m ... OK (fail expected) \e[39m"
                skip=1;
                break;
            fi
        done
        if [[ "$skip" -eq 0 ]]; then
          echo -e "\e[31m ... FAIL \e[39m";
          FAIL=$((${FAIL} + 1));
          sdiff ${ref} ${sig} > ${dif};
        fi
    fi
done

# warn on missing reverse reference
for sig in ${WORK}/rv${XLEN}i_m/${RISCV_DEVICE}/*.signature.output; 
do
    base=$(basename ${sig})
    stub=${base//".signature.output"/}
    ref=${SUITEDIR}/references/${stub}.reference_output

    if [ -f $sig ] && [ ! -f ${ref} ]; then
        echo -e "\e[31m Error: sig ${sig} no corresponding ${ref} \e[39m"
        FAIL=$((${FAIL} + 1))
    fi
done

declare -i status=0
if [ ${FAIL} == 0 ]
then
    echo "--------------------------------"
    echo -n -e "\e[32mOK: ${RUN}/${RUN} "
    status=0
else
    echo "--------------------------------"
    echo -n -e "\e[31mFAIL: ${FAIL}/${RUN} "
    status=1
fi
echo -e "RISCV_TARGET=${RISCV_TARGET} RISCV_DEVICE=${RISCV_DEVICE} XLEN=${XLEN} \e[39m"
echo
exit ${status}