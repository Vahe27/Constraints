/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_loccalz_info.c
 *
 * Code generation for function '_coder_loccalz_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "loccalz.h"
#include "_coder_loccalz_info.h"

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
  xInputs = emlrtCreateLogicalMatrix(1, 2);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("loccalz"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(2.0));
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
    "789ced5b4f6fe344147757bba52b045420100824228456824af1366d37e95ec8df6edaa6dda6494b9265c53af62499ed8cedd84e48f6d48f80401c909038735a"
    "8e1c7b427c013870e223f01170ecbc36f16694b0f13a6d3a4faa26332f9edf9b9f9e7f6f32768585edbd054110deb4ff7a6d2c2538f686db08cbfdf686306c5e",
    "ff42bf7dddd307bb25dc1cba0efc3ff55b59532dd4b1dc0ec12ada6fd12a32ec8e2a51743e8da251ac4aaa55ecea483090a99136521c4f0d1354c414e5b4814e"
    "16db1dba35e03aeff45cbdcfa906924f0a2d2a180df3225c32d81106f83963acffe684fc7cc5e067b93f06fe4799c7a9fbe291890c536c9f18063ee94a621a99",
    "2796a68b0564d3a51c18da53245b62226462aa1314a29a828898db9309920cacd6c563fb6aaca921678d22d1645922cfc274703d3a23dec509d773c3d307bbed"
    "f9be6befc7ddf6a338e07718f34fcae7bb0c7ce013fcb2cd8d11c6769219aa44c204a975ab215cf0f0e425e3f01a2b0e30c0fbf525f160aefd3178e07fb49d2b",
    "39a964674bdd9068a897f3a6b89728e61249f1307277355a152d4d2355ad23224a9cbf15872d7105e8125dba7a99338eaf49f3c6db82dd1696e0e3d6f377fe4a"
    "0488e7d875c10beabe2be68e2b9b542919892fd7a39dd5b5637a777f77208e833138e3e21018fda0e63f635ccfebc1b08dae07ab71a739cdc4a7d561c05bf2f4",
    "85f3ef2d3963d450701b2bc82fbc454fff026fd11953b4569520ff747f8789e78e81ff7feb3ec155914a1691aaa2a69b22f014ee2744803af5c3ef8fe75af77f"
    "4c7ef0e7ccd61794ee77ca954aa69ec04673bd4d331bc57222ff5412e647f7f97d3c3afee1bcfbf70bbf74f63506deb2ede98df59739f57e7e56babecdc473c7",
    "c03f6d3e403ad0fe7cc1e5c3e9f78bf9d9e9debce305a5ebb16ff2b5a3d2fabd68b64d0e37d3b1584e3b9205aeeb97e53e0e76fffe49dc6def9cefdf4f19f34f"
    "cadfc70c7ce00ffc9ef31c6c265b9858dbea7e8b2203cb33ab03bf4d895762e2b963e0f7e75cc74b5b9806580f7efee76f5e0f2e6b3d788f81077908fe87ed66",
    "2a51cbb663c5fc7a57ce5035b25521595e0f2e4b3d78c288cfdfbcfbdc37fd0f31f0802ff07bf4df9425823a7a4aa3ba64615b9167a5ff6753e2959978ee18f8"
    "fdd1ff17689b45fef073fe578817541d6828ba51293dcbc8f5683a17edaeb5a4443e96e475e07ad581fbbe3dd77d9b81077c81df5307ecd5bbe357f51c689789",
    "e78e81df1ffdb7e9ea670ad7fbf9c00b4aefebc9645789ae6532954ea49ddd2de274d9389ca37dff19e37afe5c77d8827aae7b8b81bf6c7b7a6335a269bdb7c5"
    "aeaaee07b13f40a4d6524587a959ec0f7e89dfe1e73d575df763cde8c36293a4374e928d62fe41c16aa6d3f2d6fce83ebf8f47c73f9c77217ededfff0e3fef1f",
    "dd82f1f3fe60f0f879bf3ff373fd1f1dff70de7dea9bfe7fc8c003bec03fe2bc5f32c2b0eb9fdd7bfcd3eaffd1183cf0fba3ff2b2e6f03b913a0fe7f37cbf71e"
    "e71d2f28fdaf36ee1d94546229058d665a6a76ad9a49ee3ce0fa7f5df5ff5bc67c93f2f519030ff802bf47ff255d27dd8223665b2d55b6b0a66eab074492e15f",
    "05c79d7b4d1adf5b63e2037fad1fc5d70d4955c8c57ba87f4c895f1d830f7e7fea039b5648b400f3ecb9b9c19f135cf57a91dbd995cbcd83cd44796fdd30233a"
    "8eb4a33be9f9a917fcfe1ebdaec9f2313c77bf23003fe87324fe3be255e1b9765df0f8ef88e9e6ff0ff7cd0871",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 17232U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_loccalz_info.c) */
