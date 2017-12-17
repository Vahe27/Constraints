/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * aprimecalc_terminate.c
 *
 * Code generation for function 'aprimecalc_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "aprimecalc.h"
#include "aprimecalc_terminate.h"
#include "_coder_aprimecalc_mex.h"
#include "aprimecalc_data.h"

/* Function Definitions */
void aprimecalc_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void aprimecalc_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (aprimecalc_terminate.c) */
