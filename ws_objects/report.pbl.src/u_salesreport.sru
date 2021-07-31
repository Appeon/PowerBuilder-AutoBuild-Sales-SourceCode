$PBExportHeader$u_salesreport.sru
forward
global type u_salesreport from u_tab_base
end type
type dw_filter from u_dw within tabpage_1
end type
type cb_filter from u_button within tabpage_1
end type
type htb_1 from htrackbar within tabpage_1
end type
type cbx_pie from checkbox within tabpage_1
end type
type cbx_salesroom from checkbox within tabpage_1
end type
type cbx_saleqty from checkbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_subfilter from u_dw within tabpage_2
end type
type cb_subfilter from u_button within tabpage_2
end type
type tabpage_4 from userobject within tab_1
end type
type dw_report from u_dw within tabpage_4
end type
type wb_2 from webbrowser within tabpage_4
end type
type st_2 from statictext within tabpage_4
end type
type ddplb_gc_graph from dropdownpicturelistbox within tabpage_4
end type
type cb_gcfilter from u_button within tabpage_4
end type
type dw_gcfilter from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_report dw_report
wb_2 wb_2
st_2 st_2
ddplb_gc_graph ddplb_gc_graph
cb_gcfilter cb_gcfilter
dw_gcfilter dw_gcfilter
end type
type tabpage_5 from userobject within tab_1
end type
type wb_3 from webbrowser within tabpage_5
end type
type dw_report2 from u_dw within tabpage_5
end type
type ddplb_graph_gc2 from dropdownpicturelistbox within tabpage_5
end type
type st_4 from statictext within tabpage_5
end type
type cb_gcfilter2 from u_button within tabpage_5
end type
type dw_gcfilter2 from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
wb_3 wb_3
dw_report2 dw_report2
ddplb_graph_gc2 ddplb_graph_gc2
st_4 st_4
cb_gcfilter2 cb_gcfilter2
dw_gcfilter2 dw_gcfilter2
end type
type tabpage_6 from userobject within tab_1
end type
type wb_1 from webbrowser within tabpage_6
end type
type dw_report3 from u_dw within tabpage_6
end type
type cb_1 from u_button within tabpage_6
end type
type dw_gcfilter3 from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
wb_1 wb_1
dw_report3 dw_report3
cb_1 cb_1
dw_gcfilter3 dw_gcfilter3
end type
type st_graph from statictext within u_salesreport
end type
type ddplb_graph from dropdownpicturelistbox within u_salesreport
end type
end forward

global type u_salesreport from u_tab_base
integer width = 4133
integer height = 2720
long backcolor = 16777215
event type integer ue_categoryreport_preview_gc ( )
event type integer ue_subcategoryreport_preview_gc2 ( )
event type integer ue_subcategoryreport_preview ( )
event type integer ue_categoryreport_preview ( )
st_graph st_graph
ddplb_graph ddplb_graph
end type
global u_salesreport u_salesreport

type variables
u_salesreport iuo_report
String is_controllername = 'OrderReport'
datawindowchild adwc_proc

string is_file_column
string is_file_column1
string is_file_pie
string is_file_line
string is_file_bubble
int ii_cur_index = 1
int ii_cur_index2 = 1
int ii_index = 1
end variables

forward prototypes
public function integer of_winopen ()
public function integer of_data_verify ()
public function integer of_zoom (integer ai_zoom)
public function integer of_setdwvisible ()
public function integer of_selectgraph (integer ai_index)
public subroutine of_retrieve_webbrowse ()
public subroutine wf_create_local_file_bak ()
public function integer of_selectgraph_gc2 (integer ai_index)
public function integer of_selectgraph_gc (integer ai_index)
public subroutine wf_create_local_file ()
public function integer wf_create_html (string as_file, string as_data, string as_options, string as_chart)
public subroutine wf_create_bubble_data ()
public subroutine wf_create_local_file2 ()
public function integer wf_create_html2 (string as_file, string as_data, string as_options, string as_chart)
public subroutine of_set_backcolor (integer ai_tab)
public function string wf_string (decimal ad_data)
end prototypes

event type integer ue_categoryreport_preview_gc();String ls_from
String ls_to
Long ll_year, ll_month,ll_day
DateTime ldt_from , ldt_from1

DateTime ldt_to, ldt_to1
String ls_title
Long ll_addrow
Int ll_row
DataStore lds_data

u_dw dw_categoryreport
dw_categoryreport = tab_1.tabpage_6.dw_report3

tab_1.tabpage_6.dw_gcfilter3.AcceptText()

ldt_from = tab_1.tabpage_6.dw_gcfilter3.GetItemDateTime(1, "date_from")
ldt_to = tab_1.tabpage_6.dw_gcfilter3.GetItemDateTime(1, "date_to")

ls_from = String(ldt_from)
ls_to = String(ldt_to)

ll_year = Year(Date(ldt_from))

dw_categoryreport.Reset()

dw_categoryreport.Modify("t_now.text ='" + String (ll_year)+ "'")

dw_categoryreport.Modify("t_laster.text = '" + String(ll_year - 1) +"'")
ls_title = 'Sales Report ('+ String (ll_year) + ' VS. ' + String(ll_year - 1) + ')'
dw_categoryreport.Modify("t_title.text = '" + ls_title +"'")


lds_data = Create DataStore
lds_data.DataObject = "d_categorysalesreport_year"
lds_data.SetTransObject(Sqlca)
lds_data.Retrieve(ldt_from, ldt_to)

For ll_row = 1 To lds_data.RowCount( )
	ll_addrow = dw_categoryreport.InsertRow(0)
	dw_categoryreport.SetItem(ll_addrow, "productcategoryname", lds_data.GetItemString(ll_row, "categoryname"))
	dw_categoryreport.SetItem(ll_addrow, "totalsalesqty", lds_data.GetItemNumber(ll_row, "totalsalesqty"))
	dw_categoryreport.SetItem(ll_addrow, "totalsaleroom", lds_data.GetItemNumber(ll_row, "totalsaleroom"))
Next


ldt_from1 = datetime(string(ll_year - 1) +'-' +string(month(Date(ldt_from))) +'-' + string(day(date(ldt_from))))
ldt_to1 = datetime(string(ll_year -1) +'-' + string(month(date(ldt_to))) +'-' + string(day(date(ldt_to))))
 
lds_data.Reset()
lds_data.Retrieve(ldt_from1, ldt_to1)

For ll_row = 1 To lds_data.RowCount( )
	ll_addrow = dw_categoryreport.Find ("productcategoryname='" + lds_data.GetItemString(ll_row, "categoryname") + "'", 1, dw_categoryreport.RowCount())
	IF ll_addrow > 0 THEN
		dw_categoryreport.SetItem(ll_addrow, "lasttotalsalesqty", lds_data.GetItemNumber(ll_row, "totalsalesqty"))
		dw_categoryreport.SetItem(ll_addrow, "lasttotalsaleroom", lds_data.GetItemNumber(ll_row, "totalsaleroom"))
	END IF
Next

IF IsValid(lds_data) THEN Destroy lds_data


//inv_webapi.of_categoryreport_gc(tab_1.tabpage_6.dw_report3, ls_from, ls_to)

Return 1
end event

event type integer ue_subcategoryreport_preview_gc2();String ls_year
String ls_annual
Long ll_categoryid
Long i
String ls_subname
String ls_title
String ls_yearfirst 
String ls_month[]
String ls_firstmonths[6] = {"January", "February", "March", "April", "May", "June"}
String ls_lastmonths[6] = {"July", "August", "September", "October", "November", "December"}
Long ll_monthfrom
Long ll_monthto
DateTime ldt_from
DateTime ldt_to
Long ll_addrow
Int ll_row
String ls_cur_subname
String ls_piror_subname
String ls_monthname
Int li_monthno

DataStore lds_data
u_dw dw_subcategoryreport

DataWindowChild ldwc_child

tab_1.tabpage_5.dw_gcfilter2.AcceptText()
ll_categoryid = tab_1.tabpage_5.dw_gcfilter2.GetItemnumber(1, "categoryid")

ls_year = tab_1.tabpage_5.dw_gcfilter2.GetItemString(1, "year")
ls_annual = tab_1.tabpage_5.dw_gcfilter2.GetItemString(1, "annual")

