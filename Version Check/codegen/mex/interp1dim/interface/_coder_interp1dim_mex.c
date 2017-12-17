/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp1dim_mex.c
 *
 * Code generation for function '_coder_interp1dim_mex'
 *
 */

/* Include files */
#include "interp1dim.h"
#include "_coder_interp1dim_mex.h"
#include "interp1dim_terminate.h"
#include "_coder_interp1dim_api.h"
#include "interp1dim_initialize.h"
#include "interp1dim_data.h"

/* Function Declarations */
static void interp1dim_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[3]);

/* Function Definitions */
static void interp1dim_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[3])
{
  const mxArray *inputs[3];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 3, 4, 10, "interp1dim");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "interp1dim");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  interp1dim_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  interp1dim_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(interp1dim_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  interp1dim_initialize();

  /* Dispatch the entry-point. */
  interp1dim_mexFunction(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_interp1dim_mex.c) */
