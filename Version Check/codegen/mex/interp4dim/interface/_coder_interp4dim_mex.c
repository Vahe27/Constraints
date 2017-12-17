/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4dim_mex.c
 *
 * Code generation for function '_coder_interp4dim_mex'
 *
 */

/* Include files */
#include "interp4dim.h"
#include "_coder_interp4dim_mex.h"
#include "interp4dim_terminate.h"
#include "_coder_interp4dim_api.h"
#include "interp4dim_initialize.h"
#include "interp4dim_data.h"

/* Function Declarations */
static void interp4dim_mexFunction(interp4dimStackData *SD, int32_T nlhs,
  mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[12]);

/* Function Definitions */
static void interp4dim_mexFunction(interp4dimStackData *SD, int32_T nlhs,
  mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[12])
{
  const mxArray *inputs[12];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 12) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 12, 4, 10, "interp4dim");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "interp4dim");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  interp4dim_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  interp4dim_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  interp4dimStackData *interp4dimStackDataGlobal = NULL;
  interp4dimStackDataGlobal = (interp4dimStackData *)emlrtMxCalloc(1, 1U *
    sizeof(interp4dimStackData));
  mexAtExit(interp4dim_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  interp4dim_initialize();

  /* Dispatch the entry-point. */
  interp4dim_mexFunction(interp4dimStackDataGlobal, nlhs, plhs, nrhs, prhs);
  emlrtMxFree(interp4dimStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_interp4dim_mex.c) */
