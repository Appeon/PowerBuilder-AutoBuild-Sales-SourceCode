$PBExportHeader$u_graphcontrol.sru
forward
global type u_graphcontrol from userobject
end type
type lb_value from listbox within u_graphcontrol
end type
type lb_category from listbox within u_graphcontrol
end type
type dw_1 from datawindow within u_graphcontrol
end type
type ddlb_graphtype from dropdownlistbox within u_graphcontrol
end type
type st_1 from statictext within u_graphcontrol
end type
type gr_1 from graph within u_graphcontrol
end type
type gb_1 from groupbox within u_graphcontrol
end type
type gb_2 from groupbox within u_graphcontrol
end type
end forward

global type u_graphcontrol from userobject
integer width = 4347
integer height = 3012
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
lb_value lb_value
lb_category lb_category
dw_1 dw_1
ddlb_graphtype ddlb_graphtype
st_1 st_1
gr_1 gr_1
gb_1 gb_1
gb_2 gb_2
end type
global u_graphcontrol u_graphcontrol

forward prototypes
public subroutine uf_set_a_series (string as_title, string as_value, string as_category)
public function string uf_get_token (ref string source, string separator)
end prototypes

public subroutine uf_set_a_series (string as_title, string as_value, string as_category);long ll_row, ll_index
int 	 li_series_num

li_series_num = gr_1.addseries (as_title )
if li_series_num < 1 Then Return
ll_row = RowCount (dw_1)
For ll_index = 1 to ll_row
	gr_1.adddata (li_series_num, dw_1.GetItemNumber (ll_index , as_value), &
					dw_1.GetItemString (ll_index, as_category))
Next



end subroutine

public function string uf_get_token (ref string source, string separator);// String Function GET_TOKEN (ref string Source, string Separator)

// The function Get_Token receive, as arguments, the string from which
// the token is to be stripped off, from the left, and the separator
// character.  If the separator character does not appear in the string,
// it returns the entire string.  Otherwise, it returns the token, not
// including the separator character.  In either case, the source string
// is truncated on the left, by the length of the token and separator
// character, if any.


int 		p
string 	ret

p = Pos(source, separator)	// Get the position of the separator

if p = 0 then					// if no separator, 
	ret = source				// return the whole source string and
	source = ""					// make the original source of zero length
else
	ret = Mid(source, 1, p - 1)	// otherwise, return just the token and
	source = Right(source, Len(source) - p)	// strip it & the separator
end if

return ret
end function

on u_graphcontrol.create
this.lb_value=create lb_value
this.lb_category=create lb_category
this.dw_1=create dw_1
this.ddlb_graphtype=create ddlb_graphtype
this.st_1=create st_1
this.gr_1=create gr_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.lb_value,&
this.lb_category,&
this.dw_1,&
this.ddlb_graphtype,&
this.st_1,&
this.gr_1,&
this.gb_1,&
this.gb_2}
end on

