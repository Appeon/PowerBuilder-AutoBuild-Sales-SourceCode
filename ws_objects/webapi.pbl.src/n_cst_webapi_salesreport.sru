$PBExportHeader$n_cst_webapi_salesreport.sru
forward
global type n_cst_webapi_salesreport from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_salesreport from n_cst_webapi_base autoinstantiate
end type

type variables
String is_path
n_cst_httpclient inv_client
end variables

forward prototypes
public function integer of_retrieve_compress (ref u_dw adw_browse, string as_compress, string as_person_type)
public function integer of_subcategoryreport (ref u_dw adw_subcategoryreport, long al_subcategoryid, string as_year, string as_annual)
public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_gcfilter, ref u_dw adw_gcfilter2)
public function integer of_subcategoryreport_gc (ref u_dw adw_subcategoryreport, long al_subcategoryid, string as_year, string as_annual)
public function integer of_subcategoryreport_gc2 (ref u_dw adw_subcategoryreport, long al_subcategoryid[], string as_year, string as_annual)
public function integer of_categoryreport_gc (ref u_dw adw_categoryreport, string as_from, string as_to)
public function integer of_categoryreport (ref u_dw adw_categoryreport, string as_from, string as_to)
end prototypes

public function integer of_retrieve_compress (ref u_dw adw_browse, string as_compress, string as_person_type);String ls_url

ls_url = of_get_url("RetrievePerson_Compress")

IF Isnull(as_person_type) Or as_person_type = "" Then
	as_person_type = "All"
End IF
ls_url = ls_url + "/" + as_person_type

inv_restclient.of_compressrequest(ls_url, as_compress, adw_browse)
return 1
end function

public function integer of_subcategoryreport (ref u_dw adw_subcategoryreport, long al_subcategoryid, string as_year, string as_annual);String ls_json
String   ls_url
String ls_subname
String ls_title
String ls_yearfirst 
String ls_month[]
String ls_firstmonths[6] = {"January", "February", "March", "April", "May", "June"}
String ls_lastmonths[6] = {"July", "August", "September", "October", "November", "December"}
Integer li_row
Integer li_cnt
Integer li_year
Integer li_add
Integer li_ret
Long    ll_totalsalesqty
Decimal ldc_totalsaleroom
str_arm lstr_am
jsonpackage ljs_pak
DataWindowChild ldwc_child
DataWindowChild ldwc_list

IF as_annual = "first" Then
	ls_yearfirst = "First Half Year"
	ls_month = ls_firstmonths
Else
	ls_yearfirst = "Second Half Year"
	ls_month = ls_lastmonths
End IF

ls_url = of_get_url("SalesReportByMonth")
ls_url = ls_url + "/" + String(al_subcategoryid) + "/" + as_year + "/" + as_annual
lstr_am.request_type = 'Get'

li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

//adw_subcategoryreport.SetRedraw(False)
IF adw_subcategoryreport.rowcount() < 1 Then
	adw_subcategoryreport.InsertRow(1)
End IF

adw_subcategoryreport.GetChild("dw_subcategorysalesreport", ldwc_child)
ldwc_child.reset()
ls_json = ljs_pak.getvalue("SalesReport")

ldwc_child.importjsonbykey(ls_json)
ls_title = 'Sales Report of ' + as_year 
ldwc_child.Modify("t_title.text = '" + ls_title + "'")

IF ldwc_child.RowCount() < 1 Then Return -1
adw_subcategoryreport.GetChild("dw_subcategorysalesreport_graph", ldwc_list)
ldwc_list.Reset()
ls_subname = ldwc_child.GetItemString(1, "name")
ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth1")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth1")
ldwc_child.Modify("salesroommonth1_t.text = '"+ls_month[1]+"'")
li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 1)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[1])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)

ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth2")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth2")
ldwc_child.Modify("salesroommonth2_t.text = '"+ls_month[2]+"'")
li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 2)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[2])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)

ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth3")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth3")
ldwc_child.Modify("salesroommonth3_t.text = '"+ls_month[3]+"'")
li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 3)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[3])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)

ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth4")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth4")
ldwc_child.Modify("salesroommonth4_t.text = '"+ls_month[4]+"'")
li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 4)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[4])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)

ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth5")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth5")
ldwc_child.Modify("salesroommonth5_t.text = '"+ls_month[5]+"'")
li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 5)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[5])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)

