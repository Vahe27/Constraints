@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=interp2dim_mex
set MEX_NAME=interp2dim_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for interp2dim > interp2dim_mex.mki
echo CC=%COMPILER%>> interp2dim_mex.mki
echo CXX=%CXXCOMPILER%>> interp2dim_mex.mki
echo CFLAGS=%COMPFLAGS%>> interp2dim_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> interp2dim_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> interp2dim_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> interp2dim_mex.mki
echo LINKER=%LINKER%>> interp2dim_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> interp2dim_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> interp2dim_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> interp2dim_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> interp2dim_mex.mki
echo OMPFLAGS= >> interp2dim_mex.mki
echo OMPLINKFLAGS= >> interp2dim_mex.mki
echo EMC_COMPILER=mingw64>> interp2dim_mex.mki
echo EMC_CONFIG=optim>> interp2dim_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f interp2dim_mex.mk
