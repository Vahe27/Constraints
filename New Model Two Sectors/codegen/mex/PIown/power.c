/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.c
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "PIown.h"
#include "power.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo b_emlrtRSI = { 49,  /* lineNo */
  "power",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 61,  /* lineNo */
  "power",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

/* Function Definitions */
void power(const emlrtStack *sp, const real_T a[3011600], real_T b, real_T y
           [3011600])
{
  int32_T k;
  boolean_T p;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &b_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  for (k = 0; k < 3011600; k++) {
    y[k] = muDoubleScalarPower(a[k], b);
  }

  if ((!muDoubleScalarIsNaN(b)) && (muDoubleScalarFloor(b) != b)) {
    p = true;
  } else {
    p = false;
  }

  if (p) {
    p = false;
    for (k = 0; k < 3011600; k++) {
      if (p || (a[k] < 0.0)) {
        p = true;
      } else {
        p = false;
      }
    }
  } else {
    p = false;
  }

  if (p) {
    b_st.site = &c_emlrtRSI;
    c_st.site = &c_emlrtRSI;
    error(&c_st);
  }
}

/* End of code generation (power.c) */
