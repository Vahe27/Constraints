/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * aprimecalc.h
 *
 * Code generation for function 'aprimecalc'
 *
 */

#ifndef APRIMECALC_H
#define APRIMECALC_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "aprimecalc_types.h"

/* Function Declarations */
extern void aprimecalc(aprimecalcStackData *SD, const real_T z[15], const real_T
  a[130], const int8_T zind[400000], const real_T probind[400000], const real_T
  kapind[400000], const real_T V[48750], const real_T X[48750], const real_T Y
  [48750], const real_T W[48750], const real_T Z[48750], const real_T zv[200000],
  const real_T av[200000], const real_T probd[200000], const real_T kapd[200000],
  const real_T BE[200000], const real_T PB[200000], const real_T WA[48750],
  const real_T NA[48750], const real_T SA[48750], const real_T BNA[48750], const
  real_T BBA[48750], real_T Kmin, real_T Kmax, real_T yf[1400000]);

#endif

/* End of code generation (aprimecalc.h) */
