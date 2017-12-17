/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1dim_terminate.c
 *
 * Code generation for function 'interp1dim_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1dim.h"
#include "interp1dim_terminate.h"
#include "_coder_interp1dim_mex.h"
#include "interp1dim_data.h"

/* Function Definitions */
void interp1dim_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void interp1dim_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (interp1dim_terminate.c) */
