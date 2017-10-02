/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * PIown.h
 *
 * Code generation for function 'PIown'
 *
 */

#ifndef PIOWN_H
#define PIOWN_H

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
#include "PIown_types.h"

/* Function Declarations */
extern void PIown(PIownStackData *SD, const emlrtStack *sp, const real_T z
                  [3011600], const real_T inv[3011600], const real_T payk
                  [3011600], real_T alfa, real_T deltta, real_T Gama, real_T n,
                  emxArray_real_T *y);

#endif

/* End of code generation (PIown.h) */
