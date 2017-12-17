/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4v3_mex.c
 *
 * Code generation for function '_coder_interp4v3_mex'
 *
 */

/* Include files */
#include "interp4v3.h"
#include "_coder_interp4v3_mex.h"
#include "interp4v3_terminate.h"
#include "_coder_interp4v3_api.h"
#include "interp4v3_initialize.h"
#include "interp4v3_data.h"

/* Function Declarations */
static void interp4v3_mexFunction(interp4v3StackData *SD, int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[23]);

/* Function Definitions */
static void interp4v3_mexFunction(interp4v3StackData *SD, int32_T nlhs, mxArray *
  plhs[1], int32_T nrhs, const mxArray *prhs[23])
{
  const mxArray *inputs[23];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 23) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 23, 4, 9, "interp4v3");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 9,
                        "interp4v3");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  interp4v3_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  interp4v3_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  interp4v3StackData *interp4v3StackDataGlobal = NULL;
  interp4v3StackDataGlobal = (interp4v3StackData *)emlrtMxCalloc(1, 1U * sizeof
    (interp4v3StackData));
  mexAtExit(interp4v3_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  interp4v3_initialize();

  /* Dispatch the entry-point. */
  interp4v3_mexFunction(interp4v3StackDataGlobal, nlhs, plhs, nrhs, prhs);
  emlrtMxFree(interp4v3StackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_interp4v3_mex.c) */
