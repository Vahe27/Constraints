/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1dim_initialize.c
 *
 * Code generation for function 'interp1dim_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1dim.h"
#include "interp1dim_initialize.h"
#include "_coder_interp1dim_mex.h"
#include "interp1dim_data.h"

/* Function Definitions */
void interp1dim_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp1dim_initialize.c) */
