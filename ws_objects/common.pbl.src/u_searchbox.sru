$PBExportHeader$u_searchbox.sru
forward
global type u_searchbox from userobject
end type
type sle_search from singlelineedit within u_searchbox
end type
type p_search from picture within u_searchbox
end type
type rr_border_rectangle from rectangle within u_searchbox
end type
type rr_border_roundrectangle from roundrectangle within u_searchbox
end type
type p_remove from picture within u_searchbox
end type
end forward

global type u_searchbox from userobject
integer width = 1408
integer height = 120
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_resize pbm_size
event ue_setstyle ( )
event ue_search ( )
event ue_resizeit ( )
event ue_setheight_sle ( )
event ue_removetext ( )
event ue_clicked_p_remove ( )
sle_search sle_search
p_search p_search
rr_border_rectangle rr_border_rectangle
rr_border_roundrectangle rr_border_roundrectangle
p_remove p_remove
end type
global u_searchbox u_searchbox

type variables
boolean ib_realtimesearch = false
boolean ib_show_p_searh  = true
integer ii_border
boolean ib_search_complete = false
string is_pic_search 
string is_pic_remove


end variables

forward prototypes
public function boolean of_fresh_px ()
public subroutine of_setcolor_outer (long al_color)
public subroutine of_setcolor_inner (long al_color)
public subroutine of_setcolor_border (long al_color)
public function string of_getsearchtext ()
public function integer of_setsearchtext (string as_text)
public function integer of_settextsize (integer ai_textszie)
public subroutine of_setrealtimesearch (boolean ab_enabled)
public subroutine of_setborder_sle (borderstyle abs_border)
public subroutine of_set_p_search (boolean ab_show)
public function integer of_setborder (integer ai_style)
public subroutine of_setcolor (long al_color_outer, long al_color_border, long al_color_inner)
public subroutine of_setcolor_sle_bg (long al_color)
public subroutine of_setcolor (long al_color_outer, long al_color_border)
public function integer of_settext (string as_text)
public subroutine of_setcolor_text (long al_color)
public function integer of_regpicture_search (string as_picture)
public function integer of_regpicture_remove (string as_picture)
public subroutine of_setplaceholder (string as_placeholder)
public subroutine of_clearplaceholder ()
public subroutine of_setcolor (long al_color_outer, long al_color_border, long al_color_inner, long al_color_bg)
end prototypes

event ue_resize;trigger event ue_resizeit()
end event

event ue_setstyle();long ll_color_outer, ll_color_border, ll_color_inner

if this.height < 132  then
	this.height  = 132
end if


this.of_setborder(2)
this.of_setborder_sle( stylebox!)
this.of_set_p_search(true)

of_setplaceholder("Type here to search")


String ls_themename
ls_themename = GetTheme()

IF ls_themename = "Flat Design Dark" THEN
//	of_setcolor_border(4210752)  //RGB(64,64,64)
//	of_setcolor_inner(3026478)  //RGB(46,46,46)
//	this.backcolor = 3026478
	
	of_setcolor(3026478, 4210752, 3026478, 3026478)
ELSE
//	of_setcolor_border(13421772)  //RGB(204,204,204)
//	of_setcolor_inner(16777215)  //RGB(255,255,255)
//	this.backcolor = 3026478
	of_setcolor(16777215, 13421772, 16777215, 16777215)
END IF


//ll_color_outer = rgb(255,0,0)
//ll_color_border  = rgb(255,0,255)
//ll_color_inner  = rgb(0,0,255)
//this.of_setcolor_inner(ll_color_inner)
//this.of_setcolor ( ll_color_outer, ll_color_border, ll_color_inner)
//
end event

event ue_resizeit();integer li_margin_left,  li_margin_right,  li_margin_top,  li_margin_bottom
integer li_margin_v, li_margin_h 

li_margin_left = 10
li_margin_right = li_margin_left
li_margin_top = 8
li_margin_bottom = li_margin_top

li_margin_v = li_margin_top
li_margin_h  = li_margin_left


rr_border_roundrectangle.resize( this.width -  ( li_margin_left + li_margin_right)  ,  p_remove.height +  li_margin_v *2 )
rr_border_roundrectangle.move(  li_margin_left, (this.height - rr_border_roundrectangle.height) / 2)

