[![Build Status](https://travis-ci.org/slenky/c-sharp-mvc4api-unit-test-example-project.svg?branch=testing)](https://travis-ci.org/slenky/c-sharp-mvc4api-unit-test-example-project)

C# MVC 4 API Unit Test Example Project for Jenkins Demo Job
=========================================

To build the project:
```
msbuild ci.build /t:Jenkins
```
You have to install Visual Studio 2015 Test Agent & nuget. I did it from Chocolatey!

### Jenkins/Hudson ###
Running in a CI environment can be rough. The following observations may assist you.

	C:\Program Files\MSBuild\14.0\Bin\MSBuild.exe

Of course substituting `Program Files` for `Program Files (x86)` where necessary and `12.0` for whatever version you are running.

This project was already configurated for 14.0 (2015 version) of msbuild.
### Travis CI ###
Please use the 'testing' branch for Travis; master has been configurated and tested only with Windows within Jenkins. That was made because of mstest isn't available in Linux, so I switched testing branch to NUnit (whatever).

