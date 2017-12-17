/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_aprimecalc_info.c
 *
 * Code generation for function '_coder_aprimecalc_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "aprimecalc.h"
#include "_coder_aprimecalc_info.h"

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
  xInputs = emlrtCreateLogicalMatrix(1, 23);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("aprimecalc"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar
                (23.0));
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
  const char * data[13] = {
    "789ced5c4f6fe2461477b6bbe9eea1adbbd556ad7a28adaa95da487837210b59b52a10c89284fc213829b05a25c61ec0c98c6d6c43614ff90855ab1e2a55aa7a"
    "ec697bec9153d52fd01e7aea47e847a8c14c02b38ca0c19885cc4868187e787e6f9e9e7f6fe6e1845bd8dc59e038ee4de7d5ee4ff6b84e7bc3ed38bedbdfe0fa",
    "1b892f109f2ff47f9dbbc5dd1c88ffd8ed655db341c3760750d5c06e0d1581e90c3409818b69141da99aa4d962d3009c092c1dd681d2414a2a04a28a405aef19"
    "a4546780367aa08b411b6abf5faf00f92c5b439c59b12ecd85bd03aec73f2dcafa6f8ee89f638a7f78027f9a7cb6fe5838b4806909f533d354cf9a929000d699",
    "ad1b421638ee52f64dfd14c8b6100b582a322008205d015048efc81048a6aa958523e76a55d7029d350a92613aeb96252807d1c57a0c8abd8b23aee70631c6ed"
    "0ef17db77d1e75fb2fa298bf41997f547fdea3f0f3042e3bbe3183aa1364a626c120045ad9ae703d717f453bc846b30337ccf7eb15f9f0fcbb43f830fe74339d",
    "eb8492132d6553428176cc5bc24e4c4cc7e2c2c1f28387e1a260eb3a2cea0d0120d8792d75bc252c617709aebb9cb019eaaf51e386ec71bbc3ddc66f375ebcf3"
    "57cc47be4ebb2e7c7edd7762faa8b086949c19fb2a146e3c5c39420f76b77becd81fc233cc0e8e32f66bfe16e5fa59cd0727147bbd8dc375cff4ff6d0a1f4fe0",
    "8eac1d23db59af755c01d0e8ec2cda6d5afaffdb15f9f0fcd9217c18ffdffa0fd5a280241b4a4541372ce125bfb59300e7ab6efdfccfdf7fb23c3021be71efbf"
    "77297c3c812b85a6142aca522e119262cff5a4884ef3c6c6fce4813f28d78fea4789323f4fe013b89f3f92758474ed586e67057cec99caf9e03c1b75df8817f9",
    "e19c32ffa87efd90c2cf1338713e50ad784d85f6a6e61c4381a9ca63e709ccbf488c2fed711145af1521f02e4fe4a87cfdb837e704d26d41e49fae9dffc4f2c4"
    "ece789bd7a753d564ad5236226d49493485bde28c0d4fce48916e5fa593d2fd0e262d4387c8db21e9c1fdeebfdf0fc20dae95ba2db738751af74f93631e62ebe",
    "e722c854d4baaa8069e58171eb455b54be7e7cdcfd05f653b0bb71f051afbefffdd95cd78b7e88bf3fbdfce657bda8912f1492e5986a564375945c15f3b1cca9"
    "c4cd8ffeb3fb78b0fdfd71f7ef975ee9eceb143ebe8b749739b5fdfdb8f1b049e5ebc7c78d071c0ea83b9f8ffbfaef16336c5f3febba1ef93a533acc851e8553",
    "7578b0968844d2faa1cc315d7f55ee635feb3cdcc751b7bfcfea3c1cabf3f4da3d423e60759e09f2b13a8f37f3cf7a3e38a1d8e76ddc7de699fe07287c3c8113"
    "fa6fc912040d635d478664ab8e224f4bff5b63f2e5a97cfdb837faff92dba6113fecf9a009f2f995072a8a611672cf9372399c48879b2b35299689c4591eb85e",
    "79e0b167cf03dda5f0f1044ee40167f5eee7b35a07daa6f2f5e3dee8bfe32eff9f03627a3f413ebff4be1c8f3795f04a3259682cd753dba29ac89b0773b4ef6f"
    "51ae9fd5df774f28f67a1a87e7079efd8e7b8bc2c7779112d4f5f6b39fb3aaf37eec07002cd534a1e3a969ec077e89de67f59d59d7f94835bc27566162f52c5e",
    "11334fb276359190e7e8794f761f0fb6bf3fee02acbedffd0eabef0fee7163f57d7ff8587ddf9bf999fe0fb6bf3fee3ef14cff3fa0f0f1043ea0be2f9941bceb"
    "9fddbff73a1cc287716ff47fc9f55b4fecf8a8ffdf4ef339c779e7f34bff8b9547fb390dda4a5647c99a965a2926e35b4f98fe5f57fdff8632dfa8fefa94c2c7",
    "1338a1ff9261c066b623661b354db6555ddbd4f6a124e37f2932ecf9a751ed7b6b887d182f75ad38ae489a022f9f3b1df7ef078b43f831ee4d7ea0bb15079a8f"
    "71f6c25a65bf0bcc7abe486f6dcbf9eafe5a2cbf1332ad65435dae87b712f3932fd8fd3d785da3c56370eece11d3aa23b173c4a4f8dc765df8d83962bcf9ff03",
    "7d8ad3f8", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 20344U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_aprimecalc_info.c) */
