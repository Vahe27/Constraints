/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * loccalz.h
 *
 * Code generation for function 'loccalz'
 *
 */

#ifndef LOCCALZ_H
#define LOCCALZ_H

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
#include "loccalz_types.h"

/* Function Declarations */
extern void loccalz(const real_T x[15], const real_T xv[50000000], real_T yv
                    [100000000]);

#endif

/* End of code generation (loccalz.h) */
