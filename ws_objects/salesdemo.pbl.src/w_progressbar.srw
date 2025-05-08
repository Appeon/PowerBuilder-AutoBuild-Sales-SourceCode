$PBExportHeader$w_progressbar.srw
forward
global type w_progressbar from w_base
end type
type st_1 from statictext within w_progressbar
end type
type hpb_1 from hprogressbar within w_progressbar
end type
end forward

global type w_progressbar from w_base
integer width = 1664
integer height = 472
string title = "Process"
boolean border = true
windowstate windowstate = normal!
st_1 st_1
hpb_1 hpb_1
end type
global w_progressbar w_progressbar

forward prototypes
public function integer f_center ()
end prototypes

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

on w_progressbar.create
int iCurrent
call super::create
this.st_1=create st_1
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.hpb_1
end on

on w_progressbar.destroy
call super::destroy
destroy(this.st_1)
destroy(this.hpb_1)
end on

event timer;call super::timer;IF hpb_1.position < 80 Then
	hpb_1.position = hpb_1.position + 5
End IF

Return 1
end event

event open;String		ls_msg

f_Center ( )
ls_msg = message.stringparm

If len(ls_msg) > 0 Then 
	st_1.text = ls_msg
End If


timer(1)
end event

event activate;//
end event

type st_1 from statictext within w_progressbar
integer x = 82
integer y = 72
integer width = 1271
integer height = 92
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Retrieving data. Please wait..."
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_progressbar
integer x = 73
integer y = 212
integer width = 1490
integer height = 76
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 1
boolean smoothscroll = true
end type

