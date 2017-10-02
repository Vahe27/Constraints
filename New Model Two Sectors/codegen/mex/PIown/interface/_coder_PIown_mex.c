/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_PIown_mex.c
 *
 * Code generation for function '_coder_PIown_mex'
 *
 */

/* Include files */
#include "PIown.h"
#include "_coder_PIown_mex.h"
#include "PIown_terminate.h"
#include "_coder_PIown_api.h"
#include "PIown_initialize.h"
#include "PIown_data.h"

/* Function Declarations */
static void PIown_mexFunction(PIownStackData *SD, int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[7]);

/* Function Definitions */
static void PIown_mexFunction(PIownStackData *SD, int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[7])
{
  int32_T n;
  const mxArray *inputs[7];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 7) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 7, 4, 5,
                        "PIown");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 5,
                        "PIown");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  PIown_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  PIown_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  PIownStackData *PIownStackDataGlobal = NULL;
  PIownStackDataGlobal = (PIownStackData *)emlrtMxCalloc(1, 1U * sizeof
    (PIownStackData));
  mexAtExit(PIown_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  PIown_initialize();

  /* Dispatch the entry-point. */
  PIown_mexFunction(PIownStackDataGlobal, nlhs, plhs, nrhs, prhs);
  emlrtMxFree(PIownStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_PIown_mex.c) */
