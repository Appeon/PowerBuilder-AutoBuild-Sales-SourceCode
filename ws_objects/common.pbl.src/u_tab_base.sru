$PBExportHeader$u_tab_base.sru
forward
global type u_tab_base from userobject
end type
type tab_1 from tab within u_tab_base
end type
type tabpage_1 from userobject within tab_1
end type
type dw_browser from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_browser dw_browser
end type
type tabpage_2 from userobject within tab_1
end type
type dw_master from u_dw within tabpage_2
end type
type dw_detail from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_master dw_master
dw_detail dw_detail
end type
type tab_1 from tab within u_tab_base
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type u_tab_base from userobject
integer width = 3291
integer height = 2156
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type integer ue_add ( )
event type integer ue_delete ( )
event type integer ue_save ( )
event type integer ue_filter ( )
event type integer ue_modify ( )
event ue_first ( )
event ue_next ( )
event ue_prior ( )
event ue_last ( )
event type integer ue_export ( )
event type integer ue_import ( )
event type integer ue_cancel ( )
tab_1 tab_1
end type
global u_tab_base u_tab_base

type variables
u_dw iuo_currentdw
u_tab_base iuo_parent
Boolean ib_modify = False
Long il_last_row
 
end variables

forward prototypes
public function integer of_data_verify ()
public function integer of_winopen ()
public function integer of_retrieve (u_dw adw_data, string as_data)
public subroutine of_restore_data ()
public function integer of_exportjson (u_dw adw_browse)
public function integer of_importjson (u_dw adw_browse)
public subroutine of_restore_data_mutil (u_dw adw_cur)
public subroutine of_restore_data_current (u_dw adw_cur, long al_row)
end prototypes

event type integer ue_add();

Return 1
end event

event type integer ue_delete();Integer li_row
DwItemStatus ldws_status

li_row = iuo_currentdw.GetRow()

IF li_row < 1 Then Return 1
ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
IF ldws_status = New! Or ldws_status = NewModified! Then
	iuo_currentdw.DeleteRow(li_row)
	iuo_currentdw.ReSetUpdate()
	Return 1
End IF

Return 1
end event

event type integer ue_save();
Return 1
end event

event type integer ue_filter();
Return 1
end event

event type integer ue_modify();//Edit 
If iuo_currentdw.ClassName( ) = "dw_browser" Then
	tab_1.tabpage_1.dw_browser.TriggerEvent (DoubleClicked!)
End If

Return 1
end event

event ue_first();If iuo_currentdw.RowCount( ) > 0 Then
	If iuo_currentdw.GetRow() <> 1  Then
		iuo_currentdw.ScrollToRow (1)
		iuo_currentdw.SetRow(1)
	End If
End If

end event

event ue_next();Long ll_currow
Long ll_nextrow
If iuo_currentdw.RowCount( ) > 0 Then
	ll_currow = iuo_currentdw.GetRow()
	If ll_currow = iuo_currentdw.RowCount( ) Then
		ll_nextrow =  ll_currow
	Else
		ll_nextrow =  ll_currow + 1
	End If
	iuo_currentdw.ScrollToRow (ll_nextrow)
	iuo_currentdw.SetRow(ll_nextrow)
End If


end event

event ue_prior();Long ll_currow
Long ll_priorrow
If iuo_currentdw.RowCount( ) > 0 Then
	ll_currow = iuo_currentdw.GetRow()
	If ll_currow = 1 Then
		ll_priorrow =  1
	Else
		ll_priorrow =  ll_currow - 1
	End If
	iuo_currentdw.ScrollToRow (ll_priorrow)
	iuo_currentdw.SetRow(ll_priorrow)
End If

end event

event ue_last();If iuo_currentdw.RowCount( ) > 0 Then
	If iuo_currentdw.GetRow() <> iuo_currentdw.RowCount( )  Then
		iuo_currentdw.ScrollToRow ( iuo_currentdw.RowCount( ))
		iuo_currentdw.SetRow( iuo_currentdw.RowCount( ))
	End If
End If

end event

event type integer ue_export();Int li_ret
If IsValid(iuo_currentdw)  Then
	li_ret = iuo_currentdw.Event ue_exportjson()
End If

Return li_ret
end event

event type integer ue_import();Int li_ret
If IsValid(iuo_currentdw)  Then
	li_ret = iuo_currentdw.Event ue_importjson()
End If

Return li_ret
end event

event type integer ue_cancel();
of_restore_data()
Return 1
end event

public function integer of_data_verify ();return 1
end function

public function integer of_winopen ();return 1
end function

public function integer of_retrieve (u_dw adw_data, string as_data);return 1
end function

public subroutine of_restore_data ();
Long ll_row
DwItemStatus ldws_1

iuo_currentdw.AcceptText()

If Not ib_modify Then Return

ib_modify = False
w_main.ib_modify = False

