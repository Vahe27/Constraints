@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=loccalz_mex
set MEX_NAME=loccalz_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for loccalz > loccalz_mex.mki
echo CC=%COMPILER%>> loccalz_mex.mki
echo CXX=%CXXCOMPILER%>> loccalz_mex.mki
echo CFLAGS=%COMPFLAGS%>> loccalz_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> loccalz_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> loccalz_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> loccalz_mex.mki
echo LINKER=%LINKER%>> loccalz_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> loccalz_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> loccalz_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> loccalz_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> loccalz_mex.mki
echo OMPFLAGS= >> loccalz_mex.mki
echo OMPLINKFLAGS= >> loccalz_mex.mki
echo EMC_COMPILER=mingw64>> loccalz_mex.mki
echo EMC_CONFIG=optim>> loccalz_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f loccalz_mex.mk