rr_border_rectangle.move( rr_border_roundrectangle.x, rr_border_roundrectangle.y)
rr_border_rectangle.resize( rr_border_roundrectangle.width,rr_border_roundrectangle.height)

p_remove.move( rr_border_roundrectangle.x + rr_border_roundrectangle.width - li_margin_h - p_remove.width , rr_border_roundrectangle.y  + li_margin_v )

if p_search.visible = true then
	p_search.move(rr_border_roundrectangle.x+  li_margin_h , p_remove.y  )
end if

event ue_setheight_sle()
if p_search.visible = true then 
	
		if rr_border_roundrectangle.visible = true then
			sle_search.move( p_search.x + p_search.width+ li_margin_h,  p_remove.y  + ( p_remove.height - sle_search.height )/2 )
		else
			sle_search.move( p_search.x + p_search.width+ li_margin_h,  p_remove.y  + ( p_remove.height - sle_search.height )/2  )
		end if
	
else
	
		if rr_border_roundrectangle.visible = true then
			sle_search.move( rr_border_roundrectangle.x+  li_margin_h * 2,  p_remove.y  + ( p_remove.height - sle_search.height )/2 )
		else
			sle_search.move( rr_border_roundrectangle.x+  li_margin_h * 2,  p_remove.y  + ( p_remove.height - sle_search.height )/2)
		end if
	
end if

if sle_search.y + sle_search.height >= rr_border_roundrectangle.y + rr_border_roundrectangle.height  then
	sle_search.height = sle_search.height - 4
end if
 
if p_remove.visible = true then
	sle_search.resize ( p_remove.x - sle_search.x - li_margin_h , sle_search.height)
else
	sle_search.resize ( p_remove.x  + p_remove.width - sle_search.x - li_margin_h , sle_search.height)	
end if
end event

event ue_setheight_sle();integer li_fontsize, li_offset, li_height

li_fontsize = sle_search.textsize
li_offset = (abs(li_fontsize) - 14 ) * 4
li_height = 90 + li_offset

if p_remove.height  <= li_height then
	li_height =  p_remove.height  -4
end if

sle_search.height = li_height

end event

event ue_removetext();sle_search.text = ""

if ib_search_complete = true then return
if ib_realtimesearch = false then return
this.trigger event ue_search()
ib_search_complete = true



end event

event ue_clicked_p_remove();event ue_removetext( )

end event

public function boolean of_fresh_px ();if sle_search.text = "" then	
	p_remove.visible = false	
else
	p_remove.visible = true	
end if

return p_remove.visible

end function

public subroutine of_setcolor_outer (long al_color);this.backcolor = al_color
end subroutine

public subroutine of_setcolor_inner (long al_color);rr_border_roundrectangle.fillcolor = al_color
rr_border_rectangle.fillcolor = al_color
sle_search.backcolor = al_color
end subroutine

public subroutine of_setcolor_border (long al_color);rr_border_roundrectangle.linecolor = al_color
rr_border_rectangle.linecolor = al_color
end subroutine

public function string of_getsearchtext ();return sle_search.text
end function

public function integer of_setsearchtext (string as_text); sle_search.text = as_text
 of_fresh_px()
 return 1
end function

public function integer of_settextsize (integer ai_textszie);integer li_re

li_re = 1
sle_search.textsize = ai_textszie

return li_re
end function

public subroutine of_setrealtimesearch (boolean ab_enabled);ib_realtimesearch = ab_enabled
end subroutine

public subroutine of_setborder_sle (borderstyle abs_border);sle_search.borderstyle = abs_border
end subroutine

public subroutine of_set_p_search (boolean ab_show);ib_show_p_searh= ab_show
p_search.visible = ib_show_p_searh
end subroutine

public function integer of_setborder (integer ai_style);choose case ai_style

case 0  //no border
	rr_border_roundrectangle.visible = false
	rr_border_rectangle.visible = false
case 1 // roundrectangle
	rr_border_roundrectangle.visible = true
	rr_border_rectangle.visible = false
case 2 // rectangle
	rr_border_roundrectangle.visible = false
	rr_border_rectangle.visible = true
