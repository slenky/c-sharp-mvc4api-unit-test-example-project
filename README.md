C# MVC 4 API Unit Test Example Project
=========================================

The following must be run using the `Developer Command Prompt for VS2013` or by executing the following in a command prompt beforehand from the root of the project:
	
	C:\Program Files\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat


To build the project:

	msbuild

To test the project (Must be built first):
    	
	mstest /testcontainer:MvcApplicationTest.Tests\bin\Debug\MvcApplicationTest.Tests.dll

