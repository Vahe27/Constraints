/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1dim_emxutil.h
 *
 * Code generation for function 'interp1dim_emxutil'
 *
 */

#ifndef INTERP1DIM_EMXUTIL_H
#define INTERP1DIM_EMXUTIL_H

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
extern void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  boolean_T doPush);

#endif

/* End of code generation (interp1dim_emxutil.h) */