dw_subcategoryreport = tab_1.tabpage_5.dw_report2
dw_subcategoryreport.Reset()

IF ls_annual = "first" Then
	ls_yearfirst = "First Half Year"
	ls_month = ls_firstmonths
	ll_monthfrom = Long( ls_year + "01")
	ll_monthto = Long( ls_year + "06")
	ldt_from = DateTime(ls_year + "-01-01")
	ldt_to = DateTime(ls_year + "-07-01")
Else
	ls_yearfirst = "Second Half Year"
	ls_month = ls_lastmonths
	ll_monthfrom = Long( ls_year + "07")
	ll_monthto = Long( ls_year + "12")
	ldt_from = DateTime(ls_year + "-07-01")
	ldt_to = DateTime(ls_year + "-12-31")
End IF

lds_data = Create DataStore
lds_data.DataObject = "d_subcategorysalesreport_gc_half"
lds_data.SetTransObject(Sqlca)
lds_data.Retrieve(ll_categoryid,  ll_monthfrom, ll_monthto)


For ll_row = 1 To 6
	dw_subcategoryreport.Modify("salesroommonth" + String(ll_row) + "_t.text = '"+ls_month[ll_row]+"'")
Next 

For ll_row = 1 To lds_data.RowCount()
	ls_cur_subname = lds_data.GetItemString(ll_row, "SubcategoryName")
	IF ls_cur_subname <> ls_piror_subname Then
		ll_addrow = dw_subcategoryreport.InsertRow(0)
		dw_subcategoryreport.SetItem(ll_addrow, "name", ls_cur_subname)
	END IF
	
	ls_monthname =  lds_data.GetItemString(ll_row, "monthname")
	li_monthno = Integer(Right(ls_monthname, 2))
	IF li_monthno > 6 THEN li_monthno = li_monthno - 6
	
	dw_subcategoryreport.SetItem(ll_addrow, "salesqtymonth" + String(li_monthno), lds_data.GetItemNumber(ll_row, "TotalSalesqty"))
	dw_subcategoryreport.SetItem(ll_addrow, "salesroommonth" + String(li_monthno), lds_data.GetItemDecimal(ll_row, "TotalSaleroom"))
	
	ls_piror_subname = ls_cur_subname
Next 


IF IsValid(lds_data) THEN Destroy lds_data

Return 1
end event

event type integer ue_subcategoryreport_preview();Long ll_subcategoryid
String ls_year
String ls_annual
String ls_yearfirst
Long ll_monthfrom
Long ll_monthto
Long ll_addrow
Int ll_row
String ls_title
Int li_graphrow
String ls_subname
String ls_monthname
Int li_monthno

String ls_month[]
String ls_firstmonths[6] = {"January", "February", "March", "April", "May", "June"}
String ls_lastmonths[6] = {"July", "August", "September", "October", "November", "December"}

DateTime ldt_from
DateTime ldt_to

DataStore lds_data

DataWindowChild ldwc_child
DataWindowChild ldwc_list
DataWindowChild ldwc_prod

tab_1.tabpage_2.dw_subfilter.AcceptText()
ll_subcategoryid = tab_1.tabpage_2.dw_subfilter.GetItemnumber(1, "subcategoryid")
ls_year = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "year")
ls_annual = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "annual")

IF ls_annual = "first" Then
	ls_yearfirst = "First Half Year"
	ls_month = ls_firstmonths
	ll_monthfrom = Long( ls_year + "01")
	ll_monthto = Long( ls_year + "06")
	ldt_from = DateTime(ls_year + "-01-01")
	ldt_to = DateTime(ls_year + "-07-01")
Else
	ls_yearfirst = "Second Half Year"
	ls_month = ls_lastmonths
	ll_monthfrom = Long( ls_year + "07")
	ll_monthto = Long( ls_year + "12")
	ldt_from = DateTime(ls_year + "-07-01")
	ldt_to = DateTime(ls_year + "-12-31")
End IF

lds_data = Create DataStore
lds_data.DataObject = "d_subcategorysalesreport_half"
lds_data.SetTransObject(Sqlca)
lds_data.Retrieve(ll_subcategoryid,  ll_monthfrom, ll_monthto)

tab_1.tabpage_2.dw_master.reset()

tab_1.tabpage_2.dw_master.GetChild("dw_subcategorysalesreport", ldwc_child)
ldwc_child.SetTransObject(Sqlca)

IF lds_data.RowCount() < 1 Then Return -1

tab_1.tabpage_2.dw_master.GetChild("dw_subcategorysalesreport_graph", ldwc_list)
ldwc_list.SetTransObject(Sqlca)

tab_1.tabpage_2.dw_master.GetChild("dw_productsalesreport", adwc_proc)
adwc_proc.SetTransObject(Sqlca)


ll_addrow = ldwc_child.InsertRow(0)

For ll_row = 1 To 6
	ldwc_child.Modify("salesroommonth" + String(ll_row) + "_t.text = '"+ls_month[ll_row]+"'")
Next 

For ll_row = 1 To lds_data.RowCount()
	IF ll_row = 1 THEN
		ls_subname =  lds_data.GetItemString(1, "SubcategoryName")
		ldwc_child.SetItem(ll_addrow, "name", ls_subname)
	END IF
	
	ls_monthname =  lds_data.GetItemString(ll_row, "monthname")
	li_monthno = Integer(Right(ls_monthname, 2))
	IF li_monthno > 6 THEN li_monthno = li_monthno - 6
	
	ldwc_child.SetItem(ll_addrow, "salesqtymonth" + String(li_monthno), lds_data.GetItemNumber(ll_row, "TotalSalesqty"))
	ldwc_child.SetItem(ll_addrow, "salesroommonth" + String(li_monthno), lds_data.GetItemDecimal(ll_row, "TotalSaleroom"))
	
	li_graphrow =  ldwc_list.Insertrow(0)
	ldwc_list.SetItem(li_graphrow, "id", ll_row)
	ldwc_list.SetItem(li_graphrow, "name", ls_subname)
	ldwc_list.SetItem(li_graphrow, "month", ls_month[li_monthno])
	ldwc_list.SetItem(li_graphrow, "totalsalesqty",  lds_data.GetItemNumber(ll_row, "TotalSalesqty"))
	ldwc_list.SetItem(li_graphrow, "totalsaleroom", lds_data.GetItemDecimal(ll_row, "TotalSaleroom"))
Next

ls_title = 'Sales Report of ' + ls_year 
ldwc_child.Modify("t_title.text = '" + ls_title + "'")

ldwc_list.Modify("gr_1.category.label='(Total sales per month)'")
ls_title =  'Total Sales of '  + ls_yearfirst
ldwc_list.Modify("gr_1.title ='" + ls_title + "'")

ldwc_list.SetSort("id ASC")
ldwc_list.Sort()


adwc_proc.Retrieve(ll_subcategoryid, ldt_from, ldt_to)
//adwc_proc = 

If Len(ddplb_graph.text) > 0 Then
	of_selectgraph(ii_index)
End If

IF IsValid(lds_data) THEN Destroy lds_data

Return 1
end event

event type integer ue_categoryreport_preview();String ls_from
String ls_to
String ls_categoryname
String  ls_url
String ls_title
Integer li_row
Integer li_cnt
Integer li_year
Integer li_add
Integer li_ret
Long    ll_totalsalesqty
Decimal ldc_totalsaleroom
String ls_year
String ls_year_prior
DateTime ldt_from
DateTime ldt_to
DateTime ldt_lastfrom
DateTime ldt_lastto
Integer li_addcom
Integer li_addqty

DataWindowChild ldwc_child
DataWindowChild ldwc_pie
DataWindowChild ldwc_qty
DataWindowChild ldwc_list
DataWindowChild ldwc_compare

DataStore lds_lastyear

tab_1.tabpage_1.dw_filter.AcceptText()

ldt_from = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_from")
ldt_to = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_to")

ls_from = String(ldt_from, "yyyy-mm-dd")
ls_to = String(ldt_to, "yyyy-mm-dd")

ls_year = String(Year (Date(ldt_from)) )
ls_year_prior = String(Year (Date(ldt_from)) - 1 )

