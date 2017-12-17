/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4v3_terminate.c
 *
 * Code generation for function 'interp4v3_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v3.h"
#include "interp4v3_terminate.h"
#include "_coder_interp4v3_mex.h"
#include "interp4v3_data.h"

/* Function Definitions */
void interp4v3_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void interp4v3_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (interp4v3_terminate.c) */
