$PBExportHeader$w_emailsettings.srw
forward
global type w_emailsettings from window
end type
type ddlb_authtype from dropdownlistbox within w_emailsettings
end type
type st_14 from statictext within w_emailsettings
end type
type ddlb_proxytype from dropdownlistbox within w_emailsettings
end type
type sle_proxypassword from singlelineedit within w_emailsettings
end type
type sle_proxyuserid from singlelineedit within w_emailsettings
end type
type sle_proxyport from singlelineedit within w_emailsettings
end type
type sle_proxyhost from singlelineedit within w_emailsettings
end type
type st_13 from statictext within w_emailsettings
end type
type st_12 from statictext within w_emailsettings
end type
type st_11 from statictext within w_emailsettings
end type
type st_10 from statictext within w_emailsettings
end type
type st_9 from statictext within w_emailsettings
end type
type cbx_proxy from checkbox within w_emailsettings
end type
type sle_outputlog from singlelineedit within w_emailsettings
end type
type st_5 from statictext within w_emailsettings
end type
type st_8 from statictext within w_emailsettings
end type
type st_7 from statictext within w_emailsettings
end type
type sle_timeout from singlelineedit within w_emailsettings
end type
type ddlb_protocol from dropdownlistbox within w_emailsettings
end type
type cbx_enabletls from checkbox within w_emailsettings
end type
type cbx_ignoreservercertificate from checkbox within w_emailsettings
end type
type cbx_checkforservercertrevocation from checkbox within w_emailsettings
end type
type cb_cancel from commandbutton within w_emailsettings
end type
type cb_ok from commandbutton within w_emailsettings
end type
type sle_sendername from singlelineedit within w_emailsettings
end type
type st_6 from statictext within w_emailsettings
end type
type st_1 from statictext within w_emailsettings
end type
type sle_server from singlelineedit within w_emailsettings
end type
type sle_userid from singlelineedit within w_emailsettings
end type
type st_2 from statictext within w_emailsettings
end type
type st_3 from statictext within w_emailsettings
end type
type sle_password from singlelineedit within w_emailsettings
end type
type st_4 from statictext within w_emailsettings
end type
type sle_port from singlelineedit within w_emailsettings
end type
type gb_1 from groupbox within w_emailsettings
end type
type gb_2 from groupbox within w_emailsettings
end type
end forward

global type w_emailsettings from window
integer width = 3264
integer height = 1840
boolean titlebar = true
string title = "Email Server Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = ".\image\email.ico"
boolean center = true
ddlb_authtype ddlb_authtype
st_14 st_14
ddlb_proxytype ddlb_proxytype
sle_proxypassword sle_proxypassword
sle_proxyuserid sle_proxyuserid
sle_proxyport sle_proxyport
sle_proxyhost sle_proxyhost
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
cbx_proxy cbx_proxy
sle_outputlog sle_outputlog
st_5 st_5
st_8 st_8
st_7 st_7
sle_timeout sle_timeout
ddlb_protocol ddlb_protocol
cbx_enabletls cbx_enabletls
cbx_ignoreservercertificate cbx_ignoreservercertificate
cbx_checkforservercertrevocation cbx_checkforservercertrevocation
cb_cancel cb_cancel
cb_ok cb_ok
sle_sendername sle_sendername
st_6 st_6
st_1 st_1
sle_server sle_server
sle_userid sle_userid
st_2 st_2
st_3 st_3
sle_password sle_password
st_4 st_4
sle_port sle_port
gb_1 gb_1
gb_2 gb_2
end type
global w_emailsettings w_emailsettings

type variables

end variables

forward prototypes
public subroutine wf_proxyset_enable (boolean abl_proxy)
end prototypes

public subroutine wf_proxyset_enable (boolean abl_proxy);if abl_proxy = true then
	sle_proxyhost.enabled = true
	sle_proxyport.enabled = true
	sle_proxyuserid.enabled = true
	sle_proxypassword.enabled = true
	ddlb_proxytype.enabled = true