ldt_lastfrom = DateTime(ls_year_prior + Mid(ls_from, 5))
ldt_lastto = DateTime(ls_to + Mid(ls_to, 5))

lds_lastyear = Create DataStore
lds_lastyear.DataObject = "d_categorysalesreport_d"
lds_lastyear.SetTransObject(Sqlca)
lds_lastyear.Retrieve(ldt_lastfrom,  ldt_lastto)

tab_1.tabpage_1.dw_browser.Reset()

tab_1.tabpage_1.dw_browser.GetChild("dw_catereport", ldwc_child)
ldwc_child.SetTransObject(Sqlca)
ldwc_child.reset()
ldwc_child.Retrieve( ldt_from, ldt_to )

tab_1.tabpage_1.dw_browser.GetChild("dw_catereport_pie", ldwc_pie)
ldwc_pie.SetTransObject(Sqlca)

For li_cnt = 1 To ldwc_child.RowCount()
	li_add = ldwc_pie.insertrow(0)
	ldwc_pie.SetItem(li_add, "productcategoryname", ldwc_child.GetItemString(li_cnt, "productcategoryname"))
	ldwc_pie.SetItem(li_add, "totalsalesqty", ldwc_child.GetItemNumber(li_cnt, "totalsalesqty"))
	ldwc_pie.SetItem(li_add, "totalsaleroom", ldwc_child.GetItemDecimal(li_cnt, "totalsaleroom"))
Next 

tab_1.tabpage_1.dw_browser.GetChild("dw_compare", ldwc_compare)
ldwc_compare.SetTransObject(Sqlca)
ldwc_compare.reset()

tab_1.tabpage_1.dw_browser.GetChild("dw_qty", ldwc_qty)
ldwc_qty.SetTransObject(Sqlca)
ldwc_qty.reset()

li_row = ldwc_child.Rowcount()
tab_1.tabpage_1.dw_browser.GetChild("dw_reportlist", ldwc_list)
ldwc_list.SetTransObject(Sqlca)
ldwc_list.reset()

ldwc_list.Modify("t_now.text ='" + ls_year + "'")

For li_cnt = 1 To li_row
	li_add = ldwc_list.Insertrow(0)
	ls_categoryname = ldwc_child.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = ldwc_child.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = ldwc_child.GetItemDecimal(li_cnt, "totalsaleroom")
	ldwc_list.SetItem(li_add, "productcategoryname", ls_categoryname)
	ldwc_list.SetItem(li_add, "totalsalesqty", ll_totalsalesqty)
	ldwc_list.SetItem(li_add, "totalsaleroom", ldc_totalsaleroom)
	
	li_addcom = ldwc_compare.InsertRow(0)
	ldwc_compare.SetItem(li_addcom, "year",  ls_year)
	ldwc_compare.SetItem(li_addcom, "productcategoryname", ls_categoryname)
	ldwc_compare.SetItem(li_addcom, "totalsalesqty", ll_totalsalesqty)
	ldwc_compare.SetItem(li_addcom, "totalsaleroom", ldc_totalsaleroom)
	
	li_addqty = ldwc_qty.InsertRow(0)
	ldwc_qty.SetItem(li_addqty, "year", ls_year)
	ldwc_qty.SetItem(li_addqty, "year",  ls_year)
	ldwc_qty.SetItem(li_addqty, "productcategoryname", ls_categoryname)
	ldwc_qty.SetItem(li_addqty, "totalsalesqty", ll_totalsalesqty)
	ldwc_qty.SetItem(li_addqty, "totalsaleroom", ldc_totalsaleroom)
Next

ldwc_list.Modify("t_laster.text = '" + ls_year_prior +"'")
ls_title = 'Sales Report ('+ ls_year + ' VS. ' + ls_year_prior + ')'
ldwc_list.Modify("t_title.text = '" + ls_title +"'")

ls_title = 'Sales Amount Per Category (' + ls_year + ' VS. ' + ls_year_prior + ')'
ldwc_child.Modify("gr_1.title='"+ ls_title + "'")
ldwc_child.Modify("gr_1.category.label='("+ ls_year + ' VS. ' + ls_year_prior+")'")

ls_title = 'Sales Volume Per Category (' + ls_year + ' VS. ' + ls_year_prior + ')'
ldwc_qty.Modify("gr_1.title='"+ ls_title + "'")
ldwc_qty.Modify("gr_1.category.label='("+ ls_year + ' VS. ' + ls_year_prior +")'")


For li_cnt = 1  To lds_lastyear.Rowcount()
	ls_categoryname = lds_lastyear.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = lds_lastyear.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = lds_lastyear.GetItemDecimal(li_cnt, "totalsaleroom")
	
	li_add = ldwc_list.Find("productcategoryname = '" + ls_categoryname + "'", 1, ldwc_list.rowcount())
	
	IF li_add > 0 Then
		ldwc_list.SetItem(li_add, "lasttotalsalesqty", ll_totalsalesqty)
		ldwc_list.SetItem(li_add, "lasttotalsaleroom", ldc_totalsaleroom)
		
		li_addcom = ldwc_compare.InsertRow(0)
		ldwc_compare.SetItem(li_addcom, "year",  ls_year_prior)
		ldwc_compare.SetItem(li_addcom, "productcategoryname", ls_categoryname)
		ldwc_compare.SetItem(li_addcom, "totalsalesqty", ll_totalsalesqty)
		ldwc_compare.SetItem(li_addcom, "totalsaleroom", ldc_totalsaleroom)
		
		li_addqty = ldwc_qty.InsertRow(0)
		ldwc_qty.SetItem(li_addqty, "year", ls_year_prior)
		ldwc_qty.SetItem(li_addqty, "productcategoryname", ls_categoryname)
		ldwc_qty.SetItem(li_addqty, "totalsalesqty", ll_totalsalesqty)
		ldwc_qty.SetItem(li_addqty, "totalsaleroom", ldc_totalsaleroom)	
	End IF	
Next

IF IsValid(lds_lastyear) THEN Destroy lds_lastyear

of_setdwvisible()

Return 1
end event

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

IF tab_1.tabpage_2.dw_subfilter.RowCount() < 1 Then
	tab_1.tabpage_2.dw_subfilter.InsertRow(1)	
End IF


tab_1.tabpage_2.dw_subfilter.GetChild("categoryid", ldwc_child)
ldwc_child.SetTransObject(Sqlca)
ldwc_child.Retrieve( )

tab_1.tabpage_2.dw_subfilter.GetChild("subcategoryid", ldwc_child)
ldwc_child.SetTransObject(Sqlca)
ldwc_child.Retrieve( )

tab_1.tabpage_5.dw_gcfilter2.GetChild("categoryid", ldwc_child)
ldwc_child.SetTransObject(Sqlca)
ldwc_child.Retrieve( )

//Retrieve Dddw
//inv_webapi.of_winopen(tab_1.tabpage_2.dw_subfilter, tab_1.tabpage_1.dw_browser,  tab_1.tabpage_2.dw_master, tab_1.tabpage_4.dw_gcfilter, tab_1.tabpage_5.dw_gcfilter2)

tab_1.tabpage_2.dw_subfilter.SetItem(1, "categoryid", 1)
tab_1.tabpage_2.dw_subfilter.SetItem(1, "subcategoryid", 1)
tab_1.tabpage_2.dw_subfilter.SetItem(1, "year", "2013")
tab_1.tabpage_2.dw_subfilter.SetItem(1, "annual", "first")

tab_1.tabpage_4.dw_gcfilter.SetItem(1, "categoryid", 1)
tab_1.tabpage_4.dw_gcfilter.SetItem(1, "subcategoryid", 1)
tab_1.tabpage_4.dw_gcfilter.SetItem(1, "year", "2013")
tab_1.tabpage_4.dw_gcfilter.SetItem(1, "annual", "first")

tab_1.tabpage_5.dw_gcfilter2.SetItem(1, "categoryid", 1)
tab_1.tabpage_5.dw_gcfilter2.SetItem(1, "subcategoryid", 1)
tab_1.tabpage_5.dw_gcfilter2.SetItem(1, "year", "2013")
tab_1.tabpage_5.dw_gcfilter2.SetItem(1, "annual", "first")

Return 1
end function

public function integer of_data_verify ();String ls_year
Long ll_subcategoryid
DateTime ldt_from
DateTime ldt_to

