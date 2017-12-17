/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4dim_types.h
 *
 * Code generation for function 'interp4dim'
 *
 */

#ifndef INTERP4DIM_TYPES_H
#define INTERP4DIM_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_interp4dimStackData
#define typedef_interp4dimStackData

typedef struct {
  struct {
    real_T zd[200000];
    real_T ad[200000];
    real_T y[200000];
    real_T yy[200000];
    real_T yyy[200000];
    uint8_T avloc[400000];
  } f0;
} interp4dimStackData;

#endif                                 /*typedef_interp4dimStackData*/
#endif

/* End of code generation (interp4dim_types.h) */
