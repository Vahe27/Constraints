/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_PIown_info.c
 *
 * Code generation for function '_coder_PIown_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "PIown.h"
#include "_coder_PIown_info.h"

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
  xInputs = emlrtCreateLogicalMatrix(1, 7);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("PIown"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(7.0));
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
  const char * data[22] = {
    "789ced5dcd6fdbc81567dc24480edb6e816ebb45d1d65e148b050298fab21d772f9164d9963ff461c9b2ac602b53d2486244722892922503057469b1e7023db5"
    "4053f452f4d21e7be8c1402f3df6d0eda1e8618f05fa17f4b614e9674bac2662428a0c9519c0a0268f9cdfcc2f6fde9bef61eea58fef310cf375fdef6bfadfdf",
    "fec818e13df3c1bc7ff35c61a683557eefe6f97d4b1cc203e6fed47720fff5cdb38e250d0d343322f012caf4c41a52f488c489e836990616798993b4e250468c"
    "82542cf451c3903479011579111de189c83eaf47c4dd09d16d642c1aff4eb651bd53e8898cd256efb22b4c4698497e08e5bf6f939f1a819ff17b2b13f2e7a9cf",
    "923f664f55a4a86cbfa3287c67c8b13b48ed6858660b48a7ab9153f00b54d7d8f8aaca8bb2805645dc40027b745c1710a7f0528bcda0cbd5e3f13fae162ff1aa"
    "fe9586f5e472697c29ad8bd3e5ba20e4fba1cd72599f101e338f26621f3e03bc01213dbb3c7e9380073c821c894255d4f4ff6fb5da46826c68d438cc2bf7bc7c",
    "5803291f1000efcf6f8807e917e6e081fc79faa86ca890ae252d851357c7baaeb2c7f1e2513cc19e4442e1ad1aab612cd4f080d5496205bec68a9c26703516cb"
    "2afb7fbcdd288c87faf2db2ffff545dc5bfdf4ba3ef887e7b4fe7d9b80077a08f24665c8c56a75aebc13e3e2573855145f9ccbbb77f9c8cdc199970f8610f72a",
    "7da7fe8023a40f3c827c01f579ad8e45114bd5fad80382bb8372c9847cdbd5c7154b1cc263cbfb4618159e993f8ab7fe614448df2eaf3f24e003af20afebee51"
    "59e7f5c6872271c23aaf267abca0a525bdf98114beeed84f00fe434bfc2e3f0f8dfc3470af2620f7fc44998867961fe4afad57e3bf27066bec13a08db5d2b62e",
    "7a67d746bfa17e22f87e22dbef26e3cdfdfed3623e36aca74429b25b11f6a99fa0fd8671b8eb3790f0ecf2f88080f7be2e19f328e34ba38fe097ddffbd43bc3d"
    "229ea9272077da9e3078d295c1433baf5d6ffe93daf905e17965e7cfda25b459c817364e8af95e79e7b052c285d3e4f2d8f9a0d65f4fdbfbcc47cfcce7c7b4bd",
    "cfd0f6fe64be697bdf5f3cdade7727fd3f11beb7cb63ce126726de5b9990bbe407d69a8266fcf454ef46c7aecd077c8780077c81dc62ffd53a27704aaae59bdd"
    "7f6bf564a6dd07ba3cb5f73ffbfcdfd4de07ddde8732975b6291172b87fc492375b8532f349bc304b5f7ef4e3d66a6ec3da9bf6197aff72c7166e2bd950939af",
    "4a6613551baf18f06f5cc7a97e648978667941fe46ed81263f400d19ebeac14ef1e5e9f80ef3cbc477a99d0fba9ddf8b7686856e8b1792c564e7a49b68153ba7"
    "a91d6ae7df553b4fc2b3cbd7234b9cb97def91c117af3679bd3bd30eaa5d3f20e299fa0072e776dde4c987f91b6ad71788e7d4ae7f40c003fd0379bf8b5272bf",
    "ae6e972fa318e7d442387a5e6196c7ae076bfcf5ceaeaf357945d59abca7fa777de1dab8fd0f0878c01bc8c7eb97f4e2579b58113096abb88f94a6802fcdd54b"
    "feade7bc7e433c48ffc212b7e281dcc938df8d1abd823f4fc7733ef9c7033a8ffbb6fa03bbed7cf5303548ed5c5de50e0691d8712494ccc7c3a1d4f2f883ff10",
    "beb7cbe3cf09e9038f205f74bd5e7bf50bb78be2bdd5d73dd7fa07f72d71e6f6bdfbb7fd8371dce779065e6aa0415ad25c5b27b03b271f2077a3df30ee3378a8"
    "1f2fe9fc6ef0fd436128f3e246f7e42cccd71ab174259f3b0ef797681c88d6dfe930ad6fa1a519e79fe75fea6dced85246c7f9673f21d0f1206ff0e838bf3be9",
    "d3f6ff74b9dcd5d7b46bedff79e3f57ad1456e105c7fb0d0f901d02341ffc19a4c793f3f307ab9f2988e0705dd1f28dd90fc825763717133b725e56ae5e86149"
    "5da2f53dd41f4c97cbddf9626ffd012f517f60cf1ff03eecf71bfd8efa83e0fb831677be958d9e65ba5bb5b896dce0b23114cbef2d8f3fa0f3c5b39f10a6f4ef",
    "cb0bd7ecfbeb8ef73bc5f37affee128f0bd271fd05e2d1717d77d277da3ecb59e2ccc47b4bb36f8bb95bdff939213dbb7c7d42c003be406e994fe56459182678"
    "89538605c3b7edf6a4bac663c9ad79876fccc917c89b37b8d5362735744700f86fedb95033db07443aa1f9ef65fb3fff3f7ace43e0fdc415e2705cca442b5aab",
    "15d90b1d671ba767e125f213b47ecf2e97bdf19e5dd7d68f7e8f80073c827cc6be5f3490e38280eb86dcaffe82d37e64918867961fe4eef523813653753cf40b"
    "f4dc8705e279e517d2b5783abc2977faa952f72cd449846279fe6089e609687d9efd84405a27e4b41ff111010f7803f92bfc400627cdbd04e3e0973fb87688f7",
    "9c8867f20072f7f5e7863ecfcf89a67e6191785ef9052d72382c775be552bbd5d93ad9d33a07b9416a89ce03ba267c6f97c79f10d2071e41be08bfb086ba3d4e"
    "50f92be4b51e7e4af79931749fd9acf2d8f00b749fd902f1e83e3377d2a7e348b3cb654f1f73aef907d2bd45c023c82dfd879e8a729ca21bbb2496d4f1ed457e",
    "ad2b72daef2c11f1ccf283dc1d3d9aa6cddb79e8d1a7bb747e21f07e61d815e5edf2f681102bf1ed3c4aec0ffafdf3259a5fa0f579f613c2b4fe3df57b3e418f"
    "f2526b172b7bb95343ee573f2158e38f93b4793e9ff0ab14f50381f703ede8566bbb7599d250a1d4cb891bad5c2e914d523ff0eed5e771587fe696febdde390f",
    "2db9b7de42da9edc4b495c4d408dc08e1355e6e081fc79dabebaa87a5f05355853596e54e6e6a113c74e11e7c3f974a59f6e513f10743f90cde4d583937224d6"
    "db280ee2922c772fb3d925ba6792f607663f2190e60d9ceadf87043ce00de4a471a1a0f603f273f040eeb2bef8b1def4af23da0f08bcfddf3cc35c3a22940e63",
    "bba7c78d23357625a7da4bb4aee8ef84efedf2f882903ef008f285cf13ac35054e4b6b7011bba77af9b245e793193a9f3cab3c36fc049d4f5e201e9d4f7627fd"
    "6bc2f7eef7ffddd9bf66ee4caeea559ad3aa70f92ee3b11e5e577c1a37a2f79005e75e0b7a0fd922f1e83d64eea4efb4df7f46481f7804b95bf65fc25a86cb64",
    "95b45eb55bbaf1f7761fda996be752ccbb579e57254e62fcdb57e0d4bea78978a65e80dc857387c64cf9310e44cfa758209e57f7d474e3bdac181b9663a11325"
    "d24b86d1765fcc30cb63df693d9e9dff69bdfb916be33cf45e79121ebd57de199e19de153c7aafbc3be9d3f6fdec270452fb7e4448cf8373263865bd29606c0e",
    "6c05d50f9c12f1ccf283dc1d3ff0c4e48d357833da101efa815fd0fb0982ef076aedcd5c5912b446018ba99eb41fada512074b74fee835e17bbb3c7e46481f78"
    "04b9dbe7d4551b58e478a98a14c5b088deea61d1ef7541fdb8206495b834847cc80ef3e1f49cba60ad13baa5cf8ff1a13fa81b74fe37e87ee16972fb4abd128e",
    "926db9946f168a898dd3707889d6893add4fdc20a40f3c82dcf5fa6cac0b2aa1ba8615f8c7c9725d10f2edae3e96e9fa2086ae0f9a551e1bfe81ae0f5a201e5d"
    "1fe44efa4ee70f72963833f1ded29c6f3dcab8d64ff816010ff802b9a59f00dda3c09e27b1907983576c24bb6d5218cc796af7fffb978fa9dd0fbadd978ae779",
    "2e72be5f89f6fbbd54b91f8e8a077c32f876ff2be8e0e707", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 45024U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_PIown_info.c) */
