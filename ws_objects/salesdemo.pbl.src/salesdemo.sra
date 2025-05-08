$PBExportHeader$salesdemo.sra
$PBExportComments$Generated Application Object
forward
global type salesdemo from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_msg_title = "Sales CRM Demo"




end variables

global type salesdemo from application
string appname = "salesdemo"
string displayname = "SalesDemo"

string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 25.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = true
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ".\image\CRM.ico"
string appruntimeversion = "25.0.0.3683"
boolean manualsession = false
boolean unsupportedapierror = true
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
integer highdpimode = 0
end type
global salesdemo salesdemo

on salesdemo.create
appname="salesdemo"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on salesdemo.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String  ls_theme

//Check Evergreen WebView2 Runtime Installed
If f_chk_webview_installed() = -1 Then
              Return
End If

ls_theme = ProfileString("config.ini", "Theme", "Theme", "Flat Design Blue")
IF ls_theme <> "Do Not Use Themes" THEN
	applytheme(GetCurrentDirectory( ) + "\Theme\" + ls_theme)
END IF

// Profile PB Demo DB V2025
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PB Demo DB V2025;UID=dba;PWD=sql'"


Connect Using SQLCA;

//SQLCA.Autocommit = True


if sqlca.sqlcode = 0 then
   open(w_main)
else
	messagebox('Information','Connect database fail: '+ sqlca.sqlerrtext)
end if

end event

event systemerror;Choose Case error.Number
        Case 220  to 229 //Session Error
                 MessageBox ("Session Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case 230  to 239 //License Error
                 MessageBox ("License Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case 240  to 249 //Token Error
                 MessageBox ("Token Error", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
        Case Else
                 MessageBox ("SystemError", "Number:" + String(error.Number) + "~r~nText:" + error.Text )
End Choose

end event

