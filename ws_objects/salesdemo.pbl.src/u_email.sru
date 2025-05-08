$PBExportHeader$u_email.sru
forward
global type u_email from userobject
end type
type st_2 from statictext within u_email
end type
type st_1 from statictext within u_email
end type
type cb_cancel from commandbutton within u_email
end type
type cb_send from commandbutton within u_email
end type
type cbx_async from checkbox within u_email
end type
type cbx_htmlformat from checkbox within u_email
end type
type cb_htmlcase from commandbutton within u_email
end type
type cb_settings from commandbutton within u_email
end type
type ddlb_encoding from dropdownlistbox within u_email
end type
type st_16 from statictext within u_email
end type
type ddlb_priority from dropdownlistbox within u_email
end type
type st_15 from statictext within u_email
end type
type cb_clear from commandbutton within u_email
end type
type cb_attachment from commandbutton within u_email
end type
type sle_attachments from singlelineedit within u_email
end type
type sle_subject from singlelineedit within u_email
end type
type st_14 from statictext within u_email
end type
type st_11 from statictext within u_email
end type
type sle_bcc from singlelineedit within u_email
end type
type sle_cc from singlelineedit within u_email
end type
type sle_to from singlelineedit within u_email
end type
type st_13 from statictext within u_email
end type
type rte_body from richtextedit within u_email
end type
type mle_body from multilineedit within u_email
end type
end forward

global type u_email from userobject
integer width = 3904
integer height = 2336
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_send cb_send
cbx_async cbx_async
cbx_htmlformat cbx_htmlformat
cb_htmlcase cb_htmlcase
cb_settings cb_settings
ddlb_encoding ddlb_encoding
st_16 st_16
ddlb_priority ddlb_priority
st_15 st_15
cb_clear cb_clear
cb_attachment cb_attachment
sle_attachments sle_attachments
sle_subject sle_subject
st_14 st_14
st_11 st_11
sle_bcc sle_bcc
sle_cc sle_cc
sle_to sle_to
st_13 st_13
rte_body rte_body
mle_body mle_body
end type
global u_email u_email

type variables
String is_Attachments[], is_empty[]
n_SmtpClient ismtp_email
str_emailsetting str_email
n_string n_str
String is_ContantID = "LinkResourceI"

end variables

forward prototypes
public function integer of_checkdata ()
end prototypes

public function integer of_checkdata ();//Check "Email Server Settings" and "Email To"

If str_email.ls_server = "" Then
	Messagebox('Email','You must specify Server in the Server Settings window.' ,Exclamation!, OK! )
	cb_settings.SetFocus()
	Return -1
End If

If Trim(sle_To.Text) = "" Then
	Messagebox('Email','To field is a required field!' ,Exclamation!, OK! )
	sle_to.SetFocus()
	Return -1
End If


Return 1
end function

on u_email.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_send=create cb_send
this.cbx_async=create cbx_async
this.cbx_htmlformat=create cbx_htmlformat
this.cb_htmlcase=create cb_htmlcase
this.cb_settings=create cb_settings
this.ddlb_encoding=create ddlb_encoding
this.st_16=create st_16
this.ddlb_priority=create ddlb_priority
this.st_15=create st_15
this.cb_clear=create cb_clear
this.cb_attachment=create cb_attachment
this.sle_attachments=create sle_attachments
this.sle_subject=create sle_subject
this.st_14=create st_14
this.st_11=create st_11
this.sle_bcc=create sle_bcc
this.sle_cc=create sle_cc
this.sle_to=create sle_to
this.st_13=create st_13
this.rte_body=create rte_body
this.mle_body=create mle_body
this.Control[]={this.st_2,&
this.st_1,&
this.cb_cancel,&
this.cb_send,&
this.cbx_async,&
this.cbx_htmlformat,&
this.cb_htmlcase,&
this.cb_settings,&
this.ddlb_encoding,&
this.st_16,&
this.ddlb_priority,&
this.st_15,&
this.cb_clear,&
this.cb_attachment,&
this.sle_attachments,&
this.sle_subject,&
this.st_14,&
this.st_11,&
this.sle_bcc,&
this.sle_cc,&
this.sle_to,&
this.st_13,&
this.rte_body,&
this.mle_body}
end on

