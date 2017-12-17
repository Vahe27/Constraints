/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4v2_info.c
 *
 * Code generation for function '_coder_interp4v2_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v2.h"
#include "_coder_interp4v2_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 12);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("interp4v2"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar
                (12.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[11] = {
    "789ced5b4f6fe2461477b6bbd95d556dadae5ab5eaa1a8aa566a23e12c2181eca540200b0949f89714586d1b630f309b19dbd886424ff90855ab1e2a55eab9a7"
    "edb1c79caa7e81f6d0533f423f420df6243065045dbc26108f84c6c3cf9edf9ba7e7df1b9e0db7923958e138ee4debd3efd777b8417bc3ee38dee96f71a38dc6",
    "579cfe756a4cda1deef6c87504ffd1e925553141d7b407082ae0b08d6b40b7068a88c1e534b28aa1222a66a9a7014e07868a3a401e2075884009629055870669"
    "680df0ee107439e843fde39d2690ce8a6dcce94de3ca5c343ce086fc73c158ffed29fdf305c33f3c853f4d3ddb792c1c1b403784ce99aec3b39e2824817166aa",
    "9a500496bbe49cae3e079229c40306c41a0201acca0009d903090151874a4338b1ae86aa1218ac51809687752ddc0905f1d57a3486bdab53aee7163526ed3e75"
    "bedd366376bf1523fc5dc6fcd3faf31d063f4fe192e51b3d38708122a220024ac36c72577e387d493be8c6b28334c2f7cb4bf291f90f27f011fc69265b1e8492",
    "152d0d5dc4817ecc1bc241bc948d27844268fd51a42698aa8a6a6a5700180d3e6b036f096bc45d82edaee1b83965d8376ddcd03d69f7b97be470f7c5833fe31e"
    "f20dda4de1f3eabe2b654faadb582eebf1cfc391eea38d13bc7eb83f64476e02cf243b38c6d8abf92f18d72f6a3e60c5c5b471f81a633d241fbc37fce5f951cc",
    "3e28d87dac109b558f09ef3d6acc5d9e672358976107cac02dbe556a7cc56723b2daae21e09efeef31f946f1ffadff08d6042c9a48ac09aa6608c44f4167a3e0"
    "a15e7dffdbb3a5d6ff1f12efff31b7f579a5ffdd4ab59a6ac4a1de0a77706ab35489e79f8bdcf2e8bf7f1f8fb77f34eefef9cc2d9dbdcbe0e31dc459e6ccfbfa",
    "79e97a86c9378acf1a0f241cb0339f77f170fedd6a7e7ebab7ec7c5ee97af4ab7cfdb81cde8aa43ba8b09d8c46b3eab1c4f9ba7e5dee636feb3a1fc5ecfee1e5"
    "fefd9c31ffb4fefb90c1cf533855d78146a20d9199510edb18e8509a5b1ef87546be32936f1477a7be43bb2d883dcc073ffdfd979f0fae6b3e7897c1c753f851",
    "a7b513afa73bd1523edc93525809ed5651dacf07d7251f9c32ec7337ee3e754dff030c3e9ec229fd37241181aeb6a3624d34a1a5c8f3d2ff8b19f92a4cbe51dc"
    "1dfdff8fdbe6113f7ebdff15f27995079ab2a657cb5fa7a44624998df436da623c1f4df879e066e581c7ae3ddf7d9bc1c753389507acd5dbdf2f6a1d689fc937",
    "8abba3ff96bb9c48f1f57e39f8bcd2fb4622d193231ba954b51beaa4f74b3059d10b4bb4efbf605cbfa8cf774f19f6ba1a87e747ae3dc7bdc3e0e31da48e54b5"
    "ff96d8a2eabc17fb0180ea6d4518786a1efb819f630ffdfacea2eb7cb415392ab55072f32cd12ce59f14cd563229ed2e8fcefbf7f178fb47e32ee0d7f79d73fc",
    "fafef89e34bfbeef0d9f5fdf77677e5fffc7db3f1a771fbba6ff1f30f8780a1f53df17f520d9f5cfeffdfd59f5ff78021fc1ddd1ff35db6f43b1e3a1fe7f3bcf"
    "f71c979dcf2bfdaf35b7726505997251c5a9b692dea8a5127b4f7cfdbfa9faff0d63be69fdf509838fa7704aff454d43bde240cc76db8a644255c92839244ae4",
    "2f8293de7f9ad6beb726d847f0ba63c5974d5191d1d57ba7bfcfc85f9bc04f7077f203dbad24d03c8cb317c6a6ff5c60d1f345766f5faab472dbf1ca41583742"
    "1a0c75227bc9e5c917fefd3d7e5dd3c56370e97e47ccab8ee4ff8e78557c76bb297cfeef88d9e6ff17bf1d0a95",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 17224U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_interp4v2_info.c) */
