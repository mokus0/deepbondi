@echo off

%HOMEDRIVE%
chdir %HOMEPATH%

start /wait /b C:\cygwin\bin\bash --login -i
