$PBExportHeader$u_address.sru
forward
global type u_address from u_tab_base
end type
type dw_filter from u_dw within tabpage_1
end type
type cb_retrieve from u_button within tabpage_1
end type
type cbx_1 from checkbox within tabpage_1
end type
type uo_search from u_searchbox within tabpage_1
end type
type cb_add from u_button within u_address
end type
type cb_delete from u_button within u_address
end type
type cb_save from u_button within u_address
end type
type cb_import from u_button within u_address
end type
end forward

global type u_address from u_tab_base
integer width = 4110
integer height = 2708
long backcolor = 16777215
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_import cb_import
end type
global u_address u_address

type variables
string is_controller
end variables

forward prototypes
public function integer of_winopen ()
public function integer of_data_verify ()
end prototypes

public function integer of_winopen ();//====================================================================
//$<Function>: of_winopen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
DataWindowChild ldwc_child

IF tab_1.tabpage_1.dw_filter.RowCount() < 1 Then
	tab_1.tabpage_1.dw_filter.InsertRow(1)	
End IF

tab_1.tabpage_1.dw_filter.GetChild("stateprovinceid", ldwc_child)
IF ldwc_child.RowCount() > 0 Then
	IF tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
		tab_1.tabpage_1.dw_browser.ScrollToRow(1)
	End IF
	ib_modify = False
	Return 1
Else
	ldwc_child.SetTransObject(Sqlca)
	ldwc_child.Retrieve( )
End IF

This.SetRedraw(False)
//Retrieve Dddw
//inv_webapi.of_winopen(tab_1.tabpage_1.dw_filter, tab_1.tabpage_1.dw_browser,  tab_1.tabpage_2.dw_master)


IF ldwc_child.RowCount() > 0 Then
	IF ldwc_child.Find("stateprovinceid=1", 1,  ldwc_child.RowCount()) > 0 THEN
		tab_1.tabpage_1.dw_filter.SetItem(1, "stateprovinceid", 1)
	END IF
END IF

tab_1.tabpage_1.cb_retrieve.Post Event Clicked()

This.Post SetRedraw(True)

Return 1
end function

public function integer of_data_verify ();Long ll_row
Long ll_count
Long ll_stateprovinceid
Integer li_return
String   ls_addressline1
String   ls_postalcode
String   ls_city

li_return = tab_1.tabpage_2.dw_master.AcceptText()

ll_row = tab_1.tabpage_2.dw_master.GetRow()

