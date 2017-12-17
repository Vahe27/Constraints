/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1dim.h
 *
 * Code generation for function 'interp1dim'
 *
 */

#ifndef INTERP1DIM_H
#define INTERP1DIM_H

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
#include "interp1dim_types.h"

/* Function Declarations */
extern void interp1dim(const real_T x[2000000], const real_T z[2000000], const
  emxArray_real_T *xv, emxArray_real_T *yv);

#endif

/* End of code generation (interp1dim.h) */
