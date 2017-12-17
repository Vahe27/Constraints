/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4dim_initialize.c
 *
 * Code generation for function 'interp4dim_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4dim.h"
#include "interp4dim_initialize.h"
#include "_coder_interp4dim_mex.h"
#include "interp4dim_data.h"

/* Function Definitions */
void interp4dim_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp4dim_initialize.c) */