on u_email.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_send)
destroy(this.cbx_async)
destroy(this.cbx_htmlformat)
destroy(this.cb_htmlcase)
destroy(this.cb_settings)
destroy(this.ddlb_encoding)
destroy(this.st_16)
destroy(this.ddlb_priority)
destroy(this.st_15)
destroy(this.cb_clear)
destroy(this.cb_attachment)
destroy(this.sle_attachments)
destroy(this.sle_subject)
destroy(this.st_14)
destroy(this.st_11)
destroy(this.sle_bcc)
destroy(this.sle_cc)
destroy(this.sle_to)
destroy(this.st_13)
destroy(this.rte_body)
destroy(this.mle_body)
end on

event constructor;ismtp_email = Create n_SmtpClient

string ls_config
ls_config = 'Config.ini'
str_email.ls_server = ProfileString(ls_config,"Settings","Server","")
str_email.ls_port = ProfileString(ls_config,"Settings","Port","")
str_email.ls_userid = ProfileString(ls_config,"Settings","UserID","")
str_email.ls_password = ProfileString(ls_config,"Settings","Password","")
str_email.ls_sendname = ProfileString(ls_config,"Settings","SendName","")
str_email.ls_timeout = ProfileString(ls_config,"Settings","TimeOut","")
str_email.ls_serverprotocol = ProfileString(ls_config,"Settings","ServerProtocol","")
str_email.s_checkforserverCertRevocation = ProfileString(ls_config,"Settings","CheckforServerCertRevocation","")
str_email.ls_ignoreservercertificate = ProfileString(ls_config,"Settings","IgnoreServerCertificate","")
str_email.ls_enableTLS = ProfileString(ls_config,"Settings","EnableTLS","")
str_email.ls_outputlog = ProfileString(ls_config,"Settings","Outputlog","")
str_email.ls_useproxy = ProfileString(ls_config,"Settings","UseProxy","")
str_email.ls_proxyhost = ProfileString(ls_config,"Settings","ProxyHost","")
str_email.ls_proxyport = ProfileString(ls_config,"Settings","ProxyPort","")
str_email.ls_proxyuserid = ProfileString(ls_config,"Settings","ProxyUserID","")
str_email.ls_proxypassword = ProfileString(ls_config,"Settings","ProxyPassword","")
str_email.ls_proxytype = ProfileString(ls_config,"Settings","ProxyType","")
str_email.ls_authtype= ProfileString(ls_config,"Settings","AuthType","")
n_str = Create n_string

end event

event destructor;
Destroy ismtp_email
end event

type st_2 from statictext within u_email
integer x = 23
integer y = 188
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cc:"
boolean focusrectangle = false
end type

type st_1 from statictext within u_email
integer x = 23
integer y = 784
integer width = 224
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Body:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within u_email
integer x = 3488
integer y = 2184
integer width = 389
integer height = 100
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Cance&l"
end type

event clicked;Integer li_Return

li_Return = ismtp_email.SendAsyncCancel()

If li_Return  = 1 Then
	Messagebox('','Cancel sending email successfully.')
Else
	Messagebox('','Failed to cancel the sending email.')
End If
end event

type cb_send from commandbutton within u_email
integer x = 3118
integer y = 2184
integer width = 343
integer height = 100
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Send"
end type

event clicked;
String ls_To, ls_Cc, ls_Bcc, ls_ToArray[], ls_CcArray[], ls_BccArray[]
String ls_Subject,ls_Body, ls_resourcefile
Integer i, li_Return, li_filenum, li_proxytype
String ls_Log,ls_htmlstring,ls_currentdir


//Check required field.
If of_checkdata () < 0 Then Return

//Get Recipients 
ls_To = sle_to.Text 
ls_To = n_str.of_ReplaceAll(ls_To,' ', '',False)
ls_To = n_str.of_ReplaceAll(ls_To,',', ';',False)
n_str.of_StringToArray(ls_To,';', ls_ToArray[])

