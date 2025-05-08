$PBExportHeader$w_sendemail.srw
forward
global type w_sendemail from window
end type
type uo_1 from u_email within w_sendemail
end type
end forward

global type w_sendemail from window
integer width = 3991
integer height = 2448
boolean titlebar = true
string title = "Send Email"
boolean controlmenu = true
windowtype windowtype = response!
string icon = ".\image\email.ico"
uo_1 uo_1
end type
global w_sendemail w_sendemail

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

on w_sendemail.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_sendemail.destroy
destroy(this.uo_1)
end on

event open;//move(2000,700)
f_Center ( )

string ls_response
ls_response = message.stringparm
if ls_response = 'Survey' then
	uo_1.sle_Attachments.text = ".\pdf\survey.pdf"
end if
end event

type uo_1 from u_email within w_sendemail
integer x = 55
integer y = 20
integer taborder = 80
end type

on uo_1.destroy
call u_email::destroy
end on

