/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * aprimecalc_initialize.c
 *
 * Code generation for function 'aprimecalc_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "aprimecalc.h"
#include "aprimecalc_initialize.h"
#include "_coder_aprimecalc_mex.h"
#include "aprimecalc_data.h"

/* Function Definitions */
void aprimecalc_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (aprimecalc_initialize.c) */