case else
	ai_style = 0	
	rr_border_roundrectangle.visible = true
	rr_border_rectangle.visible = false
end choose

return ai_style


ii_border = ai_style


end function

public subroutine of_setcolor (long al_color_outer, long al_color_border, long al_color_inner);this.of_setcolor_outer(al_color_outer)
this.of_setcolor_border(al_color_border)
this.of_setcolor_inner(al_color_inner)


end subroutine

public subroutine of_setcolor_sle_bg (long al_color);sle_search.backcolor = al_color
end subroutine

public subroutine of_setcolor (long al_color_outer, long al_color_border);this.of_setcolor_outer(al_color_outer)
this.of_setcolor_border(al_color_outer)

end subroutine

public function integer of_settext (string as_text);sle_search.text = as_text
return len(sle_search.text)
end function

public subroutine of_setcolor_text (long al_color);sle_search.textcolor = al_color
end subroutine

public function integer of_regpicture_search (string as_picture);is_pic_search = as_picture
p_search.picturename = as_picture
return 1
end function

public function integer of_regpicture_remove (string as_picture);is_pic_remove =  as_picture
p_remove.picturename = as_picture

return 1
end function

public subroutine of_setplaceholder (string as_placeholder);sle_search.placeholder = as_placeholder

end subroutine

public subroutine of_clearplaceholder ();of_setplaceholder("")
end subroutine

public subroutine of_setcolor (long al_color_outer, long al_color_border, long al_color_inner, long al_color_bg);this.of_setcolor_outer(al_color_outer)
this.of_setcolor_border(al_color_border)
this.of_setcolor_inner(al_color_inner)
this.of_setcolor_sle_bg(al_color_bg)


end subroutine

on u_searchbox.create
this.sle_search=create sle_search
this.p_search=create p_search
this.rr_border_rectangle=create rr_border_rectangle
this.rr_border_roundrectangle=create rr_border_roundrectangle
this.p_remove=create p_remove
this.Control[]={this.sle_search,&
this.p_search,&
this.rr_border_rectangle,&
this.rr_border_roundrectangle,&
this.p_remove}
end on

on u_searchbox.destroy
destroy(this.sle_search)
destroy(this.p_search)
destroy(this.rr_border_rectangle)
destroy(this.rr_border_roundrectangle)
destroy(this.p_remove)
end on

event constructor;long ll_color

IF GetTheme() = "Flat Design Dark" THEN
	of_regpicture_search( ".\Image\sle_search_dark.png")
	of_regpicture_remove(".\Image\sle_close_dark.png")
ELSE
	of_regpicture_search( ".\Image\sle_search.png")
	of_regpicture_remove(".\Image\sle_close.png")
END IF


trigger event ue_setstyle()

trigger event ue_resizeit( )

of_fresh_px()

end event

type sle_search from singlelineedit within u_searchbox
event ue_change pbm_enchange
event ue_keydown pbm_keydown
integer x = 110
integer y = 16
integer width = 1134
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean border = false
end type

event ue_change;of_fresh_px()
ib_search_complete = false
if ib_realtimesearch  = true then
	parent.trigger event ue_search()
	ib_search_complete = true
end if

end event

event ue_keydown;if key=  KeyEnter! then
	if ib_search_complete = true then return
	parent.trigger event ue_search()
	ib_search_complete = true
end if
end event

type p_search from picture within u_searchbox
integer x = 9
integer y = 12
integer width = 114
integer height = 100
string picturename = ".\image\sle_search.png"
boolean focusrectangle = false
end type

type rr_border_rectangle from rectangle within u_searchbox
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 5
integer y = 4
integer width = 1371
integer height = 112
end type

type rr_border_roundrectangle from roundrectangle within u_searchbox
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 5
integer y = 4
integer width = 1371
integer height = 112
integer cornerheight = 40
integer cornerwidth = 46
end type

type p_remove from picture within u_searchbox
integer x = 1179
integer y = 12
integer width = 187
integer height = 100
boolean bringtotop = true
string picturename = ".\image\sle_close.png"
boolean focusrectangle = false
end type

event clicked;parent.event ue_clicked_p_remove( )
end event

