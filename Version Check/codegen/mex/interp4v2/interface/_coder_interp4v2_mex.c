/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4v2_mex.c
 *
 * Code generation for function '_coder_interp4v2_mex'
 *
 */

/* Include files */
#include "interp4v2.h"
#include "_coder_interp4v2_mex.h"
#include "interp4v2_terminate.h"
#include "_coder_interp4v2_api.h"
#include "interp4v2_initialize.h"
#include "interp4v2_data.h"

/* Function Declarations */
static void interp4v2_mexFunction(interp4v2StackData *SD, int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[12]);

/* Function Definitions */
static void interp4v2_mexFunction(interp4v2StackData *SD, int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[12])
{
  const mxArray *inputs[12];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 12) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 12, 4, 9, "interp4v2");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 9,
                        "interp4v2");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  interp4v2_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  interp4v2_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  interp4v2StackData *interp4v2StackDataGlobal = NULL;
  interp4v2StackDataGlobal = (interp4v2StackData *)emlrtMxCalloc(1, 1U * sizeof
    (interp4v2StackData));
  mexAtExit(interp4v2_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  interp4v2_initialize();

  /* Dispatch the entry-point. */
  interp4v2_mexFunction(interp4v2StackDataGlobal, nlhs, plhs, nrhs, prhs);
  emlrtMxFree(interp4v2StackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_interp4v2_mex.c) */
