@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=interp4dim_mex
set MEX_NAME=interp4dim_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for interp4dim > interp4dim_mex.mki
echo CC=%COMPILER%>> interp4dim_mex.mki
echo CXX=%CXXCOMPILER%>> interp4dim_mex.mki
echo CFLAGS=%COMPFLAGS%>> interp4dim_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> interp4dim_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> interp4dim_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> interp4dim_mex.mki
echo LINKER=%LINKER%>> interp4dim_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> interp4dim_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> interp4dim_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> interp4dim_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> interp4dim_mex.mki
echo OMPFLAGS= >> interp4dim_mex.mki
echo OMPLINKFLAGS= >> interp4dim_mex.mki
echo EMC_COMPILER=mingw64>> interp4dim_mex.mki
echo EMC_CONFIG=optim>> interp4dim_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f interp4dim_mex.mk
