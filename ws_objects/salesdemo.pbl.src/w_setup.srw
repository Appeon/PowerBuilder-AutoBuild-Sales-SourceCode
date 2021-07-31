$PBExportHeader$w_setup.srw
forward
global type w_setup from window
end type
type ddlb_theme from dropdownlistbox within w_setup
end type
type ddlb_1 from dropdownlistbox within w_setup
end type
type st_theme from statictext within w_setup
end type
type cb_close from u_button within w_setup
end type
type cb_save from u_button within w_setup
end type
type dw_setup from u_dw within w_setup
end type
end forward

global type w_setup from window
integer width = 2034
integer height = 628
boolean titlebar = true
string title = "Settings"
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
ddlb_theme ddlb_theme
ddlb_1 ddlb_1
st_theme st_theme
cb_close cb_close
cb_save cb_save
dw_setup dw_setup
end type
global w_setup w_setup

type variables
String is_file
String is_theme
String is_theme_path //= "C:\Program Files (x86)\Appeon19\Shared\PowerBuilder\theme190\"
end variables

forward prototypes
public subroutine of_itemchanged (string as_name, string as_data)
public subroutine of_deactive ()
public subroutine of_add_theme ()
end prototypes

public subroutine of_itemchanged (string as_name, string as_data);//String ls_defaulturl
//String ls_hosttype
//String ls_modeltype
//
//Choose Case as_name
//	Case "hosttype"
//		ls_modeltype = ddlb_modeltype.Text
//		ls_hosttype = as_data
//	Case "modeltype"
//		ls_modeltype = ddlb_modeltype.Text
//		If rb_local.Checked Then
//			ls_hosttype = "1"
//		Else
//			ls_hosttype = "2"
//		End IF
//End Choose
//
//IF ls_hosttype = "1" Then
//	Choose Case ls_modeltype
//		Case "DataStore"
//			ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
//		Case "ModelStore"
//			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
//		Case "SqlModelMapper"
//			ls_defaulturl = ProfileString(is_file, "LocalHost", "sqlmodelmapperdefaulturl", "")
//	End Choose
//Else
//	Choose Case ls_modeltype
//		Case "DataStore"
//			ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
//		Case "ModelStore"
//			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
//		Case "SqlModelMapper"
//			ls_defaulturl = ProfileString(is_file, "CloudHost", "sqlmodelmapperdefaulturl", "")
//	End Choose
//End IF
//sle_url.Text = ls_defaulturl
////dw_setup.SetItem(1, "url", ls_defaulturl)
end subroutine

public subroutine of_deactive ();//IF IsValid(w_main) THEN
//	w_main.uo_nav.uo_setting_bt.Event ue_deactive()
//	w_main.is_model = ""
//END IF
end subroutine

public subroutine of_add_theme ();Int i
String ls_theme_name
String ls_current_path
ls_current_path = GetCurrentDirectory( )

is_theme_path = ls_current_path + "\Theme\"

ddlb_1.DirList(is_theme_path+'*.*', 32768+16) 

For i = 2 To ddlb_1.totalitems( )
	ls_theme_name = ddlb_1.text(i)
	IF Left(ls_theme_name,1) = "[" THEN ls_theme_name = Mid(ls_theme_name, 2)
	IF Right(ls_theme_name,1) = "]" THEN ls_theme_name = Left(ls_theme_name, Len(ls_theme_name) - 1)
	ls_theme_name = Trim(ls_theme_name)
	IF FileExists(is_theme_path + ls_theme_name + "\theme.json") THEN
		ddlb_theme.Additem(ls_theme_name)
	END IF
Next 
ddlb_theme.Additem("Do Not Use Themes")

ChangeDirectory(ls_current_path)
end subroutine

on w_setup.create
this.ddlb_theme=create ddlb_theme
this.ddlb_1=create ddlb_1
this.st_theme=create st_theme
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_setup=create dw_setup
this.Control[]={this.ddlb_theme,&
this.ddlb_1,&
this.st_theme,&
this.cb_close,&
this.cb_save,&
this.dw_setup}
end on

