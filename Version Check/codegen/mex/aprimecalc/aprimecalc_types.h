/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * aprimecalc_types.h
 *
 * Code generation for function 'aprimecalc'
 *
 */

#ifndef APRIMECALC_TYPES_H
#define APRIMECALC_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_aprimecalcStackData
#define typedef_aprimecalcStackData

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
} aprimecalcStackData;

#endif                                 /*typedef_aprimecalcStackData*/
#endif

/* End of code generation (aprimecalc_types.h) */
