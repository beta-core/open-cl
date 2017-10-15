@echo off
echo ==============================================================================
echo MIT License
echo(
echo Copyright (c) 2017 bluemner, betacore.org
echo( 
echo Permission is hereby granted, free of charge, to any person obtaining a copy
echo of this software and associated documentation files (the "Software"), to deal
echo in the Software without restriction, including without limitation the rights
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo copies of the Software, and to permit persons to whom the Software is
echo furnished to do so, subject to the following conditions:
echo( 
echo The above copyright notice and this permission notice shall be included in all
echo copies or substantial portions of the Software.
echo( 
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo SOFTWARE.
echo ==============================================================================

REM
REM Find visaul studo x64 install location...
REM 
echo Arch in x64
set vs2013="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
if exist %vs2013% call %vs2013%  x64
if exist %vs2013% echo Visual Studio 2013 Loaded

set vs2015="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
if exist %vs2015% call %vs2015% x64
if exist %vs2015% echo Visual Studio 2015 Loaded

set vs2017="C:\Program Files (x86)\Microsoft Visual Studio 16.0\VC\vcvarsall.bat"
if exist %vs2017% call %vs2017% x64
if exist %vs2017% echo Visual Studio 2017 Loaded


IF %ERRORLEVEL% NEQ 0 ECHO Microsoft Visual Studio 2013 2015 not found. Visual Studio Must be 2013 or grater
IF %ERRORLEVEL% NEQ 0 Exit -1

REM
REM Find Open cl install location
REM
set intel_include="C:\Program Files (x86)\Intel\OpenCL SDK\6.3\include"
if exist %intel_include% set cl_includes=%intel_include%
set intel_lib="C:\Program Files (x86)\Intel\OpenCL SDK\6.3\lib\x64"
if exist %intel_include% set cl_libs=%intel_lib%

set amd_include="C:\Program Files (x86)\AMD APP SDK\3.0\include"
if exist %amd_include% set cl_includes=%amd_include%
set amd_lib="C:\Program Files (x86)\AMD APP SDK\3.0\lib\x86_64"
if exist %amd_lib% set cl_libs=%amd_lib%

REM
REM Set SDL & Open GL locations
REM
REM LIBS
set lib_open_gl="C:\Program Files (x86)\Windows Kits\10\Lib\10.0.14393.0\um\x64"
set lib_sdl="L:\SDL2-2.0.5\lib\x64"
REM Includes
set include_open_gl="C:\Program Files (x86)\Windows Kits\10\Include\10.0.14393.0\um\gl"
set include_sdl="L:\SDL2-2.0.5\include"
REM
REM Make a bin folder if one dose not exist
REM Set cl.exe compiler flags
REM

if not exist .\bin mkdir .\bin
set compilerflags=/Fo.\bin\ /Od /Zi /EHsc 

REM
REM Compile test.cpp program
REM

set file_name=test
echo --------------------------------------------
echo Building %file_name%
echo --------------------------------------------
set linkerflags=/OUT:bin\%file_name%.exe
cl.exe %compilerflags% source/%file_name%.cpp /I%cl_includes% /DYNAMICBASE OpenCL.lib /link /LIBPATH:%cl_libs% %linkerflags%


REM
REM Compile image.cpp program
REM

set file_name=image
echo --------------------------------------------
echo Building %file_name%
echo --------------------------------------------
set linkerflags=/OUT:bin\%file_name%.exe
cl.exe %compilerflags% source/%file_name%.cpp /I%cl_includes% /DYNAMICBASE OpenCL.lib /link /LIBPATH:%cl_libs% %linkerflags%