$PBExportHeader$w_base.srw
forward
global type w_base from window
end type
end forward

global type w_base from window
integer width = 4110
integer height = 2708
boolean border = false
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type integer ue_add ( )
event type integer ue_delete ( )
event type integer ue_filter ( )
event type integer ue_save ( )
event type integer ue_modify ( )
event ue_first ( )
event ue_last ( )
event ue_next ( )
event ue_prior ( )
event type integer ue_export ( )
event type integer ue_import ( )
event type integer ue_cancel ( )
end type
global w_base w_base

type variables
u_tab_base iuo_tab
end variables

event type integer ue_add();iuo_tab.Dynamic Event ue_add()

Return 1
end event

event type integer ue_delete();iuo_tab.Dynamic Event ue_delete()
Return 1
end event

event type integer ue_filter();iuo_tab.Dynamic Event ue_filter()
Return 1
end event

event type integer ue_save();Int li_ret
li_ret = iuo_tab.Dynamic Event ue_save()
Return li_ret
end event

event type integer ue_modify();iuo_tab.Dynamic Event ue_modify()
Return 1
end event

event ue_first();iuo_tab.Dynamic Event ue_first()
end event

event ue_last();iuo_tab.Dynamic Event ue_last()
end event

event ue_next();iuo_tab.Dynamic Event ue_next()
end event

event ue_prior();iuo_tab.Dynamic Event ue_prior()
end event

event type integer ue_export();Int li_ret
li_ret = iuo_tab.Dynamic Event ue_export()
Return li_ret
end event

event type integer ue_import();Int li_ret
li_ret = iuo_tab.Dynamic Event ue_import()
Return li_ret
end event

event type integer ue_cancel();Int li_ret
li_ret = iuo_tab.Dynamic Event ue_cancel()
Return li_ret
end event

on w_base.create
end on

on w_base.destroy
end on

event activate;IF This.windowstate <> Maximized! THEN
	This.windowstate = Maximized!
END IF
end event

event closequery;//Int li_ret
//IF IsValid(iuo_tab) Then
//	IF iuo_tab.ib_modify Then
//		li_ret = MessageBox("Save Change", "You have not saved your changes yet.  Do you want to save the changes?" , Question!, YesNo!, 1)
//		IF li_ret = 1 Then
//			IF This.Event ue_save() <> 1 THEN Return 0
//		End IF
//	End IF
//End IF
end event

event open;//ParentWindow().Post Arrangesheets(Layer!)
end event

