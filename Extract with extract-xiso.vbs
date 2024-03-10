Option Explicit

Dim FSO, FLD, FIL, TS, SHELL
Dim strInput, strContent, strPath
Const ForReading = 1, ForWriting = 2, ForAppending = 8 

Set SHELL = CreateObject("wscript.shell")

'Change as needed - this names a folder at the same location as this script
strInput  = InputBox( "Enter path for the Iso-Files: ")

'Create the filesystem object
Set FSO = CreateObject("Scripting.FileSystemObject")
'Get a reference to the folder you want to search
set FLD = FSO.GetFolder(strInput)

'loop through the folder and get the file names
For Each Fil In FLD.Files
    'MsgBox Fil.Name
    If UCase(FSO.GetExtensionName(Fil.Name)) = "LTR" Then

        'Open the file to read
        Set TS = FSO.OpenTextFile(Fil.Path, ForReading)
        'Read the contents into a variable
        strContent = TS.ReadAll
        'Close the file
        TS.Close

        'Replace the errant strings
        IF INSTR(strContent,"SomeContentToReplace")>0 THEN
             strContent = Replace(strContent, "SomeContentToReplace", "MyNewContent")
        END IF
        IF INSTR(strContent,"MoreContentToReplace")>0 THEN
            strContent = Replace(strContent, "MoreContentToReplace", "MyOtherNewContent")
        END IF

        'Open the file to overwrite the contents
        Set TS = FSO.OpenTextFile(Fil.Path, ForWriting)
        'Write the contents back
        TS.Write strContent
        'Close the current file
        TS.Close

    End If
Next


'Clean up
Set TS = Nothing
Set FLD = Nothing
Set FSO = Nothing

MsgBox "Done!"