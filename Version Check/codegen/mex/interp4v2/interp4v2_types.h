/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4v2_types.h
 *
 * Code generation for function 'interp4v2'
 *
 */

#ifndef INTERP4V2_TYPES_H
#define INTERP4V2_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_interp4v2StackData
#define typedef_interp4v2StackData

typedef struct {
  struct {
    real_T y[200000];
    real_T yy[200000];
    real_T yyy[200000];
  } f0;
} interp4v2StackData;

#endif                                 /*typedef_interp4v2StackData*/
#endif

/* End of code generation (interp4v2_types.h) */