Choose Case iuo_currentdw.ClassName()
	Case "dw_filter"
		tab_1.tabpage_1.dw_filter.AcceptText()
		ldt_from = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_from")
		ldt_to = tab_1.tabpage_1.dw_filter.GetItemDateTime(1, "date_to")
		
		IF Year(Date(ldt_from)) <> Year(Date(ldt_to)) Then
			MessageBox(gs_msg_title, "Please select a date of the same year.")
			Return -1
		End IF
		
	Case "dw_subfilter"
		tab_1.tabpage_2.dw_subfilter.AcceptText()
		ll_subcategoryid = tab_1.tabpage_2.dw_subfilter.GetItemnumber(1, "subcategoryid")
		ls_year = tab_1.tabpage_2.dw_subfilter.GetItemString(1, "year")
		
		IF IsNull(ll_subcategoryid) Then
			MessageBox(gs_msg_title, "Sub Category is required.")
			Return -1
		End IF
		
		IF IsNull(ls_year)  or ls_year = "" Then
			MessageBox(gs_msg_title, "Please set Year first ! ")
			Return -1
		End IF
	Case "dw_gcfilter"
		tab_1.tabpage_4.dw_gcfilter.AcceptText()
		ll_subcategoryid = tab_1.tabpage_4.dw_gcfilter.GetItemnumber(1, "subcategoryid")
		ls_year = tab_1.tabpage_4.dw_gcfilter.GetItemString(1, "year")
		
		IF IsNull(ll_subcategoryid) Then
			MessageBox(gs_msg_title, "Sub Category is required.")
			Return -1
		End IF
		
		IF IsNull(ls_year)  or ls_year = "" Then
			MessageBox(gs_msg_title, "Please set Year first ! ")
			Return -1
		End IF
	Case "dw_gcfilter2"
		tab_1.tabpage_5.dw_gcfilter2.AcceptText()
		ls_year = tab_1.tabpage_5.dw_gcfilter2.GetItemString(1, "year")
		
		IF IsNull(ls_year)  or ls_year = "" Then
			MessageBox(gs_msg_title, "Please set Year first ! ")
			Return -1
		End IF
	Case "dw_gcfilter3"
		tab_1.tabpage_6.dw_gcfilter3.AcceptText()
		ldt_from = tab_1.tabpage_6.dw_gcfilter3.GetItemDateTime(1, "date_from")
		ldt_to = tab_1.tabpage_6.dw_gcfilter3.GetItemDateTime(1, "date_to")
		
		IF Year(Date(ldt_from)) <> Year(Date(ldt_to)) Then
			MessageBox(gs_msg_title, "Please select a date of the same year.")
			Return -1
		End IF
End Choose

Return 1
end function

public function integer of_zoom (integer ai_zoom);
tab_1.tabpage_1.dw_browser.object.datawindow.print.preview.zoom = ai_zoom * 2

Return 1
end function

public function integer of_setdwvisible ();u_dw idw_currentdw
DataWindowChild ldwc_child

idw_currentdw = tab_1.tabpage_1.dw_browser

IF Not tab_1.tabpage_1.cbx_pie.Checked Then
	idw_currentdw.GetChild("dw_catereport_pie", ldwc_child)
	ldwc_child.ReSet()
End IF

IF Not tab_1.tabpage_1.cbx_salesroom.Checked Then
	idw_currentdw.GetChild("dw_compare", ldwc_child)
	ldwc_child.ReSet()
End IF

IF Not tab_1.tabpage_1.cbx_saleqty.Checked Then
	idw_currentdw.GetChild("dw_qty", ldwc_child)
	ldwc_child.ReSet()	
End IF

Return 1
end function

public function integer of_selectgraph (integer ai_index);Datawindowchild ldwc_graph

tab_1.tabpage_2.dw_master.GetChild("dw_subcategorysalesreport_graph", ldwc_graph)

Choose Case ai_index
	Case 1
		ldwc_graph.Modify("gr_1.GraphType='7'") 
	Case 2
		ldwc_graph.Modify("gr_1.GraphType='9'")  
	Case 3
		ldwc_graph.Modify("gr_1.GraphType='1'")  
	Case 4
		ldwc_graph.Modify("gr_1.GraphType='5'")  
	Case 5
		ldwc_graph.Modify("gr_1.GraphType='12'")  
End Choose

IF ai_index = 4 THEN
	ldwc_graph.modify("gr_1.values.dispattr.alignment='2'")
	ldwc_graph.modify('gr_1.values.labeldispattr.font.escapement="0"')
	ldwc_graph.modify('gr_1.values.labeldispattr.font.orientation="0"')
	ldwc_graph.modify('gr_1.category.dispattr.alignment="1"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.orientation="900"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.escapement="900"')
ELSE
	ldwc_graph.modify("gr_1.values.dispattr.alignment='1'")
	ldwc_graph.modify('gr_1.values.labeldispattr.font.escapement="900"')
	ldwc_graph.modify('gr_1.values.labeldispattr.font.orientation="900"')
	ldwc_graph.modify('gr_1.category.dispattr.alignment="2"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.orientation="0"')
	ldwc_graph.modify('gr_1.category.labeldispattr.font.escapement="0"')
END IF


Return 1
end function

public subroutine of_retrieve_webbrowse ();//If tab_1.tabpage_2.cbx_2.Checked Then
//	ddplb_graph_gc.Event SelectionChanged(ii_cur_index)
//End If


tab_1.tabpage_4.ddplb_gc_graph.Event SelectionChanged(ii_cur_index)
end subroutine

public subroutine wf_create_local_file_bak ();string ls_data
string ls_options
string ls_chart

string ls_category
decimal ldec_values
long ll_row
long ll_count
string ls_colname
string ls_title

DataWindowChild lds_test
tab_1.tabpage_2.dw_master.GetChild("dw_subcategorysalesreport", lds_test)

//Data
ls_data =	"            data.addColumn('string', 'Category');" + '~r~n' +&
				"            data.addColumn('number', 'Values');" + '~r~n' +&
				"            data.addRows([" 

ll_count = Long( lds_test.describe("DataWindow.Column.Count"))

for ll_row = 2 to ll_count
	ls_colname = lds_test.describe("#" + String(ll_row) + ".name")
	
	if pos( ls_colname , "salesroommonth") <= 0 then continue
	
	ls_category = lds_test.describe(ls_colname + "_t.text")
	ldec_values = lds_test.GetItemDecimal(1, ls_colname)
	
	if ll_row = ll_count then
		ls_data = ls_data + '~r~n' + "               ['" + ls_category + "'," +wf_string(ldec_values) + "]"
	else
		ls_data = ls_data + '~r~n' + "               ['" + ls_category + "'," +wf_string(ldec_values) + "],"
	end if
	
next

ls_data = ls_data + '~r~n' + "            ]);"

//destroy lds_test


IF tab_1.tabpage_2.dw_subfilter.GetItemString(1, "annual") = "first" THEN
	ls_title = 'Total Sales of First Half Year'
ELSE
	ls_title = 'Total Sales of Second Half Year'
END IF


//Options
ls_options =	"     var options = {"+ '~r~n' +& 
				"               'title':'" + ls_title + "',"  + '~r~n' +&
				"               'width':786,"+ '~r~n' +&
				"               'height':382"+ '~r~n' +&
				"               };"	+ '~r~n'					
//				"			   'is3D': true,"+ '~r~n' +&
				
//ColumnChart
ls_chart	= '     var chart = new google.visualization.ColumnChart(document.getElementById("container"));'

wf_create_html(is_file_column, ls_data, ls_options, ls_chart)


//PieChart	
ls_chart	= '     var chart = new google.visualization.PieChart(document.getElementById("container"));'

wf_create_html(is_file_pie, ls_data, ls_options, ls_chart)


end subroutine

public function integer of_selectgraph_gc2 (integer ai_index);

If ai_index = 1 Then tab_1.tabpage_5.wb_3.Navigate(is_file_column1)

If ai_index = 2 Then tab_1.tabpage_5.wb_3.Navigate(is_file_line)

ii_cur_index2 = ai_index

Return 1
end function

public function integer of_selectgraph_gc (integer ai_index);
If ai_index = 1 Then tab_1.tabpage_4.wb_2.Navigate(is_file_column)