ll_totalsalesqty = ldwc_child.GetItemNumber(1, "salesqtymonth6")
ldc_totalsaleroom = ldwc_child.GetItemDecimal(1, "salesroommonth6")
ldwc_child.Modify("salesroommonth6_t.text = '"+ls_month[6]+"'")
ldwc_list.Modify("gr_1.category.label='(Total sales per month)'")
ls_title =  'Total Sales of '  + ls_yearfirst
ldwc_list.Modify("gr_1.title ='" + ls_title + "'")

li_row = ldwc_list.Insertrow(0)
ldwc_list.SetItem(li_row, "id", 6)
ldwc_list.SetItem(li_row, "name", ls_subname)
ldwc_list.SetItem(li_row, "month", ls_month[6])
ldwc_list.SetItem(li_row, "totalsalesqty", ll_totalsalesqty)
ldwc_list.SetItem(li_row, "totalsaleroom", ldc_totalsaleroom)
ldwc_list.SetSort("id ASC")
ldwc_list.Sort()

//Top 5 Product
adw_subcategoryreport.GetChild("dw_productsalesreport", ldwc_child)
ldwc_child.reset()
ls_json = ljs_pak.getvalue("ProductReport")
ldwc_child.importjsonbykey(ls_json)
//adw_subcategoryreport.SetRedraw(True)

Return 1
end function

public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_gcfilter, ref u_dw adw_gcfilter2);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url

//Retrieve dddw data
ls_url = of_get_url("winopen")
lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

//Category
ls_json = ljs_pak.GetValue("Category")
adw_filter.of_importjson_dddw("categoryid", ls_json)
adw_gcfilter.of_importjson_dddw("categoryid", ls_json)
adw_gcfilter2.of_importjson_dddw("categoryid", ls_json)

//SubCategory
ls_json = ljs_pak.GetValue("SubCategory")
adw_filter.of_importjson_dddw("subcategoryid", ls_json)
adw_gcfilter.of_importjson_dddw("subcategoryid", ls_json)
adw_gcfilter2.of_importjson_dddw("subcategoryid", ls_json)

Return 1
end function

public function integer of_subcategoryreport_gc (ref u_dw adw_subcategoryreport, long al_subcategoryid, string as_year, string as_annual);String ls_json
String   ls_url
String ls_subname
String ls_title
String ls_yearfirst 
String ls_month[]
String ls_firstmonths[6] = {"January", "February", "March", "April", "May", "June"}
String ls_lastmonths[6] = {"July", "August", "September", "October", "November", "December"}
Integer li_row
Integer li_cnt
Integer li_year
Integer li_add
Integer li_ret
Long    ll_totalsalesqty
Decimal ldc_totalsaleroom
str_arm lstr_am
jsonpackage ljs_pak


IF as_annual = "first" Then
	ls_yearfirst = "First Half Year"
	ls_month = ls_firstmonths
Else
	ls_yearfirst = "Second Half Year"
	ls_month = ls_lastmonths
End IF

ls_url = of_get_url("SalesReportByMonth")
ls_url = ls_url + "/" + String(al_subcategoryid) + "/" + as_year + "/" + as_annual
lstr_am.request_type = 'Get'

li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

adw_subcategoryreport.reset()
ls_json = ljs_pak.getvalue("SalesReport")

adw_subcategoryreport.importjsonbykey(ls_json)
ls_title = 'Sales Report of ' + as_year 
adw_subcategoryreport.Modify("t_title.text = '" + ls_title + "'")

adw_subcategoryreport.Modify("salesroommonth1_t.text = '"+ls_month[1]+"'")
adw_subcategoryreport.Modify("salesroommonth2_t.text = '"+ls_month[2]+"'")
adw_subcategoryreport.Modify("salesroommonth3_t.text = '"+ls_month[3]+"'")
adw_subcategoryreport.Modify("salesroommonth4_t.text = '"+ls_month[4]+"'")
adw_subcategoryreport.Modify("salesroommonth5_t.text = '"+ls_month[5]+"'")
adw_subcategoryreport.Modify("salesroommonth6_t.text = '"+ls_month[6]+"'")

Return 1
end function

public function integer of_subcategoryreport_gc2 (ref u_dw adw_subcategoryreport, long al_subcategoryid[], string as_year, string as_annual);String ls_json
String   ls_url
String ls_subname
String ls_title
String ls_yearfirst 
String ls_month[]
String ls_firstmonths[6] = {"January", "February", "March", "April", "May", "June"}
String ls_lastmonths[6] = {"July", "August", "September", "October", "November", "December"}
Integer li_row
Integer li_cnt
Integer li_year
Integer li_add
Integer li_ret
Long    ll_totalsalesqty
Decimal ldc_totalsaleroom
str_arm lstr_am
jsonpackage ljs_pak
Long ll_subcategoryid
Long i

