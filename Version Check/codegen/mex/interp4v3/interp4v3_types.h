/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4v3_types.h
 *
 * Code generation for function 'interp4v3'
 *
 */

#ifndef INTERP4V3_TYPES_H
#define INTERP4V3_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_interp4v3StackData
#define typedef_interp4v3StackData

typedef struct {
  struct {
    real_T yA[200000];
    real_T OCC[200000];
    real_T yN[200000];
    real_T yS[200000];
    real_T yBN[200000];
    real_T yW[200000];
    real_T yBB[200000];
  } f0;
} interp4v3StackData;

#endif                                 /*typedef_interp4v3StackData*/
#endif

/* End of code generation (interp4v3_types.h) */