on u_graphcontrol.destroy
destroy(this.lb_value)
destroy(this.lb_category)
destroy(this.dw_1)
destroy(this.ddlb_graphtype)
destroy(this.st_1)
destroy(this.gr_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;string	 ls_names, ls_names_list
string	 ls_object_name, ls_datatype

//Populate datawindow
dw_1.SetTransObject (sqlca)
dw_1.Retrieve ()

// Get list and number of columns from the datawindow
ls_names_list = dw_1.Object.DataWindow.objects

// Get each object from the list and add it to the objects listbox
//The character fields are added to the category list box and the
//number fields are added to the value listbox
ls_names = ls_names_list

do 
	ls_object_name = uf_get_token (ls_names, "~t")
	if dw_1.Describe(ls_object_name + ".type") = "column" then
		ls_datatype = dw_1.Describe(ls_object_name + ".coltype")
		if left(ls_datatype, 4) = "char"  then
			lb_category.AddItem (ls_object_name)
		elseif ls_datatype = "number" or left(ls_datatype,7) = "decimal" then
			lb_value.AddItem (ls_object_name)
		end if

	end if
loop until ls_names = ""

//select initial values (defaults is first selections)
lb_value.SetState (1, True)


lb_value.TriggerEvent (selectionchanged!)

//f_get_toolbar_profile(This, 1)





end event

type lb_value from listbox within u_graphcontrol
integer x = 1042
integer y = 88
integer width = 850
integer height = 512
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
boolean multiselect = true
end type

event selectionchanged;int itemcount,i,r
string ls_colname

gr_1.SetRedraw (False)

// Clear out all categories, series and data from the graph
gr_1.reset ( all! )

// Loop through all selected values and create as many series as the
// user specified.
for i = 1 to lb_value.totalitems ( )
	If lb_value.state ( i ) = 1 then
		ls_colname = lb_value.text ( i )
		uf_set_a_series (ls_colname, ls_colname, lb_category.text(1))
	end if
next

gr_1.SetRedraw (True)



end event

type lb_category from listbox within u_graphcontrol
integer x = 87
integer y = 88
integer width = 805
integer height = 496
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = false
end type

event selectionchanged;TriggerEvent (lb_value, selectionchanged!)
end event

type dw_1 from datawindow within u_graphcontrol
integer x = 32
integer y = 660
integer width = 3954
integer height = 576
integer taborder = 10
string title = "none"
string dataobject = "d_dept_data_for_graph"
boolean border = false
boolean livescroll = true
end type

type ddlb_graphtype from dropdownlistbox within u_graphcontrol
integer x = 2350
integer y = 32
integer width = 919
integer height = 812
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 1090519039
boolean autohscroll = true
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
string item[] = {"AreaGraph!","BarGraph!","BarStackGraph!","ColGraph!","ColStackGraph!","LineGraph!","PieGraph!","ScatterGraph!"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SelectItem(1)
This.TriggerEvent(SelectionChanged!)

end event

event selectionchanged;String	ls_Value

ls_Value = This.Text

//Tab_1.TabPage_3.ddlb_17.Reset()
//Tab_1.TabPage_3.ddlb_17.AddItem("Title")
//Tab_1.TabPage_3.ddlb_17.AddItem("Legend")
//Tab_1.TabPage_3.ddlb_17.AddItem("Category Axis Label")
//Tab_1.TabPage_3.ddlb_17.AddItem("Category Axis Text")
//Tab_1.TabPage_3.ddlb_17.AddItem("Value Axis Label")
//Tab_1.TabPage_3.ddlb_17.AddItem("Value Axis Text")
//Tab_1.TabPage_3.ddlb_17.AddItem("Series Axis Label")
//Tab_1.TabPage_3.ddlb_17.AddItem("Series Axis Text")

//tab_1.TabPage_2.Visible = True

Choose Case ls_Value
	Case 'AreaGraph!'
		gr_1.GraphType = AreaGraph!
//		wf_disabled_1(False,False,False,False,False,False)				//都不可用
		//Category,Value
	Case 'Bar3DObjGraph!'
		gr_1.GraphType = Bar3DObjGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'BarGraph!'
		gr_1.GraphType = BarGraph!
//		wf_disabled_1(False,False,False,True,True,False)				//4,5可用
		//Category,Value
	Case 'BarStack3DObjGraph!'
		gr_1.GraphType = BarStack3DObjGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'BarStackGraph!'
		gr_1.GraphType = BarStackGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'Col3DObjGraph!'
		gr_1.GraphType = Col3DObjGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'ColGraph!'
		gr_1.GraphType = ColGraph!
//		wf_disabled_1(False,False,False,True,True,False)				//4,5可用
		//Category,Value
	Case 'ColStack3DObjGraph!'
		gr_1.GraphType = ColStack3DObjGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'ColStackGraph!'
		gr_1.GraphType = ColStackGraph!
//		wf_disabled_1(False,False,False,False,True,False)				//5可用
		//Category,Value
	Case 'LineGraph!'
		gr_1.GraphType = LineGraph!
//		wf_disabled_1(False,False,False,False,False,False)				//都不可用
		//Category,Value
	Case 'PieGraph!'
		gr_1.GraphType = PieGraph!
//		wf_disabled_1(False,False,False,False,False,False)				//都不可用
		//Title,Legend,Pie Graph Labels
//		tab_1.TabPage_2.Visible = false
//		tab_1.SelectedTab = 1
//		Tab_1.TabPage_3.ddlb_17.Reset()
//		Tab_1.TabPage_3.ddlb_17.AddItem("Title")
//		Tab_1.TabPage_3.ddlb_17.AddItem("Legend")
//		Tab_1.TabPage_3.ddlb_17.AddItem("Pie Graph Labels")
	Case 'ScatterGraph!'
		gr_1.GraphType = ScatterGraph!
//		wf_disabled_1(False,False,False,False,False,False)				//都不可用
		//Category,Value
End Choose

//Tab_1.TabPage_3.ddlb_17.SelectItem(1)
//lb_1.Trigger Event SelectionChanged(lb_1.SelectedIndex())

end event

type st_1 from statictext within u_graphcontrol
integer x = 2007
integer y = 40
integer width = 457
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Graph Style:"
boolean focusrectangle = false
end type

type gr_1 from graph within u_graphcontrol
integer x = 32
integer y = 1264
integer width = 4265
integer height = 1680
grgraphtype graphtype = colgraph!
long textcolor = 33554432
integer spacing = 100
string title = "Totals By Order"
integer elevation = 20
integer rotation = -20
integer perspective = 2
integer depth = 100
grlegendtype legend = atbottom!
borderstyle borderstyle = stylelowered!
grsorttype categorysort = ascending!
end type

on gr_1.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.TextSize=40
TitleDispAttr.FaceName="Segoe UI"
TitleDispAttr.FontCharSet=DefaultCharSet!
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
Category.Label="Departments"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Segoe UI"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Segoe UI"
Category.LabelDispAttr.FontCharSet=DefaultCharSet!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="(None)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=dash!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Segoe UI"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Segoe UI"
Values.LabelDispAttr.FontCharSet=DefaultCharSet!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Segoe UI"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Segoe UI"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Segoe UI"
LegendDispAttr.FontCharSet=DefaultCharSet!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Tahoma"
PieDispAttr.FontCharSet=DefaultCharSet!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_1.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

type gb_1 from groupbox within u_graphcontrol
integer x = 41
integer width = 891
integer height = 632
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Category"
end type

type gb_2 from groupbox within u_graphcontrol
integer x = 997
integer width = 946
integer height = 632
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Values To Graph"
end type

