/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_loccalz_mex.c
 *
 * Code generation for function '_coder_loccalz_mex'
 *
 */

/* Include files */
#include "loccalz.h"
#include "_coder_loccalz_mex.h"
#include "loccalz_terminate.h"
#include "_coder_loccalz_api.h"
#include "loccalz_initialize.h"
#include "loccalz_data.h"

/* Function Declarations */
static void loccalz_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2]);

/* Function Definitions */
static void loccalz_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2])
{
  const mxArray *inputs[2];
  const mxArray *outputs[1];
  int32_T b_nlhs;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 2, 4, 7, "loccalz");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 7,
                        "loccalz");
  }

  /* Temporary copy for mex inputs. */
  if (0 <= nrhs - 1) {
    memcpy((void *)&inputs[0], (void *)&prhs[0], (uint32_T)(nrhs * (int32_T)
            sizeof(const mxArray *)));
  }

  /* Call the function. */
  loccalz_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  loccalz_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(loccalz_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  loccalz_initialize();

  /* Dispatch the entry-point. */
  loccalz_mexFunction(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_loccalz_mex.c) */