else
	sle_proxyhost.enabled = false
	sle_proxyport.enabled = false
	sle_proxyuserid.enabled = false
	sle_proxypassword.enabled = false
	ddlb_proxytype.enabled = false
end if
end subroutine

on w_emailsettings.create
this.ddlb_authtype=create ddlb_authtype
this.st_14=create st_14
this.ddlb_proxytype=create ddlb_proxytype
this.sle_proxypassword=create sle_proxypassword
this.sle_proxyuserid=create sle_proxyuserid
this.sle_proxyport=create sle_proxyport
this.sle_proxyhost=create sle_proxyhost
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.cbx_proxy=create cbx_proxy
this.sle_outputlog=create sle_outputlog
this.st_5=create st_5
this.st_8=create st_8
this.st_7=create st_7
this.sle_timeout=create sle_timeout
this.ddlb_protocol=create ddlb_protocol
this.cbx_enabletls=create cbx_enabletls
this.cbx_ignoreservercertificate=create cbx_ignoreservercertificate
this.cbx_checkforservercertrevocation=create cbx_checkforservercertrevocation
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_sendername=create sle_sendername
this.st_6=create st_6
this.st_1=create st_1
this.sle_server=create sle_server
this.sle_userid=create sle_userid
this.st_2=create st_2
this.st_3=create st_3
this.sle_password=create sle_password
this.st_4=create st_4
this.sle_port=create sle_port
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.ddlb_authtype,&
this.st_14,&
this.ddlb_proxytype,&
this.sle_proxypassword,&
this.sle_proxyuserid,&
this.sle_proxyport,&
this.sle_proxyhost,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.cbx_proxy,&
this.sle_outputlog,&
this.st_5,&
this.st_8,&
this.st_7,&
this.sle_timeout,&
this.ddlb_protocol,&
this.cbx_enabletls,&
this.cbx_ignoreservercertificate,&
this.cbx_checkforservercertrevocation,&
this.cb_cancel,&
this.cb_ok,&
this.sle_sendername,&
this.st_6,&
this.st_1,&
this.sle_server,&
this.sle_userid,&
this.st_2,&
this.st_3,&
this.sle_password,&
this.st_4,&
this.sle_port,&
this.gb_1,&
this.gb_2}
end on

on w_emailsettings.destroy
destroy(this.ddlb_authtype)
destroy(this.st_14)
destroy(this.ddlb_proxytype)
destroy(this.sle_proxypassword)
destroy(this.sle_proxyuserid)
destroy(this.sle_proxyport)
destroy(this.sle_proxyhost)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.cbx_proxy)
destroy(this.sle_outputlog)
destroy(this.st_5)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.sle_timeout)
destroy(this.ddlb_protocol)
destroy(this.cbx_enabletls)
destroy(this.cbx_ignoreservercertificate)
destroy(this.cbx_checkforservercertrevocation)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_sendername)
destroy(this.st_6)
destroy(this.st_1)
destroy(this.sle_server)
destroy(this.sle_userid)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_password)
destroy(this.st_4)
destroy(this.sle_port)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;str_emailsetting str_mailset
str_mailset = message.powerobjectparm
sle_server.text   = str_mailset.ls_server
sle_userid.text   = str_mailset.ls_userid
sle_password.text = str_mailset.ls_password
sle_port.text     = str_mailset.ls_port
sle_timeout.text     = str_mailset.ls_timeout
sle_outputlog.text     = str_mailset.ls_outputlog
sle_sendername.text = str_mailset.ls_sendname
ddlb_authtype.text = str_mailset.ls_authtype

ddlb_protocol.text='All'

If str_mailset.s_checkforserverCertRevocation = 'Y' Then
	cbx_checkforservercertrevocation.checked = True
Else
	cbx_checkforservercertrevocation.checked = False	
End If

If str_mailset.ls_ignoreservercertificate = 'Y' Then
	cbx_ignoreservercertificate.checked = True
