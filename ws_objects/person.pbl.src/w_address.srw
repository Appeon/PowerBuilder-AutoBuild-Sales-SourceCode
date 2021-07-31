$PBExportHeader$w_address.srw
forward
global type w_address from w_base
end type
type uo_1 from u_address within w_address
end type
end forward

global type w_address from w_base
integer width = 4151
integer height = 2872
string title = "Address"
boolean center = false
uo_1 uo_1
end type
global w_address w_address

type variables

end variables

on w_address.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_address.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;iuo_tab = uo_1
uo_1.tab_1.SelectedTab = 1
uo_1.of_winopen()
uo_1.tab_1.tabpage_1.dw_browser.SetFocus()


end event

event resize;call super::resize;
uo_1.Height = newheight
uo_1.Width = newwidth + 4
uo_1.tab_1.Height =  newheight - uo_1.tab_1.y - 64 
uo_1.tab_1.Width = newwidth  - uo_1.tab_1.x + 4
uo_1.tab_1.tabpage_1.dw_browser.Height = newheight - uo_1.tab_1.tabpage_1.dw_browser.y -  64  - 64 
uo_1.tab_1.tabpage_1.dw_browser.width = newwidth - uo_1.tab_1.tabpage_1.dw_browser.x  - 64 - 128


end event

type uo_1 from u_address within w_address
integer taborder = 50
end type

on uo_1.destroy
call u_address::destroy
end on

