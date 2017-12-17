/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp1dim_api.c
 *
 * Code generation for function '_coder_interp1dim_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1dim.h"
#include "_coder_interp1dim_api.h"
#include "interp1dim_emxutil.h"
#include "interp1dim_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2000000];
static void c_emlrt_marshallIn(const mxArray *xv, const char_T *identifier,
  emxArray_real_T *y);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2000000];
static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))
  [2000000];
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2000000]
{
  real_T (*y)[2000000];
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static void c_emlrt_marshallIn(const mxArray *xv, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(emlrtAlias(xv), &thisId, y);
  emlrtDestroyArray(&xv);
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  f_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2000000]
{
  real_T (*ret)[2000000];
  static const int32_T dims[1] = { 2000000 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  ret = (real_T (*)[2000000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))
  [2000000]
{
  real_T (*y)[2000000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[1] = { 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(1, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u->data[0]);
  emlrtSetDimensions((mxArray *)m0, u->size, 1);
  emlrtAssign(&y, m0);
  return y;
}

static void f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[1] = { -1 };

  const boolean_T bv0[1] = { true };

  int32_T iv1[1];
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims, &bv0[0], iv1);
  ret->size[0] = iv1[0];
  ret->allocatedSize = ret->size[0];
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void interp1dim_api(const mxArray * const prhs[3], const mxArray *plhs[1])
{
  emxArray_real_T *xv;
  emxArray_real_T *yv;
  real_T (*x)[2000000];
  real_T (*z)[2000000];
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&xv, 1, true);
  emxInit_real_T(&yv, 1, true);

  /* Marshall function inputs */
  x = emlrt_marshallIn(emlrtAlias(prhs[0]), "x");
  z = emlrt_marshallIn(emlrtAlias(prhs[1]), "z");
  c_emlrt_marshallIn(emlrtAlias(prhs[2]), "xv", xv);

  /* Invoke the target function */
  interp1dim(*x, *z, xv, yv);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(yv);
  yv->canFreeData = false;
  emxFree_real_T(&yv);
  xv->canFreeData = false;
  emxFree_real_T(&xv);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (_coder_interp1dim_api.c) */
