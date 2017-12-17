/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4dim.h
 *
 * Code generation for function 'interp4dim'
 *
 */

#ifndef INTERP4DIM_H
#define INTERP4DIM_H

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
#include "interp4dim_types.h"

/* Function Declarations */
extern void interp4dim(interp4dimStackData *SD, const real_T z[15], const real_T
  a[130], const int8_T zind[400000], const real_T probind[400000], const real_T
  kapind[400000], const real_T V[48750], const real_T X[48750], const real_T Y
  [48750], const real_T zv[200000], const real_T av[200000], const real_T probd
  [200000], const real_T kapd[200000], real_T yf[600000]);

#endif

/* End of code generation (interp4dim.h) */