If ai_index = 2 Then tab_1.tabpage_4.wb_2.Navigate(is_file_pie)

ii_cur_index = ai_index

Return 1
end function

public subroutine wf_create_local_file ();string ls_data
string ls_options
string ls_chart

string ls_category
decimal ldec_values
long ll_row
long ll_count
string ls_colname
string ls_title

u_dw ldw_report

ldw_report = tab_1.tabpage_4.dw_report

//Data
ls_data =	"            data.addColumn('string', 'Category');" + '~r~n' +&
				"            data.addColumn('number', 'Values');" + '~r~n' +&
				"            data.addRows([" 

ll_count = Long( ldw_report.describe("DataWindow.Column.Count"))

for ll_row = 2 to ll_count
	ls_colname = ldw_report.describe("#" + String(ll_row) + ".name")
	
	if pos( ls_colname , "salesroommonth") <= 0 then continue
	
	ls_category = ldw_report.describe(ls_colname + "_t.text")
	ldec_values = ldw_report.GetItemDecimal(1, ls_colname)
	
	if ll_row = ll_count then
		ls_data = ls_data + '~r~n' + "               ['" + ls_category + "'," +wf_string(ldec_values) + "]"
	else
		ls_data = ls_data + '~r~n' + "               ['" + ls_category + "'," +wf_string(ldec_values) + "],"
	end if
	
next

ls_data = ls_data + '~r~n' + "            ]);"

//destroy lds_test


IF tab_1.tabpage_2.dw_subfilter.GetItemString(1, "annual") = "first" THEN
	ls_title = 'Total Sales of First Half Year'
ELSE
	ls_title = 'Total Sales of Second Half Year'
END IF


//Options
ls_options =	"     var options = {"+ '~r~n' +& 
				"               'title':'" + ls_title + "',"  + '~r~n' +&
				"			   'is3D': true,"+ '~r~n' +&
				"               'width':786,"+ '~r~n' +&
				"               'height':382"+ '~r~n' +&
				"               };"	+ '~r~n'					
//				"			   'is3D': true,"+ '~r~n' +&
				
//ColumnChart
ls_chart	= '     var chart = new google.visualization.ColumnChart(document.getElementById("container"));'

wf_create_html(is_file_column, ls_data, ls_options, ls_chart)


//PieChart	
ls_chart	= '     var chart = new google.visualization.PieChart(document.getElementById("container"));'

wf_create_html(is_file_pie, ls_data, ls_options, ls_chart)


end subroutine

public function integer wf_create_html (string as_file, string as_data, string as_options, string as_chart);string  ls_line
integer li_file 

li_file = FileOpen (as_file, LineMode!, Write!, LockReadWrite!, Replace!) 

ls_line = '<html>'+ '~r~n' +&
'<head>'+ '~r~n' +&
'<script type="text/javascript" src="https://www.google.com/jsapi"></script>'+ '~r~n' +&
'  <script src="../js/jquery.min.js" type="text/javascript"></script>'+ '~r~n' +&
'  <script type="text/javascript">'+ '~r~n' +&
'    google.load("visualization", "1", {packages:["corechart"]});'+ '~r~n' +&
'    google.setOnLoadCallback(function() {'+ '~r~n' +&
'        // Place init code here instead of $(document).ready()'+ '~r~n' +&
'  	drawChart();'+ '~r~n' +&
'~r~n' +&
'    });'+ '~r~n' +&
'~r~n' +&
'  function drawChart() {'+ '~r~n' +&
'       // Define the chart to be drawn.'+ '~r~n' +&
 '     var data = new google.visualization.DataTable();'+ '~r~n' +&
 as_data+'~r~n' +&
'~r~n' +&
'      // Set chart options'+ '~r~n' +&
as_options + '~r~n' +&
'~r~n' +&
'     // Instantiate and draw the chart.'+ '~r~n' +&
as_chart + '~r~n' +&
'      chart.draw(data, options);'+ '~r~n' +&
'~r~n' +&
' }'+ '~r~n' +&
'</script>'+ '~r~n' +&
'</head>'+ '~r~n' +&
'<body>'+ '~r~n' +&
'    <div id = "container">'+ '~r~n' +&
'    </div>'+ '~r~n' +&
'</body>' 
			 
FileWrite (li_file, ls_line) 
FileClose (li_file) 
	
Return 1

end function

public subroutine wf_create_bubble_data ();string ls_data
string ls_options
string ls_chart
string ls_category
long ll_row
long ll_rowcnt
string ls_title
string ls_year1
string ls_year2
dec{3} ldc_rate
decimal ldc_totalsalesqty
decimal ldc_totalsaleroom
decimal ldc_lasttotalsalesqty
decimal ldc_lasttotalsaleroom
decimal ldc_sumsaleroom
decimal ldc_sumlastsaleroom


u_dw ldw_report

//Reference (https://developers.google.com/chart/interactive/docs/gallery/bubblechart)

ldw_report = tab_1.tabpage_6.dw_report3

ls_year1 = ldw_report.Describe("t_now.text")
ls_year2 = ldw_report.Describe("t_laster.text")

//Create DataTable
ls_data =	"([" 

ll_rowcnt = ldw_report.rowcount( )
ls_data = ls_data + '~r~n'
/*
ls_data = ls_data + "['Category', 'Sales Volume', 'Total Sales(USD)', 'Year']," + '~r~n'

for ll_row = 1 to ll_rowcnt
	ls_category = ldw_report.GetItemString(ll_row, "productcategoryname")
	ls_data = ls_data + "['" + ls_category + "', "
	ls_data = ls_data +  String(ldw_report.GetItemDecimal(ll_row, "totalsalesqty"))  + ", "
	ls_data = ls_data +   String(ldw_report.GetItemDecimal(ll_row, "totalsaleroom"))  + ", "
	ls_data = ls_data +  "'" + ls_year1 + "']," + "~r~n"
	ls_data = ls_data + "['" + ls_category + "', "
	ls_data = ls_data +  String(ldw_report.GetItemDecimal(ll_row, "lasttotalsalesqty"))  + ", "
	ls_data = ls_data +   String(ldw_report.GetItemDecimal(ll_row, "lasttotalsaleroom"))  + ", "
	ls_data = ls_data +  "'" + ls_year2 + "']"
	if ll_row <> ll_rowcnt then ls_data = ls_data + "," + "~r~n"
next
*/
ls_data = ls_data + "['Category', 'Sales Volume', 'Total Sales(USD)', 'Year', 'Rate']," + '~r~n'
ldc_sumsaleroom =  ldw_report.GetItemDecimal(0, "compute_1")
ldc_sumlastsaleroom =  ldw_report.GetItemDecimal(0, "compute_2")

for ll_row = 1 to ll_rowcnt
	ls_category = ldw_report.GetItemString(ll_row, "productcategoryname")
	ldc_totalsalesqty = ldw_report.GetItemDecimal(ll_row, "totalsalesqty")
	ldc_totalsaleroom = ldw_report.GetItemDecimal(ll_row, "totalsaleroom")
	ldc_lasttotalsalesqty = ldw_report.GetItemDecimal(ll_row, "lasttotalsalesqty")
	ldc_lasttotalsaleroom = ldw_report.GetItemDecimal(ll_row, "lasttotalsaleroom")
	ldc_rate =  ldc_totalsaleroom / ldc_sumsaleroom
	ls_data = ls_data + "['" + ls_category + "', "
	ls_data = ls_data +  wf_String(ldc_totalsalesqty)  + ", "
	ls_data = ls_data +   wf_String(ldc_totalsaleroom)  + ", "
	ls_data = ls_data +  "'" + ls_year1 + "', "
	ls_data = ls_data +  wf_String(ldc_rate) + "]," + "~r~n"
	
	ldc_rate = ldc_lasttotalsaleroom / ldc_sumlastsaleroom
	ls_data = ls_data + "['" + ls_category + "', "
	ls_data = ls_data +  wf_String(ldc_lasttotalsalesqty)  + ", "
	ls_data = ls_data +   wf_String(ldc_lasttotalsaleroom)  + ", "
	ls_data = ls_data +  "'" + ls_year2  + "', "
	ls_data = ls_data +  wf_String(ldc_rate) + "]"
	if ll_row <> ll_rowcnt then ls_data = ls_data + "," + "~r~n"
