C# MVC 4 API Unit Test Example Project for Jenkins Demo Job
=========================================

To build the project:

	msbuild ci.build /t:Jenkins
You have to install Visual Studio 2015 Test Agent & nuget. I did it from Chocolatey!

### Jenkins/Hudson ###
Running in a CI environment can be rough. The following observations may assist you.

	C:\Program Files\MSBuild\14.0\Bin\MSBuild.exe

Of course substituting `Program Files` for `Program Files (x86)` where necessary and `12.0` for whatever version you are running.

Those project was already configurated for 14.0 (2015 version) of msbuild.

