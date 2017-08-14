
Dim url, expVersion, outputPath
Dim testResults

url = WScript.Arguments(0)
expVersion = WScript.Arguments(1)
outputPath = Wscript.Arguments(2)

'url = "http://localhost:3040/"
'expVersion = "20"
'outputPath = "output.xml"

WScript.StdOut.WriteLine("Initializing Tests")

Set testResults = New TestResult
testResults.Initialize "SmokeTests.BasicTests"

Dim tstime
tstime = timer

'-- GET
WScript.StdOut.WriteLine("Executing GET...")

Dim xmlHttp
Set xmlHttp = CreateObject("Microsoft.XMLHTTP")
xmlHttp.Open "GET", url, False
xmlHttp.send ""

WScript.StdOut.WriteLine("GET Completed")

'-- GET 200 test
WScript.StdOut.WriteLine("Testing: GET is 200")
If xmlHttp.Status = 200 Then
	testResults.AddTestResult "BasicGet", True, "", timer - tstime
Else
	testResults.AddTestResult "BasicGet",False, "Expected 200, actually received: " & xmlHttp.Status & " - " &xmlHttp.StatusText, timer - tstime
End If

'-- Version Number Test
tstime = timer
WScript.StdOut.WriteLine("Testing: Version Number is " & expVersion)
Dim content, Regex, matches
content = xmlHttp.responseText

Set Regex = new RegExp
Regex.Pattern = """version"">version:\s*([^\s<]+)\s*</"
Regex.IgnoreCase = True

If Not Regex.Test(content) Then
	testResults.AddTestResult "VersionStamp",False, "Expected " & expVersion & ", Actual: Couldn't locate version", timer - tstime
Else
	Set matches = regex.Execute(content)
	If matches.Count = 0 Then
		testResults.AddTestResult "VersionStamp",False, "Expected " & expVersion & ", Actual: Wierd error where Test() worked and Execute() did not", timer - tstime
	ElseIf matches.Item(0).SubMatches(0) <> expVersion Then
		testResults.AddTestResult "VersionStamp",False, "Expected " & expVersion & ", Actual: received: " & matches.Item(0).SubMatches(0), timer - tstime
	Else
		testResults.AddTestResult "VersionStamp",True, "", timer - tstime
	End If
End If

'-- Database stuff showed up
tstime = timer
WScript.StdOut.WriteLine("Testing: Getting started content present")
Regex.Pattern = "<section class=""content-wrapper main-content clear-fix"">"
Set matches = Regex.Execute(content)
If matches.count = 0 Then
testResults.AddTestResult "Content", False, "Couldn't locate getting started on home screen", timer - tstime
Else
	testResults.AddTestResult "Content", True, "", timer - tstime
End If

'-- Output
Dim fso, fil
Set fso = CreateObject("Scripting.FileSystemObject")
Set fil = fso.CreateTextFile(outputPath)
fil.WriteLine testResults.GetResult()
fil.Close
Set fil = Nothing
Set fso = Nothing

Class TestResult
	Dim testCount, failCount, testsName
	Dim startTime
	Dim content

	Sub Initialize(name)
		startTime = timer
		testsName = name
		testCount = 0
		failCount = 0
		content = ""
	End Sub

	Sub AddTestResult(name, isSuccess, message, timeAmt)
		testCount = testCount + 1
		If Not isSuccess Then failCount = failCount + 1
		content = content & "<testcase name=""" & name & """ time=""" & Round(timeAmt,4) & """>"
		If Not IsSuccess Then content = content & "<failure message=""" & message & """></failure>"
		content = content & "</testcase>"
	End Sub

	Function GetResult
		endTime = (timer - startTime)
		GetResult = "<testsuite classname=""" & testsName & """ failures=""" & failCount & """ name=""" & testsName & """ skipped=""0"" tests=""" & testCount & """ time=""" & Round(endTime,4) & """>" & content & "</testsuite>"
	End Function
End Class
