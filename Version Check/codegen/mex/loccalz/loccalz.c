/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * loccalz.c
 *
 * Code generation for function 'loccalz'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "loccalz.h"

/* Function Definitions */
void loccalz(const real_T x[15], const real_T xv[50000000], real_T yv[100000000])
{
  int32_T indmax;
  int32_T indmin;
  int32_T tempn;
  int32_T jj;

  /*  Calculates the locations of continuous variables on a given grid, for */
  /*  interpolation */
  /* yd     = zeros(nxv,1); */
  indmax = 15;
  indmin = 1;
  while (indmax > indmin + 1) {
    tempn = (int32_T)muDoubleScalarFloor((real_T)(indmax + indmin) / 2.0);
    if (xv[0] > x[tempn - 1]) {
      indmin = tempn;
    } else {
      indmax = tempn;
    }
  }

  yv[0] = (int8_T)indmin;
  yv[50000000] = (int8_T)indmax;

  /* yd(1)   = (xv(1) - x(indmin))/(x(indmax)-x(indmin)); */
  for (jj = 0; jj < 49999999; jj++) {
    if (xv[jj + 1] > xv[jj]) {
      indmax = 15;

      /* indmin = indmin; */
    } else {
      /* indmax = indmax; */
      indmin = 1;
    }

    while (indmax > indmin + 1) {
      tempn = (int32_T)muDoubleScalarFloor((real_T)(indmax + indmin) / 2.0);
      if (xv[jj + 1] > x[tempn - 1]) {
        indmin = tempn;
      } else {
        indmax = tempn;
      }
    }

    yv[jj + 1] = (int8_T)indmin;
    yv[jj + 50000001] = (int8_T)indmax;

    /* yd(jj)   = (xv(jj) - x(indmin))/(x(indmax)-x(indmin)); */
  }
}

/* End of code generation (loccalz.c) */