next
ls_data = ls_data + '~r~n' + "]);"


ls_title = 'Sales Report ('+ ls_year1 + ' VS. ' + ls_year2 + ')'

//Options
ls_options =	"     var options = {"+ '~r~n' +& 
				"               title:'" + ls_title + "',"  + '~r~n' +&	
				"               width:828,"+ '~r~n' +&
				"               height:382,"+ '~r~n' +&
				"               hAxis: {title: 'Sales Volume'},"+ '~r~n' +&
        			"               vAxis: {title: 'Total Sales(USD)'},"+ '~r~n' +&
        			"               bubble: {textStyle: {fontSize: 11}}"+ '~r~n' +&
				"               };"	+ '~r~n'					
				

//ColumnChart
ls_chart	= '     var chart = new google.visualization.BubbleChart(document.getElementById("container"));'

wf_create_html2(is_file_bubble, ls_data, ls_options, ls_chart)



end subroutine

public subroutine wf_create_local_file2 ();string ls_data
string ls_options
string ls_chart

string ls_category
decimal ldec_values
long ll_row
long ll_col
long ll_count
long ll_rowcnt
string ls_colname
string ls_title

u_dw ldw_report

//Reference (https://developers.google.com/chart/interactive/docs/gallery/columnchart)

ldw_report = tab_1.tabpage_5.dw_report2

//Create DataTable
ls_data =	"([" 

ll_count = Long( ldw_report.describe("DataWindow.Column.Count"))

ll_rowcnt = ldw_report.rowcount( )
ls_data = ls_data + '~r~n'

for ll_col = 1 to ll_count
	ls_colname = ldw_report.describe("#" + String(ll_col) + ".name")
	if ll_col > 1 and pos( ls_colname , "salesroommonth") <= 0 then continue
	for ll_row = 1 to ll_rowcnt		
		if  ll_col = 1 then
			ls_category = ldw_report.GetItemString(ll_row, "name")
			if ll_row = 1 then
				ls_data = ls_data + " ['month', '" + ls_category + "' , "
			elseif ll_row = ll_rowcnt then
				ls_data = ls_data + " '" + ls_category +  "', { role: 'annotation' } ] , " +  '~r~n'
			else
				ls_data = ls_data + " '" + ls_category + "' , "
			end if
		else			
			ldec_values = ldw_report.GetItemDecimal(ll_row, ls_colname)
			if isnull(ldec_values) then ldec_values = 0
			if ll_row = 1 then
				ls_category = ldw_report.describe(ls_colname + "_t.text")	
				ls_data = ls_data + " ['" + ls_category + "' , " + wf_String(ldec_values) + " , "
			elseif ll_row = ll_rowcnt then
				ls_data = ls_data +  wf_String(ldec_values) + " , '']"
				if ll_col <> ll_count then 
					ls_data = ls_data + ", " +  '~r~n'
				end if
			else
				ls_data = ls_data +  wf_String(ldec_values) + " , "
			end if
		end if
	next 
next

ls_data = ls_data + '~r~n' + "]);"


IF tab_1.tabpage_2.dw_subfilter.GetItemString(1, "annual") = "first" THEN
	ls_title = 'Total Sales of First Half Year'
ELSE
	ls_title = 'Total Sales of Second Half Year'
END IF


//Options
ls_options =	"     var options = {"+ '~r~n' +& 
				"               title:'" + ls_title + "',"  + '~r~n' +&	
				"               width:828,"+ '~r~n' +&
				"               height:382,"+ '~r~n' +&
				"               legend: { position: 'top', maxLines: 3 },"+ '~r~n' +&
        			"               bar: { groupWidth: '75%' },"+ '~r~n' +&
        			"               isStacked: true,"+ '~r~n' +&
				"               };"	+ '~r~n'					
				

//ColumnChart
ls_chart	= '     var chart = new google.visualization.ColumnChart(document.getElementById("container"));'

wf_create_html2(is_file_column1, ls_data, ls_options, ls_chart)



//Reference (https://developers.google.com/chart/interactive/docs/gallery/linechart)
//LineChart	
ls_options	= 	"     var options = {"+ '~r~n' +& 
				   	"               title:'" + ls_title + "',"  + '~r~n' +&	
					"               width:828,"+ '~r~n' +&
					"               height:382,"+ '~r~n' +&
				  	"               curveType: 'function'," + '~r~n' +&
				  	"               legend: { position: 'bottom' }" + '~r~n' +&
					"               };"	+ '~r~n'		
		  
ls_chart	= '     var chart = new google.visualization.LineChart(document.getElementById("container"));'

wf_create_html2(is_file_line, ls_data, ls_options, ls_chart)


end subroutine

public function integer wf_create_html2 (string as_file, string as_data, string as_options, string as_chart);string  ls_line
integer li_file 

li_file = FileOpen (as_file, LineMode!, Write!, LockReadWrite!, Replace!) 

//Reference (https://developers.google.com/chart/interactive/docs/gallery/columnchart)

ls_line = '<html>'+ '~r~n' +&
'<head>'+ '~r~n' +&
'<script type="text/javascript" src="https://www.google.com/jsapi"></script>'+ '~r~n' +&
'  <script src="../js/jquery.min.js" type="text/javascript"></script>'+ '~r~n' +&
'  <script type="text/javascript">'+ '~r~n' +&
'    google.load("visualization", "1", {packages:["corechart"]});'+ '~r~n' +&
'    google.setOnLoadCallback(function() {'+ '~r~n' +&
'        // Place init code here instead of $(document).ready()'+ '~r~n' +&
'  	drawChart();'+ '~r~n' +&
'~r~n' +&
'    });'+ '~r~n' +&
'~r~n' +&
'  function drawChart() {'+ '~r~n' +&
'       // Define the chart to be drawn.'+ '~r~n' +&
 '     var data = new google.visualization.arrayToDataTable'+ '~r~n' +&
 as_data+'~r~n' +&
'~r~n' +&
'      // Set chart options'+ '~r~n' +&
as_options + '~r~n' +&
'~r~n' +&
'     // Instantiate and draw the chart.'+ '~r~n' +&
as_chart + '~r~n' +&
'      chart.draw(data, options);'+ '~r~n' +&
'~r~n' +&
' }'+ '~r~n' +&
'</script>'+ '~r~n' +&
'</head>'+ '~r~n' +&
'<body>'+ '~r~n' +&
'    <div id = "container">'+ '~r~n' +&
'    </div>'+ '~r~n' +&
'</body>' 
			 
FileWrite (li_file, ls_line) 
FileClose (li_file) 
	
Return 1

end function

public subroutine of_set_backcolor (integer ai_tab);datawindowchild ldc_a
String ls_color
String ls_theme
String ls_file

ls_file = "apisetup.ini"
ls_theme = ProfileString(ls_file, "Setup", "Theme", "Flat Design Blue")
ls_color = ProfileString(ls_file, "BackColor", ls_theme, "16764603")

Choose Case ai_tab
	Case 1
		tab_1.tabpage_1.dw_browser.getchild('dw_catereport', ldc_a)
		ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")
		
		tab_1.tabpage_1.dw_browser.getchild('dw_reportlist', ldc_a)
		ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")
	Case 2

		tab_1.tabpage_2.dw_master.getchild('dw_subcategorysalesreport', ldc_a)
		ldc_a.Modify("t_1.Background.Color='" + ls_color + "'")
		
		tab_1.tabpage_2.dw_master.getchild('dw_productsalesreport', ldc_a)
		ldc_a.Modify("t_2.Background.Color='" + ls_color + "'")
	Case 4
		tab_1.tabpage_4.dw_report.Modify("t_1.Background.Color='" + ls_color + "'")
		//tab_1.tabpage_4.dw_report.Modify("t_2.Background.Color='" + ls_color + "'")
	Case 5
		tab_1.tabpage_5.dw_report2.Modify("t_1.Background.Color='" + ls_color + "'")
		//tab_1.tabpage_5.dw_report2.Modify("t_2.Background.Color='" + ls_color + "'")
	Case 6
		tab_1.tabpage_6.dw_report3.Modify("t_1.Background.Color='" + ls_color + "'")
End Choose
end subroutine

