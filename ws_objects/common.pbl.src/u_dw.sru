$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event type integer ue_importjson ( )
event type integer ue_exportjson ( )
end type
global u_dw u_dw

forward prototypes
public function integer of_retrieve ()
public function integer of_importjson_dddw (string as_column_name, string as_data_json)
public function integer of_importjson_dddw (string as_column_name, string as_data_json, boolean ab_add_empty_row)
end prototypes

event type integer ue_importjson();String ls_path, ls_file
String ls_json
String ls_direct
String ls_error
Integer li_rct
Integer li_row
Integer li_filenum

ls_direct = GetCurrentDirectory()

li_rct = GetFileOpenName("Select Json File", ls_path, ls_file, "Json", "Json File(*.json),*.json")

IF li_rct = -1 Then
	ChangeDirectory(ls_direct)
	Return -1
End if

li_filenum = FileOpen(ls_path, LineMode!)
IF li_filenum <> -1 Then
	FileRead(li_filenum, ls_json)
	
	IF(len(ls_json) > 0 and ls_json <> "") Then
		li_rct = This.ImportJson(ls_json, ls_error, Primary!, 1)
		IF li_rct > 0 Then
		Else
			Messagebox("Prompt", "Importing Json File failed !")
			Return -1
		END IF
		li_row = This.Rowcount()
		This.scrolltorow(li_row)
	End IF
End IF

FileClose(li_filenum)
ChangeDirectory(ls_direct)

return 1
end event

event type integer ue_exportjson();String ls_json
String ls_direct
String ls_filepath
String ls_file
Integer li_rc

ls_json = This.ExportJson()

ls_direct = GetCurrentDirectory() 

IF Not DirectoryExists(ls_direct + "\JSON") Then
	CreateDirectory(ls_direct + "\JSON")
End IF

ls_filepath = ls_direct + "\JSON\example.json"
ls_file = "example.json"
li_rc = GetFileSaveName("Save Json", ls_filepath, ls_file, "Json", "Json File(*.Json), *.Json" )

IF li_rc <> 1 Then
	ChangeDirectory(ls_direct)
	Return -1
End IF

IF FileExists(ls_filepath) Then
	FileDelete(ls_filepath)
End IF

li_rc = FileOpen(ls_filepath, LineMode!, Write!, LockWrite!, Replace!)

IF li_rc <> -1 Then
	FileWrite(li_rc, ls_json)
	Messagebox("Success", "Exporting JSON file was successful!~r~n" +&
	                   "The file was saved to " + ls_filepath)
End IF
FileClose(li_rc)

ChangeDirectory(ls_direct)
Return 1
end event

public function integer of_retrieve ();
return 1
end function

public function integer of_importjson_dddw (string as_column_name, string as_data_json);Return of_importjson_dddw(as_column_name, as_data_json, false)
end function

public function integer of_importjson_dddw (string as_column_name, string as_data_json, boolean ab_add_empty_row);DatawindowChild ldwc
Int li_return

This.GetChild(as_column_name, ldwc)
ldwc.Reset()

string message1

li_return = ldwc.ImportJsonByKey(as_data_json, message1)

If ab_add_empty_row Then
	ldwc.InsertRow(1)
End If

Return li_return
end function

on u_dw.create
end on

on u_dw.destroy
end on

