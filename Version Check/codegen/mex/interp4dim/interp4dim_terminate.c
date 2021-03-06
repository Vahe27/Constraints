/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4dim_terminate.c
 *
 * Code generation for function 'interp4dim_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4dim.h"
#include "interp4dim_terminate.h"
#include "_coder_interp4dim_mex.h"
#include "interp4dim_data.h"

/* Function Definitions */
void interp4dim_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void interp4dim_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (interp4dim_terminate.c) */
