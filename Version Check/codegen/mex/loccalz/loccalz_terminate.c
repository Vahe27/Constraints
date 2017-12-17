/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * loccalz_terminate.c
 *
 * Code generation for function 'loccalz_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "loccalz.h"
#include "loccalz_terminate.h"
#include "_coder_loccalz_mex.h"
#include "loccalz_data.h"

/* Function Definitions */
void loccalz_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void loccalz_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (loccalz_terminate.c) */
