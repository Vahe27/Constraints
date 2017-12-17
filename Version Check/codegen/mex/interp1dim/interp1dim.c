/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1dim.c
 *
 * Code generation for function 'interp1dim'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1dim.h"
#include "interp1dim_emxutil.h"
#include "interp1dim_data.h"

/* Function Definitions */
void interp1dim(const real_T x[2000000], const real_T z[2000000], const
                emxArray_real_T *xv, emxArray_real_T *yv)
{
  emxArray_real_T *indmax;
  int32_T nx;
  int32_T loop_ub;
  emxArray_real_T *indmin;
  emxArray_real_T *tempn;
  int32_T end;
  int32_T b_end;
  int32_T ii;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&indmax, 1, true);

  /*  The only thing you need to make sure for this interpolation is that x is */
  /*  increasing, or non-decreasing */
  nx = indmax->size[0];
  indmax->size[0] = xv->size[0];
  emxEnsureCapacity_real_T(indmax, nx);
  loop_ub = xv->size[0];
  for (nx = 0; nx < loop_ub; nx++) {
    indmax->data[nx] = 2.0E+6;
  }

  emxInit_real_T(&indmin, 1, true);
  nx = indmin->size[0];
  indmin->size[0] = xv->size[0];
  emxEnsureCapacity_real_T(indmin, nx);
  loop_ub = xv->size[0];
  for (nx = 0; nx < loop_ub; nx++) {
    indmin->data[nx] = 1.0;
  }

  emxInit_real_T(&tempn, 1, true);
  end = xv->size[0];
  b_end = xv->size[0];
  for (ii = 0; ii < 21; ii++) {
    nx = tempn->size[0];
    tempn->size[0] = indmax->size[0];
    emxEnsureCapacity_real_T(tempn, nx);
    loop_ub = indmax->size[0];
    for (nx = 0; nx < loop_ub; nx++) {
      tempn->data[nx] = (indmax->data[nx] + indmin->data[nx]) / 2.0;
    }

    nx = tempn->size[0];
    for (loop_ub = 0; loop_ub + 1 <= nx; loop_ub++) {
      tempn->data[loop_ub] = muDoubleScalarFloor(tempn->data[loop_ub]);
    }

    for (nx = 0; nx < end; nx++) {
      if (xv->data[nx] <= x[(int32_T)tempn->data[nx] - 1]) {
        indmax->data[nx] = tempn->data[nx];
      }
    }

    for (nx = 0; nx < b_end; nx++) {
      if (!(xv->data[nx] <= x[(int32_T)tempn->data[nx] - 1])) {
        indmin->data[nx] = tempn->data[nx];
      }
    }
  }

  emxFree_real_T(&tempn);
  nx = yv->size[0];
  yv->size[0] = indmin->size[0];
  emxEnsureCapacity_real_T(yv, nx);
  loop_ub = indmin->size[0];
  for (nx = 0; nx < loop_ub; nx++) {
    yv->data[nx] = z[(int32_T)indmin->data[nx] - 1] + (z[(int32_T)indmax->
      data[nx] - 1] - z[(int32_T)indmin->data[nx] - 1]) * (xv->data[nx] - x
      [(int32_T)indmin->data[nx] - 1]) / (x[(int32_T)indmax->data[nx] - 1] - x
      [(int32_T)indmin->data[nx] - 1]);
  }

  emxFree_real_T(&indmin);
  emxFree_real_T(&indmax);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp1dim.c) */