Else
	cbx_ignoreservercertificate.checked = False	
End If

If str_mailset.ls_enableTLS = 'Y' Then
	cbx_enabletls.checked = True
Else
	cbx_enabletls.checked = False	
End If
ddlb_proxytype.text = 'Use SOCKS5h Proxy'

if str_mailset.ls_useproxy = 'Y' then
	cbx_proxy.checked = true
	wf_proxyset_enable(true)
	sle_proxyhost.text = str_mailset.ls_proxyhost
	sle_proxyport.text = str_mailset.ls_proxyport
	sle_proxyuserid.text = str_mailset.ls_proxyuserid
	sle_proxypassword.text = str_mailset.ls_proxypassword
	choose case str_mailset.ls_proxytype
		case '0'
			ddlb_proxytype.text = 'Use SOCKS4 Proxy'
		case '1'
			ddlb_proxytype.text = 'Use SOCKS4a Proxy'
		case '2'
			ddlb_proxytype.text = 'Use SOCKS5 Proxy'
		case '3'
			ddlb_proxytype.text = 'Use SOCKS5h Proxy'
	end choose
else
	cbx_proxy.checked = false
	wf_proxyset_enable(false)
end if




end event

type ddlb_authtype from dropdownlistbox within w_emailsettings
integer x = 507
integer y = 892
integer width = 978
integer height = 424
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"0 - AutoDetect (Default)","1 - GSSAPI","2 - LOGIN","3 - NTLM","4 - PLAIN","5 - XOAUTH2"}
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within w_emailsettings
integer x = 105
integer y = 900
integer width = 334
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "AuthType:"
boolean focusrectangle = false
end type

type ddlb_proxytype from dropdownlistbox within w_emailsettings
integer x = 2267
integer y = 772
integer width = 832
integer height = 368
integer taborder = 170
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Use SOCKS4 Proxy","Use SOCKS4A Proxy","Use SOCKS5 Proxy","Use SOCKS5h Proxy"}
borderstyle borderstyle = stylelowered!
end type

type sle_proxypassword from singlelineedit within w_emailsettings
integer x = 2267
integer y = 640
integer width = 832
integer height = 92
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_proxyuserid from singlelineedit within w_emailsettings
integer x = 2267
integer y = 512
integer width = 832
integer height = 92
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_proxyport from singlelineedit within w_emailsettings
integer x = 2267
integer y = 384
integer width = 832
integer height = 92
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_proxyhost from singlelineedit within w_emailsettings
integer x = 2267
integer y = 256
integer width = 832
integer height = 92
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within w_emailsettings
integer x = 1934
integer y = 772
integer width = 343
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proxy Type:"
boolean focusrectangle = false
end type

type st_12 from statictext within w_emailsettings
integer x = 1934
integer y = 640
integer width = 343
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
boolean focusrectangle = false
end type

type st_11 from statictext within w_emailsettings
integer x = 1934
integer y = 512
integer width = 343
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "User ID:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_emailsettings
integer x = 1934
integer y = 384
integer width = 210
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Port:"
boolean focusrectangle = false
end type

type st_9 from statictext within w_emailsettings
integer x = 1934
integer y = 256
integer width = 197
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Host:"
boolean focusrectangle = false
end type

type cbx_proxy from checkbox within w_emailsettings
integer x = 1847
integer y = 128
integer width = 709
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use a Proxy Server"
end type

event clicked;if this.checked = true then
	wf_proxyset_enable(true)
else
	wf_proxyset_enable(false)
end if
end event

type sle_outputlog from singlelineedit within w_emailsettings
integer x = 507
integer y = 1440
integer width = 978
integer height = 92
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "mail.log"
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_emailsettings
integer x = 105
integer y = 1452
integer width = 361
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Output Log:"
boolean focusrectangle = false
end type

type st_8 from statictext within w_emailsettings
integer x = 105
integer y = 1032
integer width = 302
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Protocol:"
boolean focusrectangle = false
end type

