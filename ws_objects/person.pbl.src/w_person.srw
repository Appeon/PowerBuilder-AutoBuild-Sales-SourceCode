$PBExportHeader$w_person.srw
forward
global type w_person from w_base
end type
type uo_1 from u_person within w_person
end type
end forward

global type w_person from w_base
integer width = 4165
integer height = 2824
string title = "Customer"
boolean center = false
uo_1 uo_1
end type
global w_person w_person

type variables
Int ii_tab_h
Int ii_browser_h
Int ii_detail_h
end variables

on w_person.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_person.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;iuo_tab = uo_1
uo_1.tab_1.SelectedTab = 1
uo_1.of_winopen()
uo_1.tab_1.tabpage_1.dw_browser.SetFocus()

end event

event resize;call super::resize;//Int li_height_gap
//uo_1.tab_1.Height =  newheight - (ii_win_h - ii_tab_h)
//uo_1.tab_1.tabpage_1.dw_browser.Height = newheight -  (ii_win_h - ii_browser_h)
//uo_1.tab_1.tabpage_1.st_1.y = uo_1.tab_1.tabpage_1.dw_browser.y + uo_1.tab_1.tabpage_1.dw_browser.Height + 64
//uo_1.tab_1.tabpage_1.dw_persondetail.y = uo_1.tab_1.tabpage_1.st_1.y + uo_1.tab_1.tabpage_1.st_1.Height + 32
//
//
//li_height_gap =( w_main.rbb_main.Height + 4 - 92) / 2  //92 is tab height 
//
//If gb_expand Then
//	uo_1.tab_1.tabpage_2.dw_master.Height =  ii_detail_h - li_height_gap	
//Else
//	uo_1.tab_1.tabpage_2.dw_master.Height =  ii_detail_h
//End If
//uo_1.tab_1.tabpage_2.dw_detail.Height = uo_1.tab_1.tabpage_2.dw_master.Height 
//uo_1.tab_1.tabpage_2.st_3.y = uo_1.tab_1.tabpage_2.dw_master.y + uo_1.tab_1.tabpage_2.dw_master.Height + 64
//uo_1.tab_1.tabpage_2.dw_detail.y = uo_1.tab_1.tabpage_2.st_3.y + uo_1.tab_1.tabpage_2.st_3.Height + 32
//uo_1.tab_1.tabpage_2.st_2.y = uo_1.tab_1.tabpage_2.dw_detail.y + uo_1.tab_1.tabpage_2.dw_detail.Height + 64
//uo_1.tab_1.tabpage_2.dw_cust.y = uo_1.tab_1.tabpage_2.st_2.y + uo_1.tab_1.tabpage_2.st_2.Height + 32


uo_1.Height = newheight
uo_1.Width = newwidth + 4
uo_1.tab_1.Height =  newheight - uo_1.tab_1.y - 64 
uo_1.tab_1.Width = newwidth  - uo_1.tab_1.x + 4
//Browse
uo_1.tab_1.tabpage_1.dw_browser.Height = newheight - uo_1.tab_1.tabpage_1.dw_browser.y - uo_1.tab_1.tabpage_1.st_1.Height  &
														- uo_1.tab_1.tabpage_1.dw_persondetail.Height -  64 * 3  - 48
uo_1.tab_1.tabpage_1.dw_browser.width = newwidth - uo_1.tab_1.tabpage_1.dw_browser.x  - 64 - 128
uo_1.tab_1.tabpage_1.st_1.y =  uo_1.tab_1.tabpage_1.dw_browser.y + uo_1.tab_1.tabpage_1.dw_browser.Height + 64
uo_1.tab_1.tabpage_1.dw_persondetail.y = uo_1.tab_1.tabpage_1.st_1.y + uo_1.tab_1.tabpage_1.st_1.Height + 48
uo_1.tab_1.tabpage_1.dw_persondetail.width = uo_1.tab_1.tabpage_1.dw_browser.width
uo_1.tab_1.tabpage_1.uo_search.x = uo_1.tab_1.tabpage_1.dw_browser.x + uo_1.tab_1.tabpage_1.dw_browser.width - uo_1.tab_1.tabpage_1.uo_search.width


//Detail
uo_1.tab_1.tabpage_2.dw_master.Height = (newheight - uo_1.tab_1.tabpage_2.dw_master.y - uo_1.tab_1.tabpage_2.st_3.Height  &
														- uo_1.tab_1.tabpage_2.st_2.Height - uo_1.tab_1.tabpage_2.dw_cust.Height  -  64 * 4  - 48 *2 ) / 2 
uo_1.tab_1.tabpage_2.dw_detail.Height = uo_1.tab_1.tabpage_2.dw_master.Height
uo_1.tab_1.tabpage_2.st_3.y = uo_1.tab_1.tabpage_2.dw_master.y + uo_1.tab_1.tabpage_2.dw_master.Height + 64
uo_1.tab_1.tabpage_2.dw_detail.y =  uo_1.tab_1.tabpage_2.st_3.y + uo_1.tab_1.tabpage_2.st_3.Height + 48
uo_1.tab_1.tabpage_2.st_2.y = uo_1.tab_1.tabpage_2.dw_detail.y + uo_1.tab_1.tabpage_2.dw_detail.Height + 64
uo_1.tab_1.tabpage_2.dw_cust.y =  uo_1.tab_1.tabpage_2.st_2.y + uo_1.tab_1.tabpage_2.st_2.Height + 48
uo_1.tab_1.tabpage_2.dw_master.width = newwidth - uo_1.tab_1.tabpage_2.dw_master.x  - 64 - 128
uo_1.tab_1.tabpage_2.dw_detail.width = uo_1.tab_1.tabpage_2.dw_master.width 
uo_1.tab_1.tabpage_2.dw_cust.width = uo_1.tab_1.tabpage_2.dw_master.width 




end event

type uo_1 from u_person within w_person
integer taborder = 40
end type

on uo_1.destroy
call u_person::destroy
end on

