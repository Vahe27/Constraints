/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp1dim_info.c
 *
 * Code generation for function '_coder_interp1dim_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1dim.h"
#include "_coder_interp1dim_info.h"

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
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("interp1dim"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(3.0));
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
  const char * data[27] = {
    "789ced5d4b8ce358154df77437d342030606e81103d48c46ad8646957f2599594ce5e35492fae45ba9a49a5695e33889abfc8bedfc4a4264036c472084104833"
    "88cdb09ade20b16011090921b16131b060c512890d62015b9c38ae8add791d77c576cacebb52e995fb96dfb9be7ddfbdefddf773dd4aefdf72b95c9f937ec665",
    "ea7fae09bd26172e645ade76a949cbbf352dbfa57956e8aeeb8eea3d85ffcb6989b38c48f445f9812219e2a043d7085e7a60309ab8aca6ced22483316269c011"
    "2e9e1058aa4bd4279c064911259226f6d8998714293dd0c919d6e5c39835fe3dde22f0f3628776f12de14a5c6af6c135a39f11e0fbefe8d4cf09403f8886ff04",
    "7d1a7fd77d2810bce0ee9ef33c793ec0dc0942381759ce5d242475d5733c7b46e0a23bba21903447111b345b2728f7de3e4e11184f324d77597a9b64998dc937"
    "ba4949c33ce7ad93f4267df93d1c40de7b3abfe7b6e659a1fb9abf97e9f56db97cb0ade0f701f5ebd5e79701f888868f4bbae137272a60306a932298a6d8725d",
    "fdbf9e5e530e2d81e45048c17b764d3ca5fe8305780aff497aaf323125c95a9a3c466f8c6d5e70ef474b7bd198bbe0f3784335b7c8b2548dedbb099a9afc3c9e"
    "68cbfd5851975b569764360bf5a5d76eb4a542f75daf2abf263ff9d2dfa216e24d685df0ac6a77a5bdf27184ae57f8e85120d4f7facbb4e76077468edc029c45",
    "72b800cf56d53f02bc6fd778700a90d7583bdc30ccff7f01808768f8925b3ba14529ee0b272d82e2263d8b31adcaffffee9a784afdc505780affa5fd3f45d6dc"
    "34265258cdcd7282fb39bd8d8380cb52bff5ab7ffcfdaf300e9884b76cfbfb0a000fd1f0ebc7032c50c3b14a2280452f58b4449f55b9a473e2c09f00efebd523",
    "06a81fd1f04d68cf6fe12c4db3cc093e8e0acab06725e38361715bfea574191f8680faf5eaf59b007c44c3d78c0f4821d6212931cd48c3508227f1a5e384827f"
    "4ff37c258fcca9b39d1a451817272a403c35df987182566d9bb4757e6df8218c13f68f13d96e3b1e6da4bae1523e30c0519af1258fa99473e2c408f03e1c2fa8",
    "496d87ef6c1be57f5f01e021530ec53627e5aafcfdc74be2ed00f1d4fc65fa1104d5e8306e4953d6dac16fb61f42ff6e77ff9e48c77cf5a35694adf442b96873"
    "e009b367473bcef1efb0fdaa496d6f8f0cebd7bf09c04334fce7faf50996c64806e5797692025a34ced12bcfe717c8a3f025cde3a214534f5a1853971cbf51fd",
    "fcc305f80adfa87efe8c1a2719210bede8077f8ec179819b1a07f4ce0b50fbfb35d4eb8f077b248ea302d76d559b4e9a1780ed797ea990dafeb60cebdfbfaa79"
    "765dfe9dcc210581c378815855fffed99278a6cdfbcef40fc61a1af710145d593bef3bfcd1c17f613fffa6fa77bdfdfc205548f5d8fdf08eff30d50ce1f18b4c",
    "215d8c39c7bfc37ebe9ad4f6f66dc3e6775f07e0211abea69f4f68fbf7a74bca7147f37c2587ccc15b980aef46e6ed054948a2ee96a3ffb40fa0ed0a107217c0"
    "427fffafdf3f84fd79bbfb7ba654cd63be6aead8dfed76d04ad7eba733641cfafbf5f0f71ec3f23a6f00f0100d5fe3ef051ca3307e53c9dec3753dfac67d8f65",
    "bd4d6d66f63b4e01721a6837f50f37a0dfb7bbdf8fe4b18887e8ec1eb40b87a9708f3b67e8963f01fdfebaf9fd0f00f5e9d51368df08a2e16bfc3ec671d4a038"
    "7162c969663dcde4280c57b68cdc94fcfeb2ebc36a0bf015be317101acd66998b0d2ce3e1182304ed83d4eec6576f16a3b178956f703bce0e3485f379471509c",
    "80ed7bfe77e9b3c74dc78d1f147cabd77bc2f1836978135a173c387e30a67ed89ee7970aa9edef4dc3e6813f03c043a61c9ec0281aebaf6c7ee0d99278bb403c"
    "357fb971a5f48b7baa29cbed61f89fdbf7a17fb7bb7fbfd829677cad44a0d4c97b7b3e72b07f18dc6b39681e18b6e3f9f2abedeedd4bbfbe6c1ee6b3003c44c3",
    "1fef73537cfc98d6611e38b79c81703cd9c544c23da33a2be7815d3f8bbd01d7fdd8dddf53c583a6a75af07b4bc1f245b79ecd841b3dc641fb7c617b9e5f2a04"
    "3ae76108a8cfe4bc4e836231717fbcaf6dcab76b1c2800f1d47c63c681576ab33e1f38fc318c03f68f03ddb03f102232bbd94622221e87b0c25e9ca41db48f17",
    "e675e6970a9995d759b4be9fe6eb6497acdb767d7f0688a7e62f7b0e88a2a7cde980cc427bf8e91f9f3a3aaff3f355c62fabf66ff5abc7c768334af2ed409746"
    "83a56a347f86b99ce3df613b9e2fbfdaeefefdbe65f97af93357362fbbac3da481786afeb2f6a098c3b4db6e65bffd27f7f2b0df6e77bf1eeee51b8795c05628",
    "d5a50a914438bcc71ee22ee8d76f4a3b06e5cfcd39aff9ed6db97c68581e079ec706c253f3e1796c2f8b27d3bae0c1f3d88ca9dfeef1e014209f59fb798780fa"
    "f4ea6b03808768f873d667127d2eced21c269292475e95ff1f2d895705e2a9f9c6f8ffe7d4b60afb81e7f89b8867551c68d539feb87281e2cd50622f34f077b0",
    "683e0cd7f1ac591cb85ac7b3acdd7d11808768f89a38207dbdfcef76cd0399b6de6baeff97d465fd7c0ff4f726e259e5ef9bb1d8a01ef2a3e871dfd74ded96c8"
    "44952f38a8df3f02bc6fd77398adcd0bbdb32d97df81f3ba3af1d6603e08ceeb1a8b372138af6b6cfd23c0fbd0efabc92abf7f17808f4c390d8a9d1ce46657bf",
    "6fc5b8503eff63a2a9558c0be1b9fc26e259d5df0fb743d9529b4a04cf63ad527ea728b61309dc41ebf6613b9e2fbf59ebf5e13c2f084fcd87f3bc2f8b27d3ba"
    "e0c1795e63ea87fe7fbefca07bb68680faf4eaeb6b003c44c39f7f0e8fd2ebb7ef399ed6dedfa0ecefb8b21db85fcb197856f9ff5a6b2b576128b15e6469b4c3",
    "a4fc35349671d0bd5cd0ffcf971fe4ff3f00d407cff394df81e7fdcdff2e1d7606cff334110f9ee7694cfd4e6ddf20bf69ce7cc1e6b65c6e3b6e5cb1aabc121c"
    "57988527d3bae0c1718531f53b354e9c02e436d61e8396ad1f82f73ec27b1fd57832ad0b1ebcf7d198faa1bf9fff5dfaec3164d838e0eb003c44c3d78c033a02",
    "91939c1ccbc75946105df63d0fae0cc453f38db123b5da2c8e0bef25b760bec8ee7161d0a6b9482592a10265b2952762a97eb75b7550be08b6e7f9a5426afb0b"
    "af3a1f243d924c33c9f23b39396362d779e6d2023c856f8cddccaa4dee415818077e81c23860fb38d0f2879a91660f158962b993a383cd5c2e9675d03dc1b03d",
    "cf2f1502ddfbb5acfd7d15808768f8721c68729dcd2621ee701d94c16a14515f99ff1f5d134fa9ff78019ec27f9236e49a7849716e95e256308e2c7f2f04e380"
    "dde340f6202f640a155fa0132cf5a30cc7b57bd9ac83f61bc0f1c0fc5221b5fdbd67581c7800c043347c505ec8aee380fc023c856fb0bdace29cd13f0ce138c0",
    "f6fe7feb88c5d23eaabc1b481eeed7f784c005873ae95e30384f30ffbbf4d9e3fb86e587be01c04334fcf12539923a4e249f46b12c77c27609be41b1bd137cbc"
    "f77a75f9a1d135f194fa4f35cf5a3c85bfd4ba65d9ac5ea03f4bf7a33dfaf42e8c0f768f0fc22eda47131717b94cdf17d8f779e2f9a8d7833a273efc13f0be5e",
    "3dfe10503fa2e19bddaedf7af11f9cb4088a2378abed75c7b075458be67549a1418ecbd5e4b1aef64d3375a29f66c44b393e5e528ee4023914feb5ecab41f689"
    "3ac74ad2bbc7fab378bcf911dcaf6cfff8501c70241d6c178ebc64ad1e481fe773fbdeae83e69361fb5593dade3c97fe9d03d4a7574faf699e5d9abf53f8a4c0",
    "c8472b88036ebc176d55eb869e2d899705e2a9f9cbdbc58cbe66ceab3a05c867e4397470df80fdfdfb8eff7c506c37492a5e8a9f17dab166e9fc1075907f87fd"
    "7fb5bcc6da6bdab0feffa275fed2a74fae98b76b3cb0e25c52f93a6a59532bb84ff8a3dbf7613ec8eef1806f7bb833520844e9ad5c88c9d52afeddb2e0a0f902",
    "180fd4f21a6aaf436be301c9c078a02f1e90cc0ae2c1af613cb07f3c6862d550d67f74d00ed5a2623c8865034420efa07dc523c0fb763da7fa1420afb176b865"
    "989f87f711cb64dffb8ae07dc466e2c1fb888da97f04781fde27a826b51d1a77ffc0223f4f0a44bb8351b6f5f3a6dd37f67c7f5ed694e5f78d0de17cae897896",
    "cde71eb63be241ba5c3e2c14f35b7c3b9a0a129883f23bb01dcf971f74ff0007a84fafbe40ff3f88a69ca4abe42f3ec159deb6f70a3f05e2a9f963fbc82d6720"
    "1c4f763191706b5567f5f970e46f1fc13c8eddfd3eba558b1c9c257383a364a3d83842b3216ff5dc41f70e8c00efc376ad26b51d3e5af57e3006e39b2483b7ce",
    "edbaeeffbb0bf014fe4bf5175eb031f8728878a939cbcf87f8fea3c2a7301e988467d93941fd5e3a82251bcda007cfa26cf12cd909f51cb4ee7f0478dfaeed1a"
    "64177aedf015c0f728e7493f50fdebdbdb72f9705ac27b286f52be1fde43e95c3c780fa531f5ff05f0be5e3d5280fa110ddfd4f1c05bcaa37c3cfcecf79d02e4",
    "37d42eb74f2df3fba4c0608c0bfa7d3d79434953ab98e785f97f13f1ac9ae76d473b593a30a8043c05ded7897b8948973e7039c7efc3763c5f7eb3ee9f84f70f"
    "83f0d47c78fff0cbe2c9b42e78f0fee1e5eaff3f3ce0be9e", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 63328U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_interp1dim_info.c) */
