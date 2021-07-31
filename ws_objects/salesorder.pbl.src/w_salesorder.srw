$PBExportHeader$w_salesorder.srw
forward
global type w_salesorder from w_base
end type
type uo_1 from u_salesorder within w_salesorder
end type
end forward

global type w_salesorder from w_base
integer width = 4165
integer height = 2824
string title = "Order"
uo_1 uo_1
end type
global w_salesorder w_salesorder

on w_salesorder.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_salesorder.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;iuo_tab = uo_1
uo_1.tab_1.SelectedTab = 1
uo_1.of_winopen()
uo_1.tab_1.tabpage_1.dw_browser.SetFocus()		

end event

event resize;call super::resize;uo_1.Height = newheight
uo_1.Width = newwidth + 4
uo_1.tab_1.Height =  newheight - uo_1.tab_1.y - 64 
uo_1.tab_1.Width = newwidth  - uo_1.tab_1.x + 4
//Browse
uo_1.tab_1.tabpage_1.dw_browser.Height = newheight - uo_1.tab_1.tabpage_1.dw_browser.y - 64 * 2
uo_1.tab_1.tabpage_1.dw_browser.width = newwidth - uo_1.tab_1.tabpage_1.dw_browser.x  - 64 - 128


//Detail
uo_1.tab_1.tabpage_2.dw_master.width = newwidth - uo_1.tab_1.tabpage_2.dw_master.x  - 64 - 128
uo_1.tab_1.tabpage_2.dw_detail.width = uo_1.tab_1.tabpage_2.dw_master.width
uo_1.tab_1.tabpage_2.dw_detail.Height = newheight - uo_1.tab_1.tabpage_2.dw_detail.y -  64 * 2

end event

type uo_1 from u_salesorder within w_salesorder
integer taborder = 40
end type

on uo_1.destroy
call u_salesorder::destroy
end on