ls_Cc = sle_cc.Text 
ls_Cc = n_str.of_ReplaceAll(ls_Cc,' ', '',False)
ls_Cc = n_str.of_ReplaceAll(ls_Cc,',', ';',False)
n_str.of_StringToArray(ls_Cc,';', ls_CCArray[])

ls_Bcc = sle_bcc.Text 
ls_Bcc = n_str.of_ReplaceAll(ls_Bcc,' ', '',False)
ls_Bcc = n_str.of_ReplaceAll(ls_Bcc,',', ';',False)
n_str.of_StringToArray(ls_Bcc,';', ls_BccArray[])

//Get Subject and Body
ls_Subject = sle_Subject.Text
ls_Body = mle_body.Text

//Reset SMTPClient Message
ismtp_email.message.reset()

// Set Email Server Basic Infomation
ismtp_email.Host = str_email.ls_server
ismtp_email.Port = Integer(str_email.ls_port)
ismtp_email.Username = str_email.ls_userid
ismtp_email.password = str_email.ls_password
ismtp_email.message.SetSender( str_email.ls_userid,  str_email.ls_sendname )
ismtp_email.timeout = Integer(str_email.ls_timeout)

//Set Email Auth
If  str_email.ls_enabletls= 'Y' Then
	ismtp_email.EnableTLS = True
Else
	ismtp_email.EnableTLS = False
End If
If str_email.s_checkforserverCertRevocation = 'Y' Then
	ismtp_email.CheckforServerCertRevocation = True
Else
	ismtp_email.CheckforServerCertRevocation = False	
End If

If str_email.ls_ignoreservercertificate = 'Y' Then
	ismtp_email.IgnoreServerCertificate = True
Else
	ismtp_email.IgnoreServerCertificate = False
End If
If Integer(str_email.ls_serverprotocol) >= 0 Then
	ismtp_email.SecureProtocol = Integer(str_email.ls_serverprotocol)
End If

//Set Email To,Cc,Bcc, Subject,
For i = 1 To UpperBound(ls_ToArray[])
	ismtp_email.message.AddRecipient(ls_ToArray[i])
Next 
For i = 1 To UpperBound(ls_CcArray[])
	ismtp_email.message.AddCc(ls_CcArray[i])
Next 
For i = 1 To UpperBound(ls_BccArray[])
	ismtp_email.message.AddBcc(ls_BccArray[i])
Next 

//Set Email Attachments
For i = 1 To UpperBound(is_Attachments[])
	ismtp_email.message.AddAttachment(is_Attachments[i])
Next 

//Set Email Subjet, Body
ismtp_email.message.Subject = sle_Subject.Text

If cbx_htmlformat.checked Then

ls_currentdir = GetCurrentDirectory( )
	If rte_Body.SaveDocument (ls_currentdir + "\temp.html" ,FileTypeHTML! ) = 1 Then
		li_FileNum = FileOpen( ls_currentdir + "\temp.html",TextMode!,Read!)
		If li_FileNum > 0 Then
			If FileReadEx ( li_FileNum, ls_HTMLString) > 0 Then
				ismtp_email.message.HtmlBody = ls_HTMLString
			Else
				Messagebox('','Failed to read the html file data.')
				Return -1
			End If
			FileClose(li_FileNum)
		Else
			Messagebox('','Failed to open the html file.')
			Return -1
		End If
	Else
		Messagebox('','Failed to save the rich text data to html file.')
		Return -1
	End If
Else
	ismtp_email.message.Textbody = mle_Body.Text
End If
ChangeDirectory(ls_currentdir)
//Set Priority
Choose Case ddlb_priority.Text 
	Case "Low"
		ismtp_email.message.priority = 1
	Case "Normal"
		ismtp_email.message.priority = 0
	Case "High"
		ismtp_email.message.priority = 2
End Choose 

