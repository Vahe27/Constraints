/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_PIown_api.c
 *
 * Code generation for function '_coder_PIown_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "PIown.h"
#include "_coder_PIown_api.h"
#include "PIown_emxutil.h"
#include "PIown_data.h"

/* Variable Definitions */
static emlrtRTEInfo b_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_PIown_api",                  /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[3011600];
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *alfa,
  const char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3011600];
static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *z, const
  char_T *identifier))[3011600];
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[3011600]
{
  real_T (*y)[3011600];
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *alfa,
  const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(alfa), &thisId);
  emlrtDestroyArray(&alfa);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[3011600]
{
  real_T (*ret)[3011600];
  static const int32_T dims[2] = { 15058, 200 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[3011600])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *z, const
  char_T *identifier))[3011600]
{
  real_T (*y)[3011600];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(z), &thisId);
  emlrtDestroyArray(&z);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u->data[0]);
  emlrtSetDimensions((mxArray *)m0, u->size, 2);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void PIown_api(PIownStackData *SD, const mxArray * const prhs[7], const mxArray *
               plhs[1])
{
  emxArray_real_T *y;
  real_T (*z)[3011600];
  real_T (*inv)[3011600];
  real_T (*payk)[3011600];
  real_T alfa;
  real_T deltta;
  real_T Gama;
  real_T n;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &y, 2, &b_emlrtRTEI, true);

  /* Marshall function inputs */
  z = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "z");
  inv = emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "inv");
  payk = emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "payk");
  alfa = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "alfa");
  deltta = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "deltta");
  Gama = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[5]), "Gama");
  n = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[6]), "n");

  /* Invoke the target function */
  PIown(SD, &st, *z, *inv, *payk, alfa, deltta, Gama, n, y);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(y);
  y->canFreeData = false;
  emxFree_real_T(&y);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_PIown_api.c) */
