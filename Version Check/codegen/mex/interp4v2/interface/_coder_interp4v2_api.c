/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4v2_api.c
 *
 * Code generation for function '_coder_interp4v2_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v2.h"
#include "_coder_interp4v2_api.h"
#include "interp4v2_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[15];
static real_T (*c_emlrt_marshallIn(const mxArray *a, const char_T *identifier))
  [130];
static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[130];
static int8_T (*e_emlrt_marshallIn(const mxArray *zind, const char_T *identifier))
  [400000];
static real_T (*emlrt_marshallIn(const mxArray *z, const char_T *identifier))[15];
static const mxArray *emlrt_marshallOut(const real_T u[600000]);
static int8_T (*f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[400000];
static real_T (*g_emlrt_marshallIn(const mxArray *probind, const char_T
  *identifier))[400000];
static real_T (*h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[400000];
static real_T (*i_emlrt_marshallIn(const mxArray *V, const char_T *identifier))
  [48750];
static real_T (*j_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[48750];
static real_T (*k_emlrt_marshallIn(const mxArray *zv, const char_T *identifier))
  [200000];
static real_T (*l_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[200000];
static real_T (*m_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[15];
static real_T (*n_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[130];
static int8_T (*o_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[400000];
static real_T (*p_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[400000];
static real_T (*q_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[48750];
static real_T (*r_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[200000];

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[15]
{
  real_T (*y)[15];
  y = m_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const mxArray *a, const char_T *identifier))
  [130]
{
  real_T (*y)[130];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(emlrtAlias(a), &thisId);
  emlrtDestroyArray(&a);
  return y;
}

static real_T (*d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[130]
{
  real_T (*y)[130];
  y = n_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static int8_T (*e_emlrt_marshallIn(const mxArray *zind, const char_T
  *identifier))[400000]
{
  int8_T (*y)[400000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(emlrtAlias(zind), &thisId);
  emlrtDestroyArray(&zind);
  return y;
}

static real_T (*emlrt_marshallIn(const mxArray *z, const char_T *identifier))[15]
{
  real_T (*y)[15];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(z), &thisId);
  emlrtDestroyArray(&z);
  return y;
}
  static const mxArray *emlrt_marshallOut(const real_T u[600000])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  static const int32_T iv1[2] = { 200000, 3 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, iv1, 2);
  emlrtAssign(&y, m0);
  return y;
}

static int8_T (*f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[400000]
{
  int8_T (*y)[400000];
  y = o_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*g_emlrt_marshallIn(const mxArray *probind, const char_T
  *identifier))[400000]
{
  real_T (*y)[400000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = h_emlrt_marshallIn(emlrtAlias(probind), &thisId);
  emlrtDestroyArray(&probind);
  return y;
}

static real_T (*h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[400000]
{
  real_T (*y)[400000];
  y = p_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*i_emlrt_marshallIn(const mxArray *V, const char_T *identifier))
  [48750]
{
  real_T (*y)[48750];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = j_emlrt_marshallIn(emlrtAlias(V), &thisId);
  emlrtDestroyArray(&V);
  return y;
}

static real_T (*j_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[48750]
{
  real_T (*y)[48750];
  y = q_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*k_emlrt_marshallIn(const mxArray *zv, const char_T *identifier))
  [200000]
{
  real_T (*y)[200000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = l_emlrt_marshallIn(emlrtAlias(zv), &thisId);
  emlrtDestroyArray(&zv);
  return y;
}

static real_T (*l_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[200000]
{
  real_T (*y)[200000];
  y = r_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*m_emlrt_marshallIn(const mxArray *src, const
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

static real_T (*n_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[130]
{
  real_T (*ret)[130];
  static const int32_T dims[2] = { 1, 130 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  ret = (real_T (*)[130])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static int8_T (*o_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId))[400000]
{
  int8_T (*ret)[400000];
  static const int32_T dims[2] = { 200000, 2 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "int8", false, 2U,
    dims);
  ret = (int8_T (*)[400000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*p_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[400000]
{
  real_T (*ret)[400000];
  static const int32_T dims[2] = { 200000, 2 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  ret = (real_T (*)[400000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*q_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId))[48750]
{
  real_T (*ret)[48750];
  static const int32_T dims[4] = { 15, 130, 5, 5 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 4U,
    dims);
  ret = (real_T (*)[48750])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*r_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[200000]
{
  real_T (*ret)[200000];
  static const int32_T dims[1] = { 200000 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  ret = (real_T (*)[200000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  void interp4v2_api(interp4v2StackData *SD, const mxArray * const prhs[12],
                     const mxArray *plhs[1])
{
  real_T (*yf)[600000];
  real_T (*z)[15];
  real_T (*a)[130];
  int8_T (*zind)[400000];
  real_T (*probind)[400000];
  real_T (*kapind)[400000];
  real_T (*V)[48750];
  real_T (*X)[48750];
  real_T (*Y)[48750];
  real_T (*zv)[200000];
  real_T (*av)[200000];
  real_T (*probd)[200000];
  real_T (*kapd)[200000];
  yf = (real_T (*)[600000])mxMalloc(sizeof(real_T [600000]));

  /* Marshall function inputs */
  z = emlrt_marshallIn(emlrtAlias(prhs[0]), "z");
  a = c_emlrt_marshallIn(emlrtAlias(prhs[1]), "a");
  zind = e_emlrt_marshallIn(emlrtAlias(prhs[2]), "zind");
  probind = g_emlrt_marshallIn(emlrtAlias(prhs[3]), "probind");
  kapind = g_emlrt_marshallIn(emlrtAlias(prhs[4]), "kapind");
  V = i_emlrt_marshallIn(emlrtAlias(prhs[5]), "V");
  X = i_emlrt_marshallIn(emlrtAlias(prhs[6]), "X");
  Y = i_emlrt_marshallIn(emlrtAlias(prhs[7]), "Y");
  zv = k_emlrt_marshallIn(emlrtAlias(prhs[8]), "zv");
  av = k_emlrt_marshallIn(emlrtAlias(prhs[9]), "av");
  probd = k_emlrt_marshallIn(emlrtAlias(prhs[10]), "probd");
  kapd = k_emlrt_marshallIn(emlrtAlias(prhs[11]), "kapd");

  /* Invoke the target function */
  interp4v2(SD, *z, *a, *zind, *probind, *kapind, *V, *X, *Y, *zv, *av, *probd, *
            kapd, *yf);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*yf);
}

/* End of code generation (_coder_interp4v2_api.c) */
