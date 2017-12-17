/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp4v3_info.c
 *
 * Code generation for function '_coder_interp4v3_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp4v3.h"
#include "_coder_interp4v3_info.h"

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
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("interp4v3"));
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
    "789ced5c416fe3441476cb6ee91e800202813810105a092ac5bb6dba4957209234e9a66dda6d1ab724592dad634f12b733b6633b21d9537f0202714042421c39"
    "2d478e3d21fe001c38f113f80938765e9b7a334a685c87a4335235193f7bbe379f9ebf373399949bd9d89ee138ee55ce2d478fddfa956e7ba15bcf72978bd73e",
    "e3b93e73f976ee3677abaffd876e2d69aa855a96dbc08a8a761aa48c0cbba18a049d77236b445145d512da3ae20c646ab88964c7525130121482b25a4f23a3d8"
    "0db2de633a6f744c9dcf6b35249de41b84336ae685bbb8b7c1f5f0734619ffad21f9f992c24fe7bed91efb93f4d3b587fcbe890c936f9e188672d216f914324f",
    "2c4de7f3c8a64bde35b46324597c22642a44c728443419613ebb2d61241a8a5ae50feca7154d0d3963e4159b61438f3497c3e4623c3ac5dfb921c733eb6943b9"
    "e3b9df2d9fc6ddfab338e0b728fd0fcbe75b147ce013ec92cd8d11762850451cc648ad5a35ae27eeafe887b7d0fc800278bf5c110ffadf198007f6271bd98213",
    "4a76b4540d91843a316ff2db09219b48f27b4bf7ee47cbbca569b8acb57844b0f3b7e8b0c52f025dbc4b576fdc1c51fc1b366ebc35943bdc3c7c5c7ffee69f89"
    "00f19c7253f0827aef84ec416995c80523f14524dababf7c40eeed6cf5f8b13b0067901f1ca51d54ff6794e727351f1c51fcf5370ed77cd3ffd72978c01fd86d",
    "593b24969df7cdc31ac2ba33b3e89471e9ffaf57c483fef303f0c0fe9ff51f2b659e881616cbbca69bfc0bbc7582850b345e7efafbaf3f581eb826bc51dfbfb7"
    "2978108760974b6d315296c4422a22269e6969811c17f5f5e9c903bf539e1f964791d23ff008f66b789f3f90344234f550ea640558f68c657d709a8fbb1f84f3",
    "fc704ae97f585edfa7e003af60f7ac0f1433d950b0b5a1dacb506428d2c87902f0e73ced0b7fe61c7f64ad51c6c8bf3c51a0e2b9e307bb3feb042f6d61129cae"
    "9dfec8f2c4e4e789c7cdfa5aa29269c6845ca42da589bab45ec299e9c9136794e72775bd408b8b61e3f025ca78203fbcd37bf1742feed467825b73fb71bf7479",
    "ded3e6ceef9b77782586ac3415198d2b0f8cba5fb449c573e306eca3ce2f80a77077e210a05e7df7dbd3a9de2ffa3ef9eef8f25b50fb45ad62a994ae2614a31e"
    "6992f48a504ce48e456e7af49fbdc7fdfdbf1c77ff7cee97cebe4cc15bb02d1dbebac31cdbfc7ed478d8a0e2b9f100f651e301c28174fb0b705effed5c8ecdeb",
    "275dd7635fe52afb85c88368a689f75653b15856db9738a6ebff97f738d07d1eeec3b85bdf65fb3cddeb6c9fa77f0d85edf30483c7f679fce97fd2f3c111c53f"
    "7fe3ee13dff43f44c103bec0eed17f5312316ae96b1ad1454bb115795cfa7f36225e918ae78e1fecfee8ff0bb48d237ed8f9a06bc40b2a0fd464dd28159ea5a5",
    "6a34958db6971b6222174bb23c70b3f2c043dfce03bd41c103bec0eec903f6e8ddeb93ba0fb445c573c70d767ff4dfa62bf873404cefaf112f28bdaf26936d39"
    "ba9c4e975a4bcdcc96a0a48ac6de14cdfbcf28cf4feaf7bb47147f7d8dc3d33ddfbec7bd4dc15bb02d1dfe2a58d33a673f2755e783980f205c69a8bcc3d438e6",
    "033fc7efb2fd9d49d7f9583dfa58a8e3d4ca49b226e41ee5ad7a2a254dd1794ff61ef7f7ff72dc85d8fe7ef73adbdfef5f4361fbfbc1e0b1fd7d7ffa67fadfdf"
    "ffcb71f7916ffaff1e050ff8027b9ffd7dd108c3ac7f727fefb53f000fecfee8ffa2cb5b4fec04a8ffdf8cf39ce3b4e305a5ffe5da83dd828a2d39af917443cd",
    "2c97d3c9cd474cff6faafe7f4de96f58be3ea6e0015f60f7e8bfa8ebb89d77c46cbda14a96a2a91bea2e1625f8972283ce3f0debdf6b03fc037ba5ebc5614d54"
    "657c71ee74d4df0f9607e083dd9ffc40a715022dc0387b6eaeb0ef05263d5f6437b7a4627d773551dc8e18e692ae2c35a39ba9e9c917ecfdee3faee1e2313c75",
    "eb8871ed23b175c475e1b9e5a6e0b175c468fdff0b437ad14d", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 20344U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_interp4v3_info.c) */
