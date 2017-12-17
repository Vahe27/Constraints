/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4v2.c
 *
 * Code generation for function 'interp4v2'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v2.h"

/* Function Definitions */
void interp4v2(interp4v2StackData *SD, const real_T z[15], const real_T a[130],
               const int8_T zind[400000], const real_T probind[400000], const
               real_T kapind[400000], const real_T V[48750], const real_T X
               [48750], const real_T Y[48750], const real_T zv[200000], const
               real_T av[200000], const real_T probd[200000], const real_T kapd
               [200000], real_T yf[600000])
{
  int32_T amax;
  int32_T amin;
  int32_T jj;
  real_T zd;
  int32_T tempn;
  real_T ad;

  /* { */
  /*  z-zgrid */
  /* a-agrid */
  /* zind-zloc */
  /* probind-probloc */
  /* kapind-kaploc */
  /* V-Valfunc */
  /* zv-BIGZ */
  /* av-BIGA */
  /* probd-(bigprob-P(imin))/(P(imax)-P(imin)) */
  /* kapd-(bigkap-kapgrid(imin))/(kapgrid(imax)-kapgrid(imin)) */
  /* } */
  /*  I assume I know already the brackets for z, p shock and kappa, which */
  /*  means I only need to find the brackets for a, given BIGA. */
  /*  (1) Calculate the locations of a */
  /*  num of grid points */
  /*  num of interpolation points */
  amax = 129;
  amin = 0;

  /* { */
  /* while amax>amin+1 */
  /*  */
  /* tempn = floor((amax+amin)/2); */
  /*  */
  /* if av(1)>a(tempn) */
  /*     amin = tempn; */
  /* else */
  /*     amax = tempn; */
  /* end */
  /*  end */
  /*   */
  /*  avloc(1,:) = [amin amax]; */
  /*  zd(1)      = (zv(1) - z(zind(1,1)))/(z(zind(1,2)) - z(zind(1,1))); */
  /*  ad(1)      = (av(1) - a(amin(1)))/(a(amax(1)) - a(amin(1))); */
  /*  */
  /*   */
  /* yv(1) = z(indmin) + dzdx(indmax)*(xv(1)-x(indmin)); */
  /* } */
  for (jj = 0; jj < 200000; jj++) {
    if (1 + jj > 1) {
      if (av[jj] > av[jj - 1]) {
        amax = 129;

        /* amin = tempn; */
      } else {
        /* amax = tempn; */
        amin = 0;
      }
    }

    while (amax + 1 > amin + 2) {
      tempn = (int32_T)muDoubleScalarFloor((real_T)((amax + amin) + 2) / 2.0) -
        1;
      if (av[jj] > a[tempn]) {
        amin = tempn;
      } else {
        amax = tempn;
      }
    }

    zd = (zv[jj] - z[zind[jj] - 1]) / (z[zind[200000 + jj] - 1] - z[zind[jj] - 1]);
    ad = (av[jj] - a[amin]) / (a[amax] - a[amin]);

    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /*  (4) Next convex for prob */
    /*  (5) Final convex for kappa */
    SD->f0.y[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - ad) * ((1.0 -
      zd) * V[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) +
               9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * V[(((zind[200000 +
      jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) * V[(((zind[jj] + 15 * amax) +
      1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]
      + zd * V[(((zind[200000 + jj] + 15 * amax) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad)
      * ((1.0 - zd) * V[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * V
         [(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 +
      jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) *
      V[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * V[(((zind[200000 + jj] +
      15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 - probd[jj]) * ((1.0
      - ad) * ((1.0 - zd) * V[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd *
               V[(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd)
      * V[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 *
           ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * V[(((zind[200000 + jj]
      + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[200000 + jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad) * ((1.0 - zd) *
      V[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * V[(((zind[200000
      + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd) * V
      [(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
        9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * V[(((zind[200000
      + jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1])));

    /*  FOR X */
    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /* iad = 1-ad(jj); */
    /*  (4) Next convex for prob */
    /* iprobd = 1-probd(jj); */
    /*  (5) Final convex for kappa */
    SD->f0.yy[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - ad) * ((1.0
      - zd) * X[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) +
                 9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * X[(((zind[200000
      + jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) * X[(((zind[jj] + 15 * amax) +
      1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]
      + zd * X[(((zind[200000 + jj] + 15 * amax) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad)
      * ((1.0 - zd) * X[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * X
         [(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 +
      jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) *
      X[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * X[(((zind[200000 + jj] +
      15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 - probd[jj]) * ((1.0
      - ad) * ((1.0 - zd) * X[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd *
               X[(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd)
      * X[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 *
           ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * X[(((zind[200000 + jj]
      + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[200000 + jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad) * ((1.0 - zd) *
      X[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * X[(((zind[200000
      + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd) * X
      [(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
        9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * X[(((zind[200000
      + jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1])));

    /*  FOR Y */
    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /* iad = 1-ad(jj); */
    /*  (4) Next convex for prob */
    /* iprobd = 1-probd(jj); */
    /*  (5) Final convex for kappa */
    SD->f0.yyy[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - ad) * ((1.0
      - zd) * Y[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) +
                 9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * Y[(((zind[200000
      + jj] + 15 * amin) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) * Y[(((zind[jj] + 15 * amax) +
      1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]
      + zd * Y[(((zind[200000 + jj] + 15 * amax) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad)
      * ((1.0 - zd) * Y[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * Y
         [(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 +
      jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]) + ad * ((1.0 - zd) *
      Y[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[jj] - 1)) - 1] + zd * Y[(((zind[200000 + jj] +
      15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 - probd[jj]) * ((1.0
      - ad) * ((1.0 - zd) * Y[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd *
               Y[(((zind[200000 + jj] + 15 * amin) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd)
      * Y[(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 *
           ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * Y[(((zind[200000 + jj]
      + 15 * amax) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[200000 + jj] - 1)) - 1])) + probd[jj] * ((1.0 - ad) * ((1.0 - zd) *
      Y[(((zind[jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
         9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * Y[(((zind[200000
      + jj] + 15 * amin) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1]) + ad * ((1.0 - zd) * Y
      [(((zind[jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
        9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + zd * Y[(((zind[200000
      + jj] + 15 * amax) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1])));
    yf[jj] = SD->f0.y[jj];
    yf[200000 + jj] = SD->f0.yy[jj];
    yf[400000 + jj] = SD->f0.yyy[jj];
  }
}

/* End of code generation (interp4v2.c) */
