/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_loccalz_api.c
 *
 * Code generation for function '_coder_loccalz_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "loccalz.h"
#include "_coder_loccalz_api.h"
#include "loccalz_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[15];
static real_T (*c_emlrt_marshallIn(const mxArray *xv, const char_T *identifier))
  [50000000];
static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[50000000];
static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[15];
static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))[15];
static const mxArray *emlrt_marshallOut(const real_T u[100000000]);
static real_T (*f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[50000000];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[15]
{
  real_T (*y)[15];
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const mxArray *xv, const char_T *identifier))
  [50000000]
{
  real_T (*y)[50000000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(emlrtAlias(xv), &thisId);
  emlrtDestroyArray(&xv);
  return y;
}

static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[50000000]
{
  real_T (*y)[50000000];
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*e_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId))[15]
{
  real_T (*ret)[15];
  static const int32_T dims[1] = { 15 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  ret = (real_T (*)[15])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))[15]
{
  real_T (*y)[15];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}
  static const mxArray *emlrt_marshallOut(const real_T u[100000000])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  static const int32_T iv1[2] = { 50000000, 2 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, iv1, 2);
  emlrtAssign(&y, m0);
  return y;
}

static real_T (*f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[50000000]
{
  real_T (*ret)[50000000];
  static const int32_T dims[1] = { 50000000 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  ret = (real_T (*)[50000000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  void loccalz_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  real_T (*yv)[100000000];
  real_T (*x)[15];
  real_T (*xv)[50000000];
  yv = (real_T (*)[100000000])mxMalloc(sizeof(real_T [100000000]));

  /* Marshall function inputs */
  x = emlrt_marshallIn(emlrtAlias(prhs[0]), "x");
  xv = c_emlrt_marshallIn(emlrtAlias(prhs[1]), "xv");

  /* Invoke the target function */
  loccalz(*x, *xv, *yv);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*yv);
}

/* End of code generation (_coder_loccalz_api.c) */
