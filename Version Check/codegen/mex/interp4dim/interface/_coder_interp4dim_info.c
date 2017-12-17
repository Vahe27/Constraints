/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4dim_info.c
 *
 * Code generation for function '_coder_interp4dim_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4dim.h"
#include "_coder_interp4dim_info.h"

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
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("interp4dim"));
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
    "789ced5b4f6fe344147797ddb22b04582010880311422b41a5b8dba64dba17f27fd336ed364d5a92ac565bc79e24b399b11ddb0909a77e0404e28084c499d372"
    "e49813e20bc081131f818f801b7bda78c82861e3759ad4234593f12f9edf9bd7e7df1b3fbbdccaeec10ac7716f71765b4fd9fd9bce9877fa5b9cbbd1f88ad3bf",
    "418d49bbc3dd769d47f01f9d5e521513f44c7b80a0020e3bb806746ba088185c4e23ab182aa26296fa1ae07460a8a80be4215287089420067975649083d60067"
    "47a0cbc10574f13dd50452abd8c19cde34aecc45a3036ec43f03c6fa6f4fe99f670cfff014fe24f334f5503831806e08dd96aec3565f14d2c06899aa261481e5",
    "2ef948579f03c914122103620d811056658084fc818480a843a5219c5a674355090dd72840cbc3ba1691210ee3cbf5680c7b57a75ccf2d6a4cda3deaf776db8a"
    "dbfd769cf0f718f34febcff718fc3c854b966ff4f0d0058a88c208280db3c95dfd5dcf5ed20ebab1ec208df0fdf2927c64fec3097c047fb29b2f0f43c98a9686",
    "2ee2d045cc1bc241a2944f2485e38df507d19a60aa2aaaa93d016034fcac0dbd25ac117709b6bbacb099e8af69e386ee49bbc7dd255fb32fdefd33e123dfb0dd"
    "143ebfaebb52feb4ba83e5b29ef83212ed3dd83cc5eb87fb23761c4de0996407c718fb35ff8071fea2e603565c4c1b87af31d643f2c107aea385f8b03b2fdafd",
    "a0189f558f09ef5d6acc5dfece46b02ec32e9481577cabd4f88acf4664b55343c03bfddf63f2b9f1ffadff08d6042c9a48ac09aa6608c44f6167a3e0a35e7dff"
    "dbd3a5d6ff1f921ffe31b7f5f9a5ffbd4ab59a6924a0de8e747166ab5449149e8bdcf2e87f701d8fb7df1d77ff7ce195cebecee0e31dc459e6ccfbfa79e9fa2e",
    "93cf8dcf1a0f241cb0339f7ff170fedd6a617ebab7ec7c7ee97aecab42fda41cd98ee6bae878271d8be5d513890b74fdba5cc7fed6753e89dbfdfdcbfdfb3963"
    "fe69fdf731839fa770aaae038d640722735739ec60a043696e79e0d719f9ca4c3e37ee4d7d87765b18fb980f7efafbaf201f5cd77cf03e838fa7f0c7dd762a51",
    "cf7563a542a42f65b0b291ada25c900fae4b3e3863d8e76ddc7dee99fe87187c3c8553fa6f4822023d2da5624d34a1a5c8f3d2ffc18c7c15269f1bf746ffffe3"
    "b679c44f50ef7f857c7ee581a6ace9d5f2d719a9114de7a3fdcd8e9828c492411eb85979e0a167cf77df61f0f1144ee5016bf5f6f145ad03ed33f9dcb837fa6f",
    "b9cb899440ef9783cf2fbd6f24937d39ba99c9547b1bdddc7e09a62bfaf112edfb078cf317f5f9ee19c35e6fe3b0e0d973dc3b0c3ede41ea48552fde125b549d"
    "f7633f0050bda308434fcd633ff073fc7e50df59749d8fb5a38f4b6d94de6a259ba5c2a3a2d94ea7a5ecf2e87c701d8fb7df1d77a1a0beef1c0feafbe37bd282",
    "fabe3f7c417ddf9bf903fd1f6fbf3bee3ef54cff3f62f0f1143ea6be2fea61b2eb9fdffbfbb3eaffc9043e827ba3ff6bb6df4662c747fdff769eef392e3b9f5f"
    "fa5f6b6e1f951564ca4515673a4a6eb39649ee3d0af4ffa6eaff378cf9a6f5d7670c3e9ec229fd17350df58b4331cb7614c984aab2ab1c215122ff2238e9fda7",
    "69ed7b7b827d04af3b563c6b8a8a8caede3bfd7d46feda047e827b931fd86e2581e6639cbd30b682e7028b9e2ff27bfb52a57db493a81c44746343831bdde85e"
    "7a79f245707d8f5fd774f1185ebafb8879d59182fb8857c567b79bc217dc47cc36ffbf75fd0bd2",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 17224U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_interp4dim_info.c) */