//Set Encoding
ismtp_email.message.encoding=ddlb_encoding.text
//Choose Case ddlb_Encoding.Text 
//	Case "UTF-8"
//		ismtp_email.message.Encoding = '0'
//	Case "UNICODE"
//		ismtp_email.message.Encoding = '1'
//	Case "ASICC"
//		ismtp_email.message.Encoding = '2'
//End Choose 

//Set AuthType
If Integer(Left(str_email.ls_ProxyType, 1)) >= 0 Then
            ismtp_email.Authtype = Integer(Left(str_email.ls_ProxyType, 1))
End If


//Set Proxy
If str_email.ls_useproxy = 'Y' Then
    If str_email.ls_ProxyType = "" Then 
	   li_ProxyType = 3
	Else
		li_ProxyType = Integer(str_email.ls_ProxyType)
	End If

	 If Trim(str_email.ls_ProxyType) = '' and Trim(str_email.ls_Proxyuserid) = '' Then
		ismtp_email.SetProxy(str_email.ls_proxyhost, integer(str_email.ls_proxyport) )
	 ElseIf Trim(str_email.ls_Proxyuserid) = "" Then
			ismtp_email.SetProxy(str_email.ls_proxyhost, integer(str_email.ls_proxyport) , li_ProxyType )
	 Else
		ismtp_email.SetProxy(str_email.ls_proxyhost, integer(str_email.ls_proxyport), li_ProxyType, Trim(str_email.ls_Proxyuserid),trim(str_email.ls_proxypassword) )
	 End If
Else
      ismtp_email.SetProxy("", 0)
End If

// Send
SetPointer(HourGlass!)
If cbx_async.Checked Then
	cb_cancel.Enabled = True
	li_Return = ismtp_email.SendAsync()
	//cb_cancel.Enabled = False	
Else
	cb_cancel.Enabled = False
	li_Return = ismtp_email.Send()
	//Set Log
//	ismtp_email.logfile(ls_log)
//	If Trim(str_email.ls_outputlog) <> "" Then
//		n_str.of_log(ls_log)
//	End If
	ismtp_email.logfile(str_email.ls_outputlog)
	
	If li_Return = 1 Then
		Messagebox('','Send email successfully.')
	Else
		Messagebox("Return "+String(li_Return),'Failed to send the email. ~r~n~r~n' + ls_log) 
	End If	
End If

SetPointer(Arrow!)






end event

type cbx_async from checkbox within u_email
integer x = 2601
integer y = 2024
integer width = 818
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Send email asynchronously"
end type

event clicked;If This.Checked Then
	If Pos(sle_Subject.text, '(Async)') = 0 Then
		sle_Subject.text = sle_Subject.text + ' (Async)'
	End If
Else
	sle_Subject.text = n_str.of_ReplaceAll(sle_Subject.text,' (Async)','',False)
End If
end event

type cbx_htmlformat from checkbox within u_email
integer x = 969
integer y = 2024
integer width = 859
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Support HTML as email content"
end type

event clicked;
If This.Checked Then
	rte_body.Visible = True
	mle_body.visible = False
	If Pos(sle_Subject.text, '(HTML Format)') = 0 Then
		sle_Subject.text = sle_Subject.text + ' (HTML Format)'
	End If
//	cb_htmlcase.enabled = true
Else
	rte_body.Visible = False
	mle_body.visible = True
	sle_Subject.text = n_str.of_ReplaceAll(sle_Subject.text,' (HTML Format)','',False)
//	cb_htmlcase.enabled = false
End If
	

end event

type cb_htmlcase from commandbutton within u_email
integer x = 2016
integer y = 2008
integer width = 389
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "HTML Sample"
end type

event clicked;
string ls_currentdir
ls_currentdir = GetCurrentDirectory( )
rte_Body.InsertDocument (  ".\testcase.rtf", True)
cbx_htmlformat.checked = True
cbx_htmlformat.Event Clicked()
ChangeDirectory(ls_currentdir)

end event

type cb_settings from commandbutton within u_email
integer x = 270
integer y = 2008
integer width = 521
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Server Se&ttings..."
end type

