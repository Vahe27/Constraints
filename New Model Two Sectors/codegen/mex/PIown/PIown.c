/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * PIown.c
 *
 * Code generation for function 'PIown'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "PIown.h"
#include "PIown_emxutil.h"
#include "power.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 6,     /* lineNo */
  "PIown",                             /* fcnName */
  "C:\\Users\\vkrrikya\\Desktop\\SecondProject\\A simple model\\LMclearing\\New Model Two Sectors\\PIown.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  14,                                  /* colNo */
  "PIown",                             /* fName */
  "C:\\Users\\vkrrikya\\Desktop\\SecondProject\\A simple model\\LMclearing\\New Model Two Sectors\\PIown.m"/* pName */
};

static emlrtDCInfo emlrtDCI = { 4,     /* lineNo */
  11,                                  /* colNo */
  "PIown",                             /* fName */
  "C:\\Users\\vkrrikya\\Desktop\\SecondProject\\A simple model\\LMclearing\\New Model Two Sectors\\PIown.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 4,   /* lineNo */
  11,                                  /* colNo */
  "PIown",                             /* fName */
  "C:\\Users\\vkrrikya\\Desktop\\SecondProject\\A simple model\\LMclearing\\New Model Two Sectors\\PIown.m",/* pName */
  1                                    /* checkKind */
};

/* Function Definitions */
void PIown(PIownStackData *SD, const emlrtStack *sp, const real_T z[3011600],
           const real_T inv[3011600], const real_T payk[3011600], real_T alfa,
           real_T deltta, real_T Gama, real_T n, emxArray_real_T *y)
{
  int32_T i0;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  if (!(n >= 0.0)) {
    emlrtNonNegativeCheckR2012b(n, &emlrtDCI, sp);
  }

  if (n != (int32_T)muDoubleScalarFloor(n)) {
    emlrtIntegerCheckR2012b(n, &b_emlrtDCI, sp);
  }

  st.site = &emlrtRSI;
  power(&st, inv, alfa, SD->f0.dv0);
  i0 = y->size[0] * y->size[1];
  y->size[0] = 15058;
  y->size[1] = 200;
  emxEnsureCapacity_real_T(sp, y, i0, &emlrtRTEI);
  for (i0 = 0; i0 < 3011600; i0++) {
    y->data[i0] = (Gama * z[i0] * SD->f0.dv0[i0] + (1.0 - deltta) * inv[i0]) -
      payk[i0];
  }
}

/* End of code generation (PIown.c) */
