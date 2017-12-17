/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * loccalz_initialize.c
 *
 * Code generation for function 'loccalz_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "loccalz.h"
#include "loccalz_initialize.h"
#include "_coder_loccalz_mex.h"
#include "loccalz_data.h"

/* Function Definitions */
void loccalz_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (loccalz_initialize.c) */
