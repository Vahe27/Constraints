/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4v3_initialize.c
 *
 * Code generation for function 'interp4v3_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v3.h"
#include "interp4v3_initialize.h"
#include "_coder_interp4v3_mex.h"
#include "interp4v3_data.h"

/* Function Definitions */
void interp4v3_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp4v3_initialize.c) */
