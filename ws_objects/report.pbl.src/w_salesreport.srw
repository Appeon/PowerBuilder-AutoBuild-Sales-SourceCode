$PBExportHeader$w_salesreport.srw
forward
global type w_salesreport from w_base
end type
type uo_1 from u_salesreport within w_salesreport
end type
end forward

global type w_salesreport from w_base
integer width = 4027
integer height = 2904
string title = "Statistics"
uo_1 uo_1
end type
global w_salesreport w_salesreport

on w_salesreport.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_salesreport.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;iuo_tab = uo_1
uo_1.tab_1.SelectedTab = 1
uo_1.of_winopen()
uo_1.tab_1.tabpage_1.dw_browser.SetFocus()		
end event

event resize;call super::resize;SetRedraw(False)
uo_1.Height = newheight
uo_1.Width = newwidth + 4
uo_1.tab_1.Height =  newheight - uo_1.tab_1.y - 64 
uo_1.tab_1.Width = newwidth  - uo_1.tab_1.x + 4
//Browse
uo_1.tab_1.tabpage_1.dw_browser.Height = newheight - uo_1.tab_1.tabpage_1.dw_browser.y - 64 * 2
uo_1.tab_1.tabpage_1.dw_browser.width = newwidth - uo_1.tab_1.tabpage_1.dw_browser.x  - 64 - 128


//Detail
uo_1.tab_1.tabpage_2.dw_master.width = newwidth - uo_1.tab_1.tabpage_2.dw_master.x  - 64 - 128
uo_1.tab_1.tabpage_2.dw_master.Height = newheight - uo_1.tab_1.tabpage_2.dw_master.y -  64 * 2


//Google Charts 
uo_1.tab_1.tabpage_4.wb_2.Height = newheight - uo_1.tab_1.tabpage_4.wb_2.y  -  64 * 2

//Google Charts 1
uo_1.tab_1.tabpage_5.wb_3.Height = newheight - uo_1.tab_1.tabpage_5.wb_3.y  -  64 * 2

//Google Charts 2
uo_1.tab_1.tabpage_6.wb_1.Height = newheight - uo_1.tab_1.tabpage_6.wb_1.y  -  64 * 2

SetRedraw(True)
end event

type uo_1 from u_salesreport within w_salesreport
integer taborder = 60
end type

on uo_1.destroy
call u_salesreport::destroy
end on