event clicked;Openwithparm(w_emailsettings,str_email)

if isvalid(message.powerobjectparm) then  str_email = message.powerobjectparm
end event

type ddlb_encoding from dropdownlistbox within u_email
integer x = 1102
integer y = 660
integer width = 503
integer height = 404
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "UTF-8"
boolean allowedit = true
boolean sorted = false
string item[] = {"UTF-8","Windows-1252","gb2312"}
borderstyle borderstyle = stylelowered!
end type

type st_16 from statictext within u_email
integer x = 800
integer y = 672
integer width = 261
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Encoding:"
boolean focusrectangle = false
end type

type ddlb_priority from dropdownlistbox within u_email
integer x = 274
integer y = 660
integer width = 411
integer height = 404
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Normal"
boolean sorted = false
string item[] = {"Low","Normal","High"}
borderstyle borderstyle = stylelowered!
end type

type st_15 from statictext within u_email
integer x = 23
integer y = 664
integer width = 224
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Priority:"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within u_email
integer x = 3529
integer y = 528
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clea&r"
end type

event clicked;is_Attachments[] = is_empty[]
sle_attachments.text = ''
end event

type cb_attachment from commandbutton within u_email
integer x = 3104
integer y = 528
integer width = 411
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Attachment..."
end type

event clicked;String ls_FilePath, ls_FileName[] , ls_AttachFileNameList
Integer li_ret, i
string ls_currentdir
ls_currentdir = GetCurrentDirectory( )


li_ret = GetFileOpenName( "Attach File(s)", ls_FilePath,ls_FileName[], "*","All Files(*.*),*.*","",  2 )

If li_ret > 0 Then
	If UpperBound(ls_FileName[]) = 1 Then
		If UpperBound(is_Attachments[]) = 0 Then
			sle_Attachments.text = ls_FileName[1]
			is_Attachments[1] = ls_FilePath 
		Else
			sle_Attachments.text = sle_Attachments.text + "; " + ls_FileName[1]
			is_Attachments[UpperBound(is_Attachments[]) + 1] =  ls_FileName[1]
		End If
	Else
		For i = 1 To UpperBound(ls_FileName[])
			If UpperBound(is_Attachments[]) = 0 Then
				sle_Attachments.text = ls_FileName[i]
				is_Attachments[1] = ls_FilePath + "\" + ls_FileName[i]
			Else
				sle_Attachments.text = sle_Attachments.text + "; " + ls_FileName[i]
				is_Attachments[UpperBound(is_Attachments[]) + 1] = ls_FilePath + "\" + ls_FileName[i]
			End If
		Next
	End If

End If

ChangeDirectory(ls_currentdir)
end event

type sle_attachments from singlelineedit within u_email
integer x = 274
integer y = 532
integer width = 2793
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type sle_subject from singlelineedit within u_email
integer x = 274
integer y = 408
integer width = 3589
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "This a test email"
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within u_email
integer x = 23
integer y = 420
integer width = 247
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subject:"
boolean focusrectangle = false
end type

type st_11 from statictext within u_email
integer x = 23
integer y = 296
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bcc:"
boolean focusrectangle = false
end type

type sle_bcc from singlelineedit within u_email
integer x = 274
integer y = 288
integer width = 3589
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_cc from singlelineedit within u_email
integer x = 274
integer y = 168
integer width = 3589
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_to from singlelineedit within u_email
integer x = 274
integer y = 48
integer width = 3589
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within u_email
integer x = 23
integer y = 56
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type rte_body from richtextedit within u_email
boolean visible = false
integer x = 274
integer y = 768
integer width = 3579
integer height = 1224
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean init_wordwrap = true
boolean init_tabsvisible = true
boolean init_inputfieldsvisible = true
boolean init_inputfieldnamesvisible = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_headerfooter = true
boolean init_popmenu = true
borderstyle borderstyle = stylelowered!
end type

type mle_body from multilineedit within u_email
integer x = 274
integer y = 788
integer width = 3589
integer height = 1184
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Hello World"
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