IF iuo_currentdw.ClassName( ) = "dw_browser" THEN
	ll_row = il_last_row
ELSE
	ll_row = iuo_currentdw.GetRow( )
END IF

ldws_1 = iuo_currentdw.GetItemStatus(ll_row, 0, Primary!)
IF ldws_1 = New! Or ldws_1 =  NewModified! THEN
	iuo_currentdw.DeleteRow(ll_row)
ELSEIF ldws_1 = DataModified! THEN
	f_restore_data(iuo_currentdw, ll_row)
END IF

iuo_currentdw.ResetUpdate()

IF  iuo_currentdw.ClassName( ) <> "dw_master" THEN
	ldws_1 =  tab_1.tabpage_2.dw_master.GetItemStatus(tab_1.tabpage_2.dw_master.GetRow(), 0, Primary!) 
	IF ldws_1 = New! Or ldws_1 =  NewModified! THEN
		tab_1.tabpage_2.dw_master.DeleteRow(tab_1.tabpage_2.dw_master.GetRow())
		tab_1.tabpage_2.dw_master.ResetUpdate()
	ELSEIF ldws_1 = DataModified! THEN
		f_restore_data(tab_1.tabpage_2.dw_master, tab_1.tabpage_2.dw_master.GetRow())
		tab_1.tabpage_2.dw_master.ResetUpdate()
	END IF
END IF


end subroutine

public function integer of_exportjson (u_dw adw_browse);adw_browse.event ue_exportjson()

return 1
end function

public function integer of_importjson (u_dw adw_browse);adw_browse.event ue_importjson()
return 1
end function

public subroutine of_restore_data_mutil (u_dw adw_cur);Long i

adw_cur.AcceptText()

IF adw_cur.ModifiedCount() > 0 THEN	
	FOR i = adw_cur.RowCount() TO 1 STEP -1
		of_restore_data_current(adw_cur, i)
	NEXT
	adw_cur.ResetUpdate()
END IF
end subroutine

public subroutine of_restore_data_current (u_dw adw_cur, long al_row);DwItemStatus ldws_1

ldws_1 = adw_cur.GetItemStatus(al_row, 0, Primary!)
IF ldws_1 = New! Or ldws_1 =  NewModified! THEN
	adw_cur.DeleteRow(al_row)
	IF adw_cur.ClassName( ) = "dw_master" THEN
		IF tab_1.tabpage_1.dw_browser.GetRow() > 0 THEN
			tab_1.tabpage_1.dw_browser.Event RowFocusChanged( tab_1.tabpage_1.dw_browser.GetRow())
		END IF
	END IF
ELSEIF ldws_1 = DataModified! THEN
	f_restore_data(adw_cur, al_row)
END IF

	
end subroutine

on u_tab_base.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on u_tab_base.destroy
destroy(this.tab_1)
end on

event constructor;iuo_parent = This
end event

type tab_1 from tab within u_tab_base
integer x = 5
integer width = 3287
integer height = 2164
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 142
integer y = 16
integer width = 3127
integer height = 2132
long backcolor = 67108864
string text = "  Browse  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_browser dw_browser
end type

on tabpage_1.create
this.dw_browser=create dw_browser
this.Control[]={this.dw_browser}
end on

on tabpage_1.destroy
destroy(this.dw_browser)
end on

type dw_browser from u_dw within tabpage_1
event ue_save ( )
integer x = 9
integer y = 8
integer width = 3232
integer height = 2028
integer taborder = 10
boolean vscrollbar = true
end type

event ue_save();//
end event

event getfocus;call super::getfocus;iuo_currentdw = This

end event

event doubleclicked;call super::doubleclicked;tab_1.SelectTab(2)
end event

event losefocus;call super::losefocus;IF Not ib_modify THEN
	This.AcceptText( )
END IF
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type tabpage_2 from userobject within tab_1
integer x = 142
integer y = 16
integer width = 3127
integer height = 2132
long backcolor = 67108864
string text = "Detail"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_master dw_master
dw_detail dw_detail
end type

on tabpage_2.create
this.dw_master=create dw_master
this.dw_detail=create dw_detail
this.Control[]={this.dw_master,&
this.dw_detail}
end on

on tabpage_2.destroy
destroy(this.dw_master)
destroy(this.dw_detail)
end on

type dw_master from u_dw within tabpage_2
integer x = 9
integer y = 16
integer width = 3232
integer height = 1364
integer taborder = 30
end type

event getfocus;call super::getfocus;iuo_currentdw = This
end event

event losefocus;call super::losefocus;IF Not ib_modify THEN
	This.AcceptText( )
END IF
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type dw_detail from u_dw within tabpage_2
integer x = 9
integer y = 1464
integer width = 3232
integer height = 572
integer taborder = 40
end type

event getfocus;call super::getfocus;iuo_currentdw = this
end event

event losefocus;call super::losefocus;IF Not ib_modify THEN
	This.AcceptText( )
END IF
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