public function string wf_string (decimal ad_data);string ls_data, ls_return
int li_pos

ls_data = string(ad_data)
li_pos = pos(ls_data,',')
if li_pos > 0 then
	ls_return = Replace(ls_data, li_pos,1, ".")
else
	ls_return = ls_data
end if
return ls_return
end function

on u_salesreport.create
int iCurrent
call super::create
this.st_graph=create st_graph
this.ddplb_graph=create ddplb_graph
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_graph
this.Control[iCurrent+2]=this.ddplb_graph
end on

on u_salesreport.destroy
call super::destroy
destroy(this.st_graph)
destroy(this.ddplb_graph)
end on

event constructor;call super::constructor;iuo_report = this

IF tab_1.tabpage_1.dw_filter.RowCount() < 1 Then
	tab_1.tabpage_1.dw_filter.InsertRow(1)
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_from", DateTime("2013-01-01"))
	tab_1.tabpage_1.dw_filter.SetItem(1, "Date_to", DateTime("2013-12-31"))
End IF

IF tab_1.tabpage_2.dw_subfilter.RowCount() < 1 Then
	tab_1.tabpage_2.dw_subfilter.InsertRow(1)	
End IF

IF tab_1.tabpage_4.dw_gcfilter.RowCount() < 1 Then
	tab_1.tabpage_4.dw_gcfilter.InsertRow(1)	
End IF

IF tab_1.tabpage_5.dw_gcfilter2.RowCount() < 1 Then
	tab_1.tabpage_5.dw_gcfilter2.InsertRow(1)	
End IF

IF tab_1.tabpage_6.dw_gcfilter3.RowCount() < 1 Then
	tab_1.tabpage_6.dw_gcfilter3.InsertRow(1)
	tab_1.tabpage_6.dw_gcfilter3.SetItem(1, "Date_from", DateTime("2013-01-01"))
	tab_1.tabpage_6.dw_gcfilter3.SetItem(1, "Date_to", DateTime("2013-12-31"))
End IF
end event

