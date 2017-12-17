/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_aprimecalc_mex.c
 *
 * Code generation for function '_coder_aprimecalc_mex'
 *
 */

/* Include files */
#include "aprimecalc.h"
#include "_coder_aprimecalc_mex.h"
#include "aprimecalc_terminate.h"
#include "_coder_aprimecalc_api.h"
#include "aprimecalc_initialize.h"
#include "aprimecalc_data.h"

/* Function Declarations */
static void aprimecalc_mexFunction(aprimecalcStackData *SD, int32_T nlhs,
  mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[23]);

/* Function Definitions */
static void aprimecalc_mexFunction(aprimecalcStackData *SD, int32_T nlhs,
  mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[23])
{
  const mxArray *inputs[23];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 23) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 23, 4, 10, "aprimecalc");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "aprimecalc");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  aprimecalc_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  aprimecalc_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  aprimecalcStackData *aprimecalcStackDataGlobal = NULL;
  aprimecalcStackDataGlobal = (aprimecalcStackData *)emlrtMxCalloc(1, 1U *
    sizeof(aprimecalcStackData));
  mexAtExit(aprimecalc_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  aprimecalc_initialize();

  /* Dispatch the entry-point. */
  aprimecalc_mexFunction(aprimecalcStackDataGlobal, nlhs, plhs, nrhs, prhs);
  emlrtMxFree(aprimecalcStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_aprimecalc_mex.c) */