type st_7 from statictext within w_emailsettings
integer x = 105
integer y = 780
integer width = 274
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Timeout:"
boolean focusrectangle = false
end type

type sle_timeout from singlelineedit within w_emailsettings
integer x = 507
integer y = 768
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "5"
borderstyle borderstyle = stylelowered!
end type

type ddlb_protocol from dropdownlistbox within w_emailsettings
integer x = 507
integer y = 1024
integer width = 343
integer height = 468
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string item[] = {"All","TLS 1.0","TLS 1.1","TLS 1.2","TLS 1.3"}
borderstyle borderstyle = stylelowered!
end type

type cbx_enabletls from checkbox within w_emailsettings
integer x = 507
integer y = 1336
integer width = 343
integer height = 64
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "EnableTLS"
boolean checked = true
end type

type cbx_ignoreservercertificate from checkbox within w_emailsettings
integer x = 507
integer y = 1236
integer width = 1166
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Verify that the server certificate is valid"
end type

type cbx_checkforservercertrevocation from checkbox within w_emailsettings
integer x = 507
integer y = 1144
integer width = 1184
integer height = 84
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Check if the server certificate is revoked"
end type

type cb_cancel from commandbutton within w_emailsettings
integer x = 2857
integer y = 1612
integer width = 343
integer height = 100
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_emailsettings
integer x = 2505
integer y = 1612
integer width = 343
integer height = 100
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&OK"
boolean default = true
end type

event clicked;str_emailsetting str_mailset

If sle_userid.text = "" Then
	MessageBox("Edit Error", "Userid is required!", StopSign!)
	sle_userid.SetFocus()
	Return
End If
If sle_password.text = "" Then
	MessageBox("Edit Error", "Password is required!", StopSign!)
	sle_password.SetFocus()
	Return
End If
string ls_config
ls_config = 'Config.ini'
SetProfileString ( ls_config, "Settings", "Server", sle_server.text )
SetProfileString ( ls_config, "Settings", "Userid",  sle_userid.text )
SetProfileString ( ls_config, "Settings", "Password", sle_password.text )
SetProfileString ( ls_config, "Settings", "Port", sle_port.text )
SetProfileString ( ls_config, "Settings", "TimeOut", sle_timeout.text )
SetProfileString ( ls_config, "Settings", "OutputLog", sle_outputlog.text )
SetProfileString ( ls_config, "Settings", "SenderName", sle_sendername.text )
SetProfileString ( ls_config, "Settings", "AuthType", ddlb_authtype.text )
if cbx_proxy.checked = true then
	SetProfileString(ls_config,"Settings","UseProxy","Y")
	
	SetProfileString(ls_config,"Settings","ProxyHost",sle_proxyhost.text)
	SetProfileString(ls_config,"Settings","ProxyPort",sle_proxyport.text)
	SetProfileString(ls_config,"Settings","ProxyUserID",sle_proxyuserid.text)
	SetProfileString(ls_config,"Settings","ProxyPassword",sle_proxypassword.text)
	choose case ddlb_proxytype.text
		case 'Use SOCKS4 Proxy'
			SetProfileString(ls_config,"Settings","ProxyType",'0')
			str_mailset.ls_proxytype = '0'
		case  'Use SOCKS4a Proxy'
			SetProfileString(ls_config,"Settings","ProxyType",'1')
			str_mailset.ls_proxytype = '1'
		case   'Use SOCKS5 Proxy'
			SetProfileString(ls_config,"Settings","ProxyType",'2')
			str_mailset.ls_proxytype = '2'
		case 'Use SOCKS5h Proxy'
			SetProfileString(ls_config,"Settings","ProxyType",'3')
			str_mailset.ls_proxytype = '3'
	end choose
	str_mailset.ls_useproxy ='Y'
	str_mailset.ls_proxyhost = sle_proxyhost.text
	str_mailset.ls_proxyport = sle_proxyport.text
	str_mailset.ls_proxyuserid = sle_proxyuserid.text
	str_mailset.ls_proxypassword = sle_proxypassword.text
