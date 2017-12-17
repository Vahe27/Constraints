@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=interp4v3mex
set MEX_NAME=interp4v3mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for interp4v3 > interp4v3_mex.mki
echo CC=%COMPILER%>> interp4v3_mex.mki
echo CXX=%CXXCOMPILER%>> interp4v3_mex.mki
echo CFLAGS=%COMPFLAGS%>> interp4v3_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> interp4v3_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> interp4v3_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> interp4v3_mex.mki
echo LINKER=%LINKER%>> interp4v3_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> interp4v3_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> interp4v3_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> interp4v3_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> interp4v3_mex.mki
echo OMPFLAGS= >> interp4v3_mex.mki
echo OMPLINKFLAGS= >> interp4v3_mex.mki
echo EMC_COMPILER=mingw64>> interp4v3_mex.mki
echo EMC_CONFIG=optim>> interp4v3_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f interp4v3_mex.mk
