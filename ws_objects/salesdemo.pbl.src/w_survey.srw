$PBExportHeader$w_survey.srw
forward
global type w_survey from window
end type
type uo_1 from u_survey within w_survey
end type
end forward

global type w_survey from window
integer width = 4434
integer height = 3408
boolean titlebar = true
string title = "Survey"
boolean controlmenu = true
windowtype windowtype = response!
string icon = ".\image\survey.ico"
event ue_postevent ( )
uo_1 uo_1
end type
global w_survey w_survey

forward prototypes
public function integer f_center ()
end prototypes

event ue_postevent();string ls_firstname, ls_lastname
long ll_row
if isvalid(w_person) then
	ll_row = w_person.uo_1.tab_1.tabpage_1.dw_browser.getrow()
	if isnull(ll_row) or ll_row = 0 then ll_row = 1
	ls_firstname = w_person.uo_1.tab_1.tabpage_1.dw_browser.getitemstring(ll_row,'firstname')
	ls_lastname = w_person.uo_1.tab_1.tabpage_1.dw_browser.getitemstring(ll_row,'lastname')
	uo_1.of_survey(ls_firstname +' '+ls_lastname)
	
end if

end event

public function integer f_center ();//*-----------------------------------------------------------------*/
//*    f_Center:  Center the window
//*-----------------------------------------------------------------*/
int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

/*  Check for a window association with this object  */
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

/*  Get environment  */
If GetEnvironment ( lenv_obj ) = -1 Then Return -1

/*  Determine current screen resolution and validate  */
li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

/*  Get center points  */
If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth / 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( li_screenheight / 2 ) - ( this.Height / 2 )
End If

int nScreenX, nScreenY
nScreenX = PixelsToUnits ( lenv_obj.screenx, XPixelsToUnits! )
nScreenY = PixelsToUnits ( lenv_obj. screeny, YPixelsToUnits! )
li_x = nScreenX + li_x
li_y = nScreenY + li_y

/*  Center window  */
li_rc = this.Move ( li_x, li_y )
If li_rc <> 1 Then Return -1


Return 1
end function

on w_survey.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_survey.destroy
destroy(this.uo_1)
end on

event open;
//move(1700,600)
//this.post event ue_postevent()

string ls_firstname, ls_lastname
long ll_row
if isvalid(w_person) then
	//Hide window
	This.hide( )
	//set position
	f_center()
	
	ll_row = w_person.uo_1.tab_1.tabpage_1.dw_browser.getrow()
	if isnull(ll_row) or ll_row = 0 then ll_row = 1
	ls_firstname = w_person.uo_1.tab_1.tabpage_1.dw_browser.getitemstring(ll_row,'firstname')
	ls_lastname = w_person.uo_1.tab_1.tabpage_1.dw_browser.getitemstring(ll_row,'lastname')
	uo_1.of_survey(ls_firstname +' '+ls_lastname)
	uo_1.is_company=ls_firstname +' '+ls_lastname
	uo_1.wf_createpdf(ls_firstname +' '+ls_lastname)
	
	//Show window
	this.show( )
end if

end event

type uo_1 from u_survey within w_survey
integer taborder = 20
end type

on uo_1.destroy
call u_survey::destroy
end on

