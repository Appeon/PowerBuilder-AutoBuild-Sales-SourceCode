$PBExportHeader$w_help.srw
forward
global type w_help from w_base
end type
type wb_website from webbrowser within w_help
end type
end forward

global type w_help from w_base
string tag = "Readme"
integer width = 4119
integer height = 2716
boolean border = true
windowtype windowtype = child!
wb_website wb_website
end type
global w_help w_help

on w_help.create
int iCurrent
call super::create
this.wb_website=create wb_website
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.wb_website
end on

on w_help.destroy
call super::destroy
destroy(this.wb_website)
end on

event open;call super::open;
string ls_dir,ls_name,ls_file
ls_name="README.md"
ls_file=GetCurrentDirectory ( ) + "\" + ls_name


wb_website.navigate(ls_file)	//https://docs.appeon.com/appeon_online_help/snapdevelop2019/features_list/
end event

event resize;call super::resize;
wb_website.width = newwidth
wb_website.height = newheight
end event

type wb_website from webbrowser within w_help
integer width = 2976
integer height = 1268
string defaulturl = "README.txt"
boolean border = false
borderstyle borderstyle = stylebox!
end type

