@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=PIown_mex
set MEX_NAME=PIown_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for PIown > PIown_mex.mki
echo CC=%COMPILER%>> PIown_mex.mki
echo CXX=%CXXCOMPILER%>> PIown_mex.mki
echo CFLAGS=%COMPFLAGS%>> PIown_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> PIown_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> PIown_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> PIown_mex.mki
echo LINKER=%LINKER%>> PIown_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> PIown_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> PIown_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> PIown_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> PIown_mex.mki
echo OMPFLAGS= >> PIown_mex.mki
echo OMPLINKFLAGS= >> PIown_mex.mki
echo EMC_COMPILER=mingw64>> PIown_mex.mki
echo EMC_CONFIG=optim>> PIown_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f PIown_mex.mk
