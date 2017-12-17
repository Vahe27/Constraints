/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp4dim.c
 *
 * Code generation for function 'interp4dim'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4dim.h"

/* Function Definitions */
void interp4dim(interp4dimStackData *SD, const real_T z[15], const real_T a[130],
                const int8_T zind[400000], const real_T probind[400000], const
                real_T kapind[400000], const real_T V[48750], const real_T X
                [48750], const real_T Y[48750], const real_T zv[200000], const
                real_T av[200000], const real_T probd[200000], const real_T
                kapd[200000], real_T yf[600000])
{
  int32_T jj;
  int32_T amin;
  int32_T amax;
  int32_T tempn;

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
    amin = 1;
    amax = 130;

    /* if jj>1 */
    /*  if av(jj)>av(jj-1) */
    /*      amax = na; */
    /* amin = tempn; */
    /*  else */
    /* amax = tempn; */
    /*      amin = 1; */
    /*  end */
    /*  end */
    while (amax > amin + 1) {
      tempn = (int32_T)muDoubleScalarFloor((real_T)(amax + amin) / 2.0);
      if (av[jj] > a[tempn - 1]) {
        amin = tempn;
      } else {
        amax = tempn;
      }
    }

    SD->f0.avloc[jj] = (uint8_T)amin;
    SD->f0.avloc[200000 + jj] = (uint8_T)amax;
    SD->f0.zd[jj] = (zv[jj] - z[zind[jj] - 1]) / (z[zind[200000 + jj] - 1] -
      z[zind[jj] - 1]);
    SD->f0.ad[jj] = (av[jj] - a[amin - 1]) / (a[amax - 1] - a[amin - 1]);

    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /*  (4) Next convex for prob */
    /*  (5) Final convex for kappa */
    SD->f0.y[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - SD->f0.ad[jj])
      * ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) +
      1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]
         + SD->f0.zd[jj] * V[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1))
      + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) -
         1]) + SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) +
      9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * V[(((zind[200000
      + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1])) + probd[jj] *
      ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 *
      (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
      9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * V[(((zind[200000
      + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[200000 +
      jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]) + SD->f0.ad[jj] *
       ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj]
      - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * V[(((zind[200000 + jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] -
      1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 -
      probd[jj]) * ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * V
      [(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] *
      V[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) +
                    SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) +
      9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * V
      [(((zind[200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 *
         ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1))
      - 1])) + probd[jj] * ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * V
      [(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] +
      SD->f0.zd[jj] * V[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) +
                          1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
                         ((int32_T)kapind[200000 + jj] - 1)) - 1]) + SD->
      f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * V[(((zind[jj] + 15 * (SD->f0.avloc
      [200000 + jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * V[(((zind
      [200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[200000 + jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) -
                   1])));

    /*  FOR X */
    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /* iad = 1-ad(jj); */
    /*  (4) Next convex for prob */
    /* iprobd = 1-probd(jj); */
    /*  (5) Final convex for kappa */
    SD->f0.yy[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - SD->f0.ad[jj])
      * ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) +
      1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]
         + SD->f0.zd[jj] * X[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1))
      + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) -
         1]) + SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) +
      9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * X[(((zind[200000
      + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1])) + probd[jj] *
      ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 *
      (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
      9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * X[(((zind[200000
      + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[200000 +
      jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]) + SD->f0.ad[jj] *
       ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj]
      - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * X[(((zind[200000 + jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] -
      1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 -
      probd[jj]) * ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * X
      [(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] *
      X[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) +
                    SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) +
      9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * X
      [(((zind[200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 *
         ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1))
      - 1])) + probd[jj] * ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * X
      [(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] +
      SD->f0.zd[jj] * X[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) +
                          1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
                         ((int32_T)kapind[200000 + jj] - 1)) - 1]) + SD->
      f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * X[(((zind[jj] + 15 * (SD->f0.avloc
      [200000 + jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * X[(((zind
      [200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[200000 + jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) -
                   1])));

    /*  FOR Y */
    /*  (2) convex for z */
    /*  (3) Next convex for a */
    /* iad = 1-ad(jj); */
    /*  (4) Next convex for prob */
    /* iprobd = 1-probd(jj); */
    /*  (5) Final convex for kappa */
    SD->f0.yyy[jj] = (1.0 - kapd[jj]) * ((1.0 - probd[jj]) * ((1.0 - SD->
      f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * Y[(((zind[jj] + 15 * (SD->
      f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1] + SD->f0.zd[jj] * Y[(((zind[200000 + jj] + 15 *
      (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 *
      ((int32_T)kapind[jj] - 1)) - 1]) + SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) *
      Y[(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->f0.zd[jj]
      * Y[(((zind[200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 *
            ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1]))
      + probd[jj] * ((1.0 - SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * Y
      [(((zind[jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind
      [200000 + jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] + SD->
      f0.zd[jj] * Y[(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 *
                      ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1]) + SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * Y
      [(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[200000 + jj] - 1)) + 9750 * ((int32_T)kapind[jj] - 1)) - 1] +
      SD->f0.zd[jj] * Y[(((zind[200000 + jj] + 15 * (SD->f0.avloc[200000 + jj] -
      1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)
      kapind[jj] - 1)) - 1]))) + kapd[jj] * ((1.0 - probd[jj]) * ((1.0 -
      SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * Y[(((zind[jj] + 15 *
      (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 *
      ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * Y[(((zind
      [200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[jj]
      - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1]) + SD->f0.ad[jj] *
      ((1.0 - SD->f0.zd[jj]) * Y[(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj] -
      1)) + 1950 * ((int32_T)probind[jj] - 1)) + 9750 * ((int32_T)kapind[200000
      + jj] - 1)) - 1] + SD->f0.zd[jj] * Y[(((zind[200000 + jj] + 15 *
      (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)probind[jj] - 1)) +
      9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1])) + probd[jj] * ((1.0 -
      SD->f0.ad[jj]) * ((1.0 - SD->f0.zd[jj]) * Y[(((zind[jj] + 15 *
      (SD->f0.avloc[jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) +
      9750 * ((int32_T)kapind[200000 + jj] - 1)) - 1] + SD->f0.zd[jj] * Y
                        [(((zind[200000 + jj] + 15 * (SD->f0.avloc[jj] - 1)) +
      1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)kapind
      [200000 + jj] - 1)) - 1]) + SD->f0.ad[jj] * ((1.0 - SD->f0.zd[jj]) * Y
      [(((zind[jj] + 15 * (SD->f0.avloc[200000 + jj] - 1)) + 1950 * ((int32_T)
      probind[200000 + jj] - 1)) + 9750 * ((int32_T)kapind[200000 + jj] - 1)) -
      1] + SD->f0.zd[jj] * Y[(((zind[200000 + jj] + 15 * (SD->f0.avloc[200000 +
      jj] - 1)) + 1950 * ((int32_T)probind[200000 + jj] - 1)) + 9750 * ((int32_T)
      kapind[200000 + jj] - 1)) - 1])));
    yf[jj] = SD->f0.y[jj];
    yf[200000 + jj] = SD->f0.yy[jj];
    yf[400000 + jj] = SD->f0.yyy[jj];
  }
}

/* End of code generation (interp4dim.c) */
