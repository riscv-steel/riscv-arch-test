#ifndef _COMPLIANCE_MODEL_H
#define _COMPLIANCE_MODEL_H

#define RVMODEL_HALT                                      \
  /* tell simulation about location of begin_signature */ \
  la t0, begin_signature;                                 \
  li t1, 0x00001ffc;                                      \
  sw t0, 0(t1);                                           \
  /* tell simulation about location of end_signature */   \
  la t0, end_signature;                                   \
  li t1, 0x00001ff8;                                      \
  sw t0, 0(t1);                                           \
  /* tell simulation that test has ended */               \
  li t0, 1;                                               \
  li t1, 0x00001000;                                      \
  sw t0, 0(t1);                                           \
  eternal_loop:                                           \
  j eternal_loop;

#define RVMODEL_DATA_BEGIN \
  .align 4;                \
  .global begin_signature; \
  begin_signature:

#define RVMODEL_DATA_END \
  .align 4;              \
  .global end_signature; \
  end_signature:

// Unused macros
#define RVMODEL_SET_MSW_INT
#define RVMODEL_CLEAR_MSW_INT
#define RVMODEL_CLEAR_MTIMER_INT
#define RVMODEL_CLEAR_MEXT_INT
#define RVMODEL_BOOT
#define RVMODEL_IO_WRITE_STR(_SP, _STR)
#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)

#endif // _COMPLIANCE_MODEL_H