on w_setup.destroy
destroy(this.ddlb_theme)
destroy(this.ddlb_1)
destroy(this.st_theme)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_setup)
end on

event open;String ls_theme
This.SetRedraw(False)
is_file = "apisetup.ini"
ls_theme = ProfileString(is_file, "Setup", "Theme", "Flat Design Blue")

of_add_theme()
ddlb_theme.Text = ls_theme
is_theme = ls_theme


This.SetRedraw(True)


end event

event closequery;//of_deactive()
end event

type ddlb_theme from dropdownlistbox within w_setup
integer x = 562
integer y = 100
integer width = 1029
integer height = 504
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_setup
boolean visible = false
integer x = 87
integer y = 100
integer width = 869
integer height = 476
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_theme from statictext within w_setup
integer x = 69
integer y = 112
integer width = 462
integer height = 96
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Theme:"
alignment alignment = right!
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type cb_close from u_button within w_setup
integer x = 1230
integer y = 340
integer width = 366
integer height = 96
integer taborder = 30
integer textsize = -10
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;call super::clicked;
//dw_setup.accepttext()
//
//IF dw_setup.modifiedcount() > 0 Then
//	Messagebox(gs_msg_title, "Please save the data first.")
//	Return 1
//End IF

Close(parent)
end event

type cb_save from u_button within w_setup
integer x = 553
integer y = 340
integer width = 366
integer height = 96
integer taborder = 20
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;String ls_theme
String ls_msg
Int li_ret



ls_theme = Trim(ddlb_theme.Text )
//applyskintheme(ls_theme)
IF ls_theme <> is_theme  AND  ls_theme = "Do Not Use Themes" THEN
	ls_msg = "~r~nYou modified the theme. You must restart your application for the changes to take effect.~r~n"
	ls_msg += "~r~nDo you want to exit the application and then run it again?"
//ELSE
//	ApplyTheme (is_theme_path + ls_theme)
END IF

SetProfileString(is_file, "Setup", "Theme", ls_theme)

IF Len(ls_msg) > 0 THEN
	li_ret = Messagebox(gs_msg_title, "Saved the settings successfully." + ls_msg, Question!, YesNo!, 2)
	Close(parent)
	IF li_ret = 1 THEN
		Close(w_main)
	END IF
ELSE
	Messagebox(gs_msg_title, "Saved the settings successfully." + ls_msg)

	IF Not Isvalid(w_main) Then 
		Open(w_main)
	else
		IF ls_theme <> is_theme THEN
			w_main.dynamic of_closewindow("Close All") // close all opening window
			ApplyTheme (is_theme_path + ls_theme)
			w_main.dynamic of_refreshtheme()
			w_main.dynamic of_refresh_ribbonbartheme()
			is_theme = ls_theme
		END IF
	end  if 
	Close(parent)
END IF
end event

type dw_setup from u_dw within w_setup
boolean visible = false
integer x = 9
integer y = 952
integer width = 2304
integer height = 736
integer taborder = 10
string dataobject = "d_setup"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_defaulturl
String ls_hosttype
String ls_modeltype

Choose Case dwo.Name
	Case "hosttype"
		ls_modeltype = This.Getitemstring( 1, "modeltype")
		ls_hosttype = data
	Case "modeltype"
		ls_modeltype = data
		ls_hosttype = This.Getitemstring( 1, "hosttype")
End Choose

IF ls_hosttype = "1" Then
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "modelstoredefaulturl", "")
		Case "SqlModelMapper"
			ls_defaulturl = ProfileString(is_file, "LocalHost", "sqlmodelmapperdefaulturl", "")
	End Choose
Else
	Choose Case ls_modeltype
		Case "DataStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "datastoredefaulturl", "")
		Case "ModelStore"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "modelstoredefaulturl", "")
		Case "SqlModelMapper"
			ls_defaulturl = ProfileString(is_file, "CloudHost", "sqlmodelmapperdefaulturl", "")
	End Choose
End IF

//dw_setup.SetItem(1, "url", ls_defaulturl)
end event