IF as_annual = "first" Then
	ls_yearfirst = "First Half Year"
	ls_month = ls_firstmonths
Else
	ls_yearfirst = "Second Half Year"
	ls_month = ls_lastmonths
End IF
adw_subcategoryreport.reset()
inv_restclient.ib_showmsg404 = False
For i = 1 to UpperBound(al_subcategoryid)
	ll_subcategoryid = al_subcategoryid[i]
	ls_url = of_get_url("SalesReportByMonth")
	ls_url = ls_url + "/" + String(ll_subcategoryid) + "/" + as_year + "/" + as_annual
	lstr_am.request_type = 'Get'
	
	li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
	IF li_ret = -1 Then Continue
	
	
	ls_json = ljs_pak.getvalue("SalesReport")
	
	adw_subcategoryreport.importjsonbykey(ls_json)
Next
inv_restclient.ib_showmsg404 = True
ls_title = 'Sales Report of ' + as_year 
adw_subcategoryreport.Modify("t_title.text = '" + ls_title + "'")

adw_subcategoryreport.Modify("salesroommonth1_t.text = '"+ls_month[1]+"'")
adw_subcategoryreport.Modify("salesroommonth2_t.text = '"+ls_month[2]+"'")
adw_subcategoryreport.Modify("salesroommonth3_t.text = '"+ls_month[3]+"'")
adw_subcategoryreport.Modify("salesroommonth4_t.text = '"+ls_month[4]+"'")
adw_subcategoryreport.Modify("salesroommonth5_t.text = '"+ls_month[5]+"'")
adw_subcategoryreport.Modify("salesroommonth6_t.text = '"+ls_month[6]+"'")

Return 1
end function

public function integer of_categoryreport_gc (ref u_dw adw_categoryreport, string as_from, string as_to);String ls_json
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
str_arm lstr_am
jsonpackage ljs_pak

DataStore lds_data

lds_data = Create DataStore
lds_data.dataobject = "d_categorysalesreport_graph_saleroom"

ls_url = of_get_url("CategorySalesReport")
ls_url = ls_url + "/" + as_from + "/" + as_to
lstr_am.request_type = 'Get'

li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

ls_json = ljs_pak.getvalue("Category.SalesReport")
lds_data.importjson(ls_json)
li_row = lds_data.RowCount( )

adw_categoryreport.reset()
adw_categoryreport.Modify("t_now.text ='" + Left(as_from, 4)+ "'")

For li_cnt = 1 To li_row
	li_add = adw_categoryreport.Insertrow(0)
	ls_categoryname = lds_data.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = lds_data.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = lds_data.GetItemDecimal(li_cnt, "totalsaleroom")
	adw_categoryreport.SetItem(li_add, "productcategoryname", ls_categoryname)
	adw_categoryreport.SetItem(li_add, "totalsalesqty", ll_totalsalesqty)
	adw_categoryreport.SetItem(li_add, "totalsaleroom", ldc_totalsaleroom)
Next

ls_json = ljs_pak.getvalue("Category.LastYearSalesReport")
lds_data.importjsonbykey(ls_json)

li_year = Integer(Left(as_from, 4)) -1
adw_categoryreport.Modify("t_laster.text = '" + String(li_year) +"'")
ls_title = 'Sales Report ('+ Left(as_from, 4) + ' VS. ' + String(li_year) + ')'
adw_categoryreport.Modify("t_title.text = '" + ls_title +"'")


For li_cnt = li_row + 1  To lds_data.Rowcount()
	ls_categoryname = lds_data.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = lds_data.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = lds_data.GetItemDecimal(li_cnt, "totalsaleroom")
	
	li_add = adw_categoryreport.Find("productcategoryname = '" + ls_categoryname + "'", 1, adw_categoryreport.rowcount())
	
	IF li_add > 0 Then
		adw_categoryreport.SetItem(li_add, "lasttotalsalesqty", ll_totalsalesqty)
		adw_categoryreport.SetItem(li_add, "lasttotalsaleroom", ldc_totalsaleroom)
	End IF
	
Next
//adw_categoryreport.SetRedraw(True)

Return 1
end function

public function integer of_categoryreport (ref u_dw adw_categoryreport, string as_from, string as_to);String ls_json
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
str_arm lstr_am
jsonpackage ljs_pak
DataWindowChild ldwc_child
DataWindowChild ldwc_qty
DataWindowChild ldwc_list

