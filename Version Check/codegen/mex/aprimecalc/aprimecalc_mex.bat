@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=aprimecalc_mex
set MEX_NAME=aprimecalc_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for aprimecalc > aprimecalc_mex.mki
echo CC=%COMPILER%>> aprimecalc_mex.mki
echo CXX=%CXXCOMPILER%>> aprimecalc_mex.mki
echo CFLAGS=%COMPFLAGS%>> aprimecalc_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> aprimecalc_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> aprimecalc_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> aprimecalc_mex.mki
echo LINKER=%LINKER%>> aprimecalc_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> aprimecalc_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> aprimecalc_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> aprimecalc_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> aprimecalc_mex.mki
echo OMPFLAGS= >> aprimecalc_mex.mki
echo OMPLINKFLAGS= >> aprimecalc_mex.mki
echo EMC_COMPILER=mingw64>> aprimecalc_mex.mki
echo EMC_CONFIG=optim>> aprimecalc_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f aprimecalc_mex.mk