ls_addressline1 =  tab_1.tabpage_2.dw_master.GetItemString(ll_row, "addressline1")
IF isnull(ls_addressline1) OR trim(ls_addressline1) = "" Then
	messagebox(gs_msg_title, "Address Line 1 is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("addressline1")
	Return -1
End IF

ll_stateprovinceid =  tab_1.tabpage_2.dw_master.GetItemNumber(ll_row, "stateprovinceid")
IF isnull(ll_stateprovinceid) Then
	messagebox(gs_msg_title, "State/Province is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("stateprovinceid")
	Return -1
End IF

ls_city =   tab_1.tabpage_2.dw_master.GetItemString(ll_row, "city")
IF isnull(ls_city) or trim(ls_city) = "" Then
	messagebox(gs_msg_title, "City is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("city")
	Return -1
End IF	


ls_postalcode =   tab_1.tabpage_2.dw_master.GetItemString(ll_row, "postalcode")
IF isnull(ls_postalcode) or trim(ls_postalcode) = "" Then
	messagebox('Error', "Postal Code is required.")
	tab_1.selecttab(2)
	 tab_1.tabpage_2.dw_master.setfocus()
	 tab_1.tabpage_2.dw_master.scrolltorow( ll_row)
	 tab_1.tabpage_2.dw_master.setcolumn("postalcode")
	Return -1
End IF


Return 1
end function

on u_address.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_import
end on

on u_address.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_import)
end on

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_addressid

DwitemStatus ldws_status

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return	1	

li_ret = MessageBox("Delete Address", "Are you sure you want to delete this address?" , Question!, yesno!)
IF li_ret = 1 Then	
	ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
	IF ldws_status = New! Or ldws_status = NewModified! Then
		ib_Modify = False
		w_main.ib_modify = False
		iuo_currentdw.DeleteRow(li_row)
		iuo_currentdw.ReSetUpdate()
		Return 1
	End IF

	//Delete from database
	ll_addressid = iuo_currentdw.GetItemNumber(li_row, "addressid")	
	
	iuo_currentdw.DeleteRow(li_row)
	IF iuo_currentdw.Update( ) = 1 THEN
		Commit;
		iuo_currentdw.selectrow(iuo_currentdw.getrow(),true)
	Else
		MessageBox("Delete failed", "Error:" + Sqlca.SqlErrText)
		RollBack;
		Return -1
	END IF
	
	IF iuo_currentdw.ClassName() = "dw_master" Then
		li_row = tab_1.tabpage_1.dw_browser.GetRow()
		tab_1.tabpage_1.dw_browser.DeleteRow(li_row)
		tab_1.tabpage_1.dw_browser.ReSetUpdate()
		
		IF tab_1.tabpage_1.dw_browser.RowCount() > 1 Then
			tab_1.tabpage_1.dw_browser.ScrollToRow(tab_1.tabpage_1.dw_browser.RowCount())
		End IF
	End IF	
End IF

ib_Modify = False
w_main.ib_modify = False

Return 1
end event

event ue_save;call super::ue_save;Integer li_row
Integer li_listrow
Integer li_status
long     ll_rowcount
Long ll_pkid
DwItemStatus ldws_sign

iuo_currentdw.AcceptText()
IF iuo_currentdw.Modifiedcount() < 1 Then Return 1

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1
IF of_data_verify() = -1 Then Return -1

ldws_sign = iuo_currentdw.GetItemStatus(li_row, 0, Primary!)
li_listrow = tab_1.tabpage_1.dw_browser.Getrow()

IF iuo_currentdw.update( ) = 1 THEN
	Commit;
Else
	RollBack;
	Return -1
END IF

IF ldws_sign = Newmodified! Then
	SELECT Max(Isnull(addressid,0)) INTO :ll_pkid FROM  Person.Address;
	iuo_currentdw.SetItem(li_row, "addressid", ll_pkid)
	li_listrow = tab_1.tabpage_1.dw_browser.rowcount() + 1 
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow, primary!)	
	tab_1.tabpage_1.dw_browser.ResetUpdate()
ElseIF ldws_sign = DataModified! Then	
	tab_1.tabpage_2.dw_master.Rowscopy(li_row, li_row, primary!, tab_1.tabpage_1.dw_browser, li_listrow + 1, primary!)	
	tab_1.tabpage_1.dw_browser.Deleterow(li_listrow)	
End IF

MessageBox(gs_msg_title, "Saved the data successfully.")
ib_modify = False
w_main.ib_modify = False

tab_1.tabpage_1.dw_browser.ScrollToRow(li_listrow)
tab_1.tabpage_1.dw_browser.SelectRow (0, False)
tab_1.tabpage_1.dw_browser.SelectRow (li_listrow, True)
	
Return 1
end event

event ue_filter;call super::ue_filter;String ls_city
Long ll_stateprovinceid

tab_1.tabpage_1.dw_filter.AcceptText()

ll_stateprovinceid = tab_1.tabpage_1.dw_filter.GetItemNumber(1, "stateprovinceid")
//ls_city = tab_1.tabpage_1.dw_filter.GetItemString(1, "city")
ls_city =  tab_1.tabpage_1.uo_search.of_getsearchtext() 

IF Isnull(ll_stateprovinceid) Then ll_stateprovinceid = 0
IF Isnull(ls_city) Or ls_city = "" Then 
	ls_city = ""
End IF
ls_city = "%" + ls_city + "%"
 tab_1.tabpage_1.dw_browser.Retrieve(ll_stateprovinceid, ls_city)
 
 tab_1.tabpage_1.dw_browser.setfocus()
 if tab_1.tabpage_1.dw_browser.rowcount() > 0 then
	tab_1.tabpage_1.dw_browser.selectrow(1,true)
end if

Return 1

end event

event ue_add;call super::ue_add;Integer li_row
DwItemStatus ldws_sign

IF ib_Modify = True Then
	MessageBox(gs_msg_title, "Please save the data first.")
	
	Return 1
End IF

IF tab_1.SelectedTab <> 2 Then tab_1.SelectedTab = 2

iuo_currentdw = tab_1.tabpage_2.dw_master
li_row = iuo_currentdw.InsertRow(0)
iuo_currentdw.ScrollToRow(li_row)

ldws_sign = iuo_currentdw.getitemstatus(li_row,0,primary!)
if ldws_sign = new! or ldws_sign = notmodified! then return 1
ib_Modify = True
w_main.ib_modify = True 

Return 1
end event

type tab_1 from u_tab_base`tab_1 within u_address
integer x = 0
integer width = 4119
integer height = 2708
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
call super::destroy
end on

event tab_1::selectionchanging;call super::selectionchanging;IF ib_Modify = True Then
	MessageBox(gs_msg_title, "Please save the data first.")
	Return 1
End IF

IF oldindex = 2 THEN
	tab_1.tabpage_2.dw_master.Accepttext( )
	IF  tab_1.tabpage_2.dw_master.ModifiedCount ( ) > 0 Then
		MessageBox(gs_msg_title, "Please save the data first.")
		Return 1
	END IF
END IF
end event

event tab_1::selectionchanged;call super::selectionchanged;IF newindex = 2 THEN
	cb_import.Visible = True
	cb_add.Visible = False
	cb_delete.Visible = False
	cb_save.Visible = False
ELSE
	cb_import.Visible = False
	cb_add.Visible = True
	cb_delete.Visible = True
	cb_save.Visible = True
END IF

IF newindex = 1 THEN
	IF oldindex = 2 THEN tab_1.tabpage_1.dw_browser.SetFocus()
ELSE
	IF oldindex = 1 THEN tab_1.tabpage_2.dw_master.SetFocus()
END IF
end event

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3959
integer height = 2676
dw_filter dw_filter
cb_retrieve cb_retrieve
cbx_1 cbx_1
uo_search uo_search
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.cb_retrieve=create cb_retrieve
this.cbx_1=create cbx_1
this.uo_search=create uo_search
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_retrieve
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.uo_search
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_retrieve)
destroy(this.cbx_1)
destroy(this.uo_search)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 236
integer width = 3840
integer height = 2380
string dataobject = "d_address"
boolean hscrollbar = true
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Function>: of_winopen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long  ll_addressid
Integer li_ret

IF currentrow < 1 Then Return -1

tab_1.tabpage_2.dw_master.AcceptText()
IF ib_Modify = True Then
	li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
	IF li_ret = 1 Then
		tab_1.SelectedTab = 2
		Return 1
	ELSE
		of_restore_data()
	End IF
End IF

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

ll_addressid = This.GetItemNumber(currentrow, "addressid")

tab_1.tabpage_2.dw_master.Retrieve(ll_addressid)

ib_modify = False
w_main.ib_modify = False

il_last_row = currentrow


end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3959
integer height = 2676
end type

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 68
integer width = 3831
integer height = 648
string dataobject = "d_address_free"
boolean border = false
end type

event dw_master::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True



end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
boolean visible = false
end type

type dw_filter from u_dw within tabpage_1
integer x = 64
integer y = 60
integer width = 1842
integer height = 124
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_address_filter"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;IF dwo.name = "stateprovinceid" Then
	iuo_parent.Event ue_filter()
End IF
end event

type cb_retrieve from u_button within tabpage_1
boolean visible = false
integer x = 1952
integer y = 68
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;call super::clicked;long ll_time

ll_time = cpu()

iuo_parent.Event ue_filter()

//messagebox("", cpu() - ll_time)


end event

type cbx_1 from checkbox within tabpage_1
boolean visible = false
integer x = 2382
integer y = 72
integer width = 457
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use Compress"
end type

type uo_search from u_searchbox within tabpage_1
integer x = 1161
integer y = 56
integer taborder = 70
boolean bringtotop = true
end type

on uo_search.destroy
call u_searchbox::destroy
end on

event constructor;call super::constructor;of_setplaceholder("Filter by City")
of_setrealtimesearch(False)
end event

event ue_search;call super::ue_search;iuo_parent.Event ue_filter()

end event

type cb_add from u_button within u_address
integer x = 2784
integer y = 76
integer width = 366
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;call super::clicked;Parent.Event ue_add()
end event

type cb_delete from u_button within u_address
integer x = 3168
integer y = 76
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;Parent.Event ue_delete()
end event

type cb_save from u_button within u_address
integer x = 3547
integer y = 76
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;Parent.Event ue_save()
end event

type cb_import from u_button within u_address
boolean visible = false
integer x = 247
integer y = 764
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Import"
end type

event clicked;call super::clicked;Int li_row
DwItemStatus ldws_sign
li_row = tab_1.tabpage_2.dw_master.GetRow()

IF ib_Modify = True Then
	MessageBox(gs_msg_title, "Please save the data first.")
	Return 1
End IF

ldws_sign = tab_1.tabpage_2.dw_master.GetItemStatus(li_row, 0, Primary!)
IF Not (ldws_sign = New! Or ldws_sign = Newmodified! ) Then
	cb_add.Event Clicked()
End IF
Parent.Event  ue_import()

li_row = tab_1.tabpage_2.dw_master.GetRow()
tab_1.tabpage_2.dw_master.SetItem(li_row, "addressid", 0)
iuo_currentdw = tab_1.tabpage_2.dw_master

ib_modify = True
w_main.ib_modify = True
end event