ls_url = of_get_url("CategorySalesReport")
ls_url = ls_url + "/" + as_from + "/" + as_to
lstr_am.request_type = 'Get'

li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

//adw_categoryreport.SetRedraw(False)
IF adw_categoryreport.rowcount() < 1 Then
	adw_categoryreport.InsertRow(1)
End IF

adw_categoryreport.GetChild("dw_catereport", ldwc_child)
ldwc_child.reset()
ls_json = ljs_pak.getvalue("Category.SalesReport")
ldwc_child.importjsonbykey(ls_json)

adw_categoryreport.GetChild("dw_catereport_pie", ldwc_child)
ldwc_child.reset()
ldwc_child.importjsonbykey(ls_json)

adw_categoryreport.GetChild("dw_compare", ldwc_child)
ldwc_child.reset()
ldwc_child.importjsonbykey(ls_json)

adw_categoryreport.GetChild("dw_qty", ldwc_qty)
ldwc_qty.reset()
ldwc_qty.importjsonbykey(ls_json)

li_row = ldwc_child.Rowcount()

adw_categoryreport.GetChild("dw_reportlist", ldwc_list)
ldwc_list.reset()
ldwc_list.Modify("t_now.text ='" + Left(as_from, 4)+ "'")

For li_cnt = 1 To li_row
	ldwc_child.SetItem(li_cnt, "year",  Left(as_from, 4))
	ldwc_qty.SetItem(li_cnt, "year",  Left(as_from, 4))
	li_add = ldwc_list.Insertrow(0)
	ls_categoryname = ldwc_child.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = ldwc_child.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = ldwc_child.GetItemDecimal(li_cnt, "totalsaleroom")
	ldwc_list.SetItem(li_add, "productcategoryname", ls_categoryname)
	ldwc_list.SetItem(li_add, "totalsalesqty", ll_totalsalesqty)
	ldwc_list.SetItem(li_add, "totalsaleroom", ldc_totalsaleroom)
Next

ls_json = ljs_pak.getvalue("Category.LastYearSalesReport")
ldwc_child.importjsonbykey(ls_json)
ldwc_qty.importjsonbykey(ls_json)
li_year = Integer(Left(as_from, 4)) -1
ldwc_list.Modify("t_laster.text = '" + String(li_year) +"'")
ls_title = 'Sales Report ('+ Left(as_from, 4) + ' VS. ' + String(li_year) + ')'
ldwc_list.Modify("t_title.text = '" + ls_title +"'")

ls_title = 'Sales Amount Per Category (' + Left(as_from, 4) + ' VS. ' + String(li_year) + ')'
ldwc_child.Modify("gr_1.title='"+ ls_title + "'")
ldwc_child.Modify("gr_1.category.label='("+Left(as_from, 4) + ' VS. ' + String(li_year)+")'")

ls_title = 'Sales Volume Per Category (' + Left(as_from, 4) + ' VS. ' + String(li_year) + ')'
ldwc_qty.Modify("gr_1.title='"+ ls_title + "'")
ldwc_qty.Modify("gr_1.category.label='("+Left(as_from, 4) + ' VS. ' + String(li_year)+")'")

For li_cnt = li_row + 1  To ldwc_child.Rowcount()
	ldwc_child.SetItem(li_cnt, "year",  String(li_year))
	ldwc_qty.SetItem(li_cnt, "year",  String(li_year))
	ls_categoryname = ldwc_child.GetItemString(li_cnt, "productcategoryname")
	ll_totalsalesqty = ldwc_child.GetItemNumber(li_cnt, "totalsalesqty")
	ldc_totalsaleroom = ldwc_child.GetItemDecimal(li_cnt, "totalsaleroom")
	
	li_add = ldwc_list.Find("productcategoryname = '" + ls_categoryname + "'", 1, ldwc_list.rowcount())
	
	IF li_add > 0 Then
		ldwc_list.SetItem(li_add, "lasttotalsalesqty", ll_totalsalesqty)
		ldwc_list.SetItem(li_add, "lasttotalsaleroom", ldc_totalsaleroom)
	End IF
	
Next
//adw_categoryreport.SetRedraw(True)

Return 1
end function

on n_cst_webapi_salesreport.create
call super::create
end on

on n_cst_webapi_salesreport.destroy
call super::destroy
end on

event constructor;call super::constructor;is_controllername = "OrderReport"

end event