else
	SetProfileString(ls_config,"Settings","UseProxy","N")
	str_mailset.ls_useproxy ='N'
end if



str_mailset.ls_server =sle_server.text
str_mailset.ls_port = sle_port.text
str_mailset.ls_userid = sle_userid.text
str_mailset.ls_password = sle_password.text
str_mailset.ls_sendname = sle_sendername.text
str_mailset.ls_timeout = sle_timeout.text 
str_mailset.ls_outputlog = sle_outputlog.text
str_mailset.ls_authtype = ddlb_authtype.text

If cbx_checkforservercertrevocation.checked Then
	SetProfileString ( ls_config, "Settings", "CheckforServerCertRevocation", "Y" )
	str_mailset.s_checkforserverCertRevocation = "Y"
Else
	SetProfileString ( ls_config, "Settings", "CheckforServerCertRevocation", "N" )
	str_mailset.s_checkforserverCertRevocation = "N"
	
End If
If cbx_ignoreservercertificate.checked Then
	SetProfileString ( ls_config, "Settings", "IgnoreServerCertificate", "Y" )
	str_mailset.ls_ignoreservercertificate = "Y"
Else
	SetProfileString ( ls_config, "Settings", "IgnoreServerCertificate", "N" )
	str_mailset.ls_ignoreservercertificate = "N"
End If
If cbx_enabletls.checked Then

	SetProfileString ( ls_config, "Settings", "EnableTLS", "Y" )
	str_mailset.ls_enableTLS = "Y"
Else
	SetProfileString ( ls_config, "Settings", "EnableTLS", "N" )
	str_mailset.ls_enableTLS = "N"
End If

Choose Case ddlb_protocol.Text
	Case "All"
		SetProfileString ( ls_config, "Settings", "ServerProtocol", "0" )
		str_mailset.ls_serverprotocol = "0"
	Case "TLS 1.0"
		SetProfileString ( ls_config, "Settings", "ServerProtocol", "1" )
		str_mailset.ls_serverprotocol = "1"
		
	Case "TLS 1.1"
		SetProfileString ( ls_config, "Settings", "ServerProtocol", "2" )
		str_mailset.ls_serverprotocol = "2"
		
	Case "TLS 1.2"
		SetProfileString ( ls_config, "Settings", "ServerProtocol", "3" )
		str_mailset.ls_serverprotocol = "3"
		
	Case "TLS 1.3"
		SetProfileString ( ls_config, "Settings", "ServerProtocol", "4" )
		str_mailset.ls_serverprotocol = "4"
		
End Choose


Closewithreturn(Parent,str_mailset)
end event

type sle_sendername from singlelineedit within w_emailsettings
integer x = 507
integer y = 640
integer width = 978
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_emailsettings
integer x = 105
integer y = 644
integer width = 407
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sender Name:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_emailsettings
integer x = 105
integer y = 136
integer width = 361
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMTP Server:"
boolean focusrectangle = false
end type

type sle_server from singlelineedit within w_emailsettings
integer x = 507
integer y = 128
integer width = 978
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_userid from singlelineedit within w_emailsettings
integer x = 507
integer y = 384
integer width = 978
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_emailsettings
integer x = 105
integer y = 384
integer width = 366
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "User ID:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_emailsettings
integer x = 105
integer y = 512
integer width = 293
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password:"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_emailsettings
integer x = 507
integer y = 512
integer width = 978
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_emailsettings
integer x = 105
integer y = 256
integer width = 151
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Port:"
boolean focusrectangle = false
end type

type sle_port from singlelineedit within w_emailsettings
integer x = 507
integer y = 256
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "587"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_emailsettings
integer x = 50
integer y = 32
integer width = 1696
integer height = 1572
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Normal Settings"
end type

type gb_2 from groupbox within w_emailsettings
integer x = 1792
integer y = 32
integer width = 1408
integer height = 1572
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proxy Settings"
end type