type tab_1 from u_tab_base`tab_1 within u_salesreport
integer x = 0
integer width = 4133
integer height = 2708
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event tab_1::selectionchanged;call super::selectionchanged;
Choose Case newindex
	Case 1
		st_graph.visible = False
		ddplb_graph.visible = False
		iuo_currentdw = tab_1.tabpage_1.dw_filter
	Case 2
		st_graph.visible = True
		ddplb_graph.visible = True
		iuo_currentdw = tab_1.tabpage_2.dw_subfilter	
	Case 4
		st_graph.visible = False
		ddplb_graph.visible = False
		iuo_currentdw = tab_1.tabpage_5.dw_gcfilter2
		of_set_backcolor(4)
	Case 5
		st_graph.visible = False
		ddplb_graph.visible = False
		iuo_currentdw = tab_1.tabpage_6.dw_gcfilter3
		of_set_backcolor(5)
	Case 6
		st_graph.visible = False
		ddplb_graph.visible = False
End Choose
end event

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3973
integer height = 2676
string text = " Category Statistics "
dw_filter dw_filter
cb_filter cb_filter
htb_1 htb_1
cbx_pie cbx_pie
cbx_salesroom cbx_salesroom
cbx_saleqty cbx_saleqty
st_1 st_1
end type

on tabpage_1.create
this.dw_filter=create dw_filter
this.cb_filter=create cb_filter
this.htb_1=create htb_1
this.cbx_pie=create cbx_pie
this.cbx_salesroom=create cbx_salesroom
this.cbx_saleqty=create cbx_saleqty
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_filter
this.Control[iCurrent+3]=this.htb_1
this.Control[iCurrent+4]=this.cbx_pie
this.Control[iCurrent+5]=this.cbx_salesroom
this.Control[iCurrent+6]=this.cbx_saleqty
this.Control[iCurrent+7]=this.st_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_filter)
destroy(this.htb_1)
destroy(this.cbx_pie)
destroy(this.cbx_salesroom)
destroy(this.cbx_saleqty)
destroy(this.st_1)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 564
integer width = 3845
integer height = 2056
string dataobject = "d_categorysalesreport_m"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_browser::getfocus;//
end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3973
integer height = 2676
string text = " Subcategory Statistics "
dw_subfilter dw_subfilter
cb_subfilter cb_subfilter
end type

on tabpage_2.create
this.dw_subfilter=create dw_subfilter
this.cb_subfilter=create cb_subfilter
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_subfilter
this.Control[iCurrent+2]=this.cb_subfilter
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_subfilter)
destroy(this.cb_subfilter)
end on

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 404
integer width = 3845
integer height = 2224
string dataobject = "d_subcategorysalesreport_m"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_master::getfocus;//
end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
boolean visible = false
end type

type dw_filter from u_dw within tabpage_1
integer x = 55
integer y = 396
integer width = 1691
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_salesorder_select"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_filter from u_button within tabpage_1
integer x = 1778
integer y = 404
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return

Parent.SetRedraw(False)

iuo_report.Event ue_categoryreport_preview()

of_set_backcolor(1)

Parent.Post SetRedraw(True)

end event

type htb_1 from htrackbar within tabpage_1
integer x = 2578
integer y = 408
integer width = 1358
integer height = 124
boolean bringtotop = true
integer maxposition = 100
integer position = 50
integer tickfrequency = 10
integer pagesize = 50
integer linesize = 50
end type

event moved;of_zoom(scrollpos)
end event

type cbx_pie from checkbox within tabpage_1
integer x = 64
integer y = 56
integer width = 2807
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Show sales percentages of different categories."
boolean checked = true
end type

type cbx_salesroom from checkbox within tabpage_1
integer x = 64
integer y = 164
integer width = 2807
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Compare the sales amount of the selected period and the previous period by category."
boolean checked = true
end type

type cbx_saleqty from checkbox within tabpage_1
integer x = 64
integer y = 272
integer width = 2807
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Compare the sales volumes of the selected period and the previous period by category."
end type

type st_1 from statictext within tabpage_1
integer x = 2350
integer y = 408
integer width = 238
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Zoom:"
boolean focusrectangle = false
end type

type dw_subfilter from u_dw within tabpage_2
integer x = 64
integer y = 48
integer width = 3419
integer height = 128
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_subreport_filter"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;DatawindowChild ldwc_sub
Long ll_null

IF row < 1 Then Return

SetNull(ll_null)

Choose Case dwo.name
	Case "categoryid"
		This.SetItem(row,"subcategoryid", ll_null)
		This.GetChild("subcategoryid", ldwc_sub)
		ldwc_sub.SetFilter("productcategoryid = " + data)
		ldwc_sub.Filter()
		ldwc_sub.SetFilter("")
End Choose

end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type cb_subfilter from u_button within tabpage_2
integer x = 3529
integer y = 60
integer width = 366
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return

Parent.SetRedraw(False)

iuo_report.Event ue_subcategoryreport_preview()

if adwc_proc.rowcount() > 0 then
	of_set_backcolor(2)
end if


Parent.Post SetRedraw(True)

end event

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 142
integer y = 16
integer width = 3973
integer height = 2676
long backcolor = 67108864
string text = "Google Charts"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_report dw_report
wb_2 wb_2
st_2 st_2
ddplb_gc_graph ddplb_gc_graph
cb_gcfilter cb_gcfilter
dw_gcfilter dw_gcfilter
end type

on tabpage_4.create
this.dw_report=create dw_report
this.wb_2=create wb_2
this.st_2=create st_2
this.ddplb_gc_graph=create ddplb_gc_graph
this.cb_gcfilter=create cb_gcfilter
this.dw_gcfilter=create dw_gcfilter
this.Control[]={this.dw_report,&
this.wb_2,&
this.st_2,&
this.ddplb_gc_graph,&
this.cb_gcfilter,&
this.dw_gcfilter}
end on

on tabpage_4.destroy
destroy(this.dw_report)
destroy(this.wb_2)
destroy(this.st_2)
destroy(this.ddplb_gc_graph)
destroy(this.cb_gcfilter)
destroy(this.dw_gcfilter)
end on

type dw_report from u_dw within tabpage_4
integer x = 64
integer y = 412
integer width = 3845
integer height = 632
integer taborder = 20
string dataobject = "d_subcategorysalesreport_gc"
end type

type wb_2 from webbrowser within tabpage_4
integer x = 64
integer y = 1124
integer width = 3845
integer height = 1492
end type

type st_2 from statictext within tabpage_4
integer x = 73
integer y = 244
integer width = 325
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Graph Style:"
boolean focusrectangle = false
end type

type ddplb_gc_graph from dropdownpicturelistbox within tabpage_4
integer x = 411
integer y = 236
integer width = 782
integer height = 352
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Col","Pie"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2}
string picturename[] = {"Control Graph_2!","image\Pie.PNG"}
long picturemaskcolor = 536870912
end type

event selectionchanged;of_selectgraph_gc(index)
end event

type cb_gcfilter from u_button within tabpage_4
integer x = 3529
integer y = 60
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;//
//IF of_data_verify() = -1 Then Return
//
//Parent.SetRedraw(False)
//
//iuo_report.Event ue_subcategoryreport_preview_gc()
//
////of_set_backcolor()
//
//
//String ls_directory
//If Len(is_file_pie) <= 0  Then
//	ls_directory = GetCurrentDirectory( )	
//	is_file_column = ls_directory + '\column.html'
//	is_file_pie = ls_directory + '\pie.html'
//End If
//wf_create_local_file()
//
////If cbx_2.Checked Then
////	ddplb_graph_gc.Event SelectionChanged(ii_cur_index)
////End If
//
//of_retrieve_webbrowse()
//
//Parent.Post SetRedraw(True)
//
end event

type dw_gcfilter from u_dw within tabpage_4
integer x = 64
integer y = 48
integer width = 3419
integer height = 128
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_subreport_filter"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;DatawindowChild ldwc_sub
Long ll_null

IF row < 1 Then Return

SetNull(ll_null)

Choose Case dwo.name
	Case "categoryid"
		This.SetItem(row,"subcategoryid", ll_null)
		This.GetChild("subcategoryid", ldwc_sub)
		ldwc_sub.SetFilter("productcategoryid = " + data)
		ldwc_sub.Filter()
		ldwc_sub.SetFilter("")
End Choose

end event

type tabpage_5 from userobject within tab_1
integer x = 142
integer y = 16
integer width = 3973
integer height = 2676
long backcolor = 67108864
string text = "Google Charts 1"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
wb_3 wb_3
dw_report2 dw_report2
ddplb_graph_gc2 ddplb_graph_gc2
st_4 st_4
cb_gcfilter2 cb_gcfilter2
dw_gcfilter2 dw_gcfilter2
end type

on tabpage_5.create
this.wb_3=create wb_3
this.dw_report2=create dw_report2
this.ddplb_graph_gc2=create ddplb_graph_gc2
this.st_4=create st_4
this.cb_gcfilter2=create cb_gcfilter2
this.dw_gcfilter2=create dw_gcfilter2
this.Control[]={this.wb_3,&
this.dw_report2,&
this.ddplb_graph_gc2,&
this.st_4,&
this.cb_gcfilter2,&
this.dw_gcfilter2}
end on

on tabpage_5.destroy
destroy(this.wb_3)
destroy(this.dw_report2)
destroy(this.ddplb_graph_gc2)
destroy(this.st_4)
destroy(this.cb_gcfilter2)
destroy(this.dw_gcfilter2)
end on

type wb_3 from webbrowser within tabpage_5
integer x = 64
integer y = 1060
integer width = 3845
integer height = 1564
end type

type dw_report2 from u_dw within tabpage_5
integer x = 64
integer y = 224
integer width = 3845
integer height = 768
integer taborder = 30
string dataobject = "d_subcategorysalesreport_gc"
boolean vscrollbar = true
end type

type ddplb_graph_gc2 from dropdownpicturelistbox within tabpage_5
integer x = 2862
integer y = 64
integer width = 558
integer height = 352
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Col","Line"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2}
string picturename[] = {"Control Graph_2!","image\Line.PNG"}
long picturemaskcolor = 536870912
end type

event selectionchanged;of_selectgraph_gc2(index)
end event

type st_4 from statictext within tabpage_5
integer x = 2523
integer y = 72
integer width = 325
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Graph Style:"
boolean focusrectangle = false
end type

type cb_gcfilter2 from u_button within tabpage_5
integer x = 3529
integer y = 60
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return
SetPointer(HourGlass!)
Parent.SetRedraw(False)

iuo_report.Event ue_subcategoryreport_preview_gc2()

//of_set_backcolor()


String ls_directory
If Len(is_file_line) <= 0  Then
	ls_directory = GetCurrentDirectory( )	
	is_file_column1 = ls_directory + '\column1.html'
	is_file_line = ls_directory + '\line.html'
End If
wf_create_local_file2()

tab_1.tabpage_5.ddplb_graph_gc2.Event SelectionChanged(ii_cur_index2)
SetPointer(Arrow!)
Parent.Post SetRedraw(True)

end event

type dw_gcfilter2 from u_dw within tabpage_5
integer x = 64
integer y = 48
integer width = 2437
integer height = 128
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_subreport_filter_gc"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;DatawindowChild ldwc_sub
Long ll_null

IF row < 1 Then Return

SetNull(ll_null)

Choose Case dwo.name
	Case "categoryid"
		This.SetItem(row,"subcategoryid", ll_null)
		This.GetChild("subcategoryid", ldwc_sub)
		ldwc_sub.SetFilter("productcategoryid = " + data)
		ldwc_sub.Filter()
		ldwc_sub.SetFilter("")
End Choose

end event

type tabpage_6 from userobject within tab_1
integer x = 142
integer y = 16
integer width = 3973
integer height = 2676
long backcolor = 67108864
string text = "Google Charts 2"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
wb_1 wb_1
dw_report3 dw_report3
cb_1 cb_1
dw_gcfilter3 dw_gcfilter3
end type

on tabpage_6.create
this.wb_1=create wb_1
this.dw_report3=create dw_report3
this.cb_1=create cb_1
this.dw_gcfilter3=create dw_gcfilter3
this.Control[]={this.wb_1,&
this.dw_report3,&
this.cb_1,&
this.dw_gcfilter3}
end on

on tabpage_6.destroy
destroy(this.wb_1)
destroy(this.dw_report3)
destroy(this.cb_1)
destroy(this.dw_gcfilter3)
end on

type wb_1 from webbrowser within tabpage_6
integer x = 64
integer y = 1056
integer width = 3845
integer height = 1568
end type

type dw_report3 from u_dw within tabpage_6
integer x = 64
integer y = 224
integer width = 3845
integer height = 772
integer taborder = 40
string dataobject = "d_categorysalesreport_gc"
boolean vscrollbar = true
end type

type cb_1 from u_button within tabpage_6
integer x = 1810
integer y = 56
integer width = 366
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;call super::clicked;
IF of_data_verify() = -1 Then Return
SetPointer(HourGlass!)
Parent.SetRedraw(False)

iuo_report.Event ue_categoryreport_preview_gc()

of_set_backcolor(3)


String ls_directory
If Len(is_file_bubble) <= 0  Then
	ls_directory = GetCurrentDirectory( )	
	is_file_bubble = ls_directory + '\bubble.html'
End If
wf_create_bubble_data()
tab_1.tabpage_6.wb_1.Navigate(is_file_bubble)

SetPointer(Arrow!)
Parent.Post SetRedraw(True)



end event

type dw_gcfilter3 from u_dw within tabpage_6
integer x = 64
integer y = 48
integer width = 1691
integer height = 120
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_salesorder_select"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_graph from statictext within u_salesreport
boolean visible = false
integer x = 215
integer y = 260
integer width = 325
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Graph Style:"
boolean focusrectangle = false
end type

type ddplb_graph from dropdownpicturelistbox within u_salesreport
boolean visible = false
integer x = 549
integer y = 256
integer width = 782
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Col","Col3DObj","Area","Bar","Line"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2,3,4,5}
string picturename[] = {"Control Graph_2!","Graph!","image\Area.PNG","image\Bar.PNG","image\Line.PNG"}
long picturemaskcolor = 536870912
end type

event selectionchanged;ii_index = index
If tab_1.tabpage_2.dw_master.RowCount() <= 0 Then
	Return 
End If
of_selectgraph(index)


end event

