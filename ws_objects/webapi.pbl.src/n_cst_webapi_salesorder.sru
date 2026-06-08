$PBExportHeader$n_cst_webapi_salesorder.sru
forward
global type n_cst_webapi_salesorder from n_cst_webapi_base
end type
end forward

global type n_cst_webapi_salesorder from n_cst_webapi_base autoinstantiate
end type

type variables

end variables

forward prototypes
public function integer of_retrievedddw (long al_customerid, ref datawindowchild adwc_billtoaddressid, ref datawindowchild adwc_shiptoaddressid, ref datawindowchild adwc_creditcardid)
public function integer of_retrievesaleorderdetail (long al_salesorderdetailid, long al_customerid, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail)
public function integer of_retrievesalesorderlist (long al_customerid, datetime adt_date_from, datetime adt_date_to, ref u_dw adw_browser, ref u_dw adw_master)
public function integer of_savechanges (ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_browser)
public function integer of_deletesalesorderbykey (string as_dwname, long al_salesorderid, long al_salesorderdetailid)
end prototypes

public function integer of_retrievedddw (long al_customerid, ref datawindowchild adwc_billtoaddressid, ref datawindowchild adwc_shiptoaddressid, ref datawindowchild adwc_creditcardid);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url

ls_url = of_get_url("RetrieveDropdownModel")
ls_url = ls_url + "/Customer/" + String(al_customerid)

//Send Request and get a JsonPackage
lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

ls_json = ljs_pak.GetValue("DddwAddress")

adwc_billtoaddressid.ImportJsonByKey(ls_json)
adwc_shiptoaddressid.ImportJsonByKey(ls_json)

ls_json = ljs_pak.GetValue("DddwCreditcard")
adwc_creditcardid.ImportJsonByKey(ls_json)

Return 1
end function

public function integer of_retrievesaleorderdetail (long al_salesorderdetailid, long al_customerid, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
jsonpackage ljs_pak
DataWindowChild ldwc_child
Integer li_ret
String ls_json
String ls_url

//Request data
ls_url = of_get_url("RetrieveSaleOrderDetail")
ls_url = ls_url + "/" + String(al_salesorderdetailid) + "/" + String(al_customerid)

lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

//Import JSON
adw_detail.SetRedraw(False)
ls_json = ljs_pak.GetValue("SalesOrderDetail")
adw_detail.reset()
adw_detail.ImportJsonByKey(ls_json)
adw_detail.ResetUpdate()
adw_detail.SetRedraw(True)

ls_json = ljs_pak.GetValue("DddwAddress")
adw_master.of_importjson_dddw("billtoaddressid", ls_json)
adw_master.of_importjson_dddw("shiptoaddressid", ls_json)

ls_json = ljs_pak.GetValue("DddwCreditcard")
adw_master.of_importjson_dddw("creditcardid", ls_json)

Return 1
end function

public function integer of_winopen (ref u_dw adw_filter, ref u_dw adw_browser, ref u_dw adw_master, ref u_dw adw_detail);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url

//Retrieve dddw data
ls_url = of_get_url("winopen")
lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

//Customer
ls_json = ljs_pak.GetValue("Customer")
adw_filter.of_importjson_dddw("customer",  ls_json, true) 
adw_browser.of_importjson_dddw("customerid", ls_json)
adw_master.of_importjson_dddw("customerid", ls_json)

//SalesPerson
ls_json = ljs_pak.GetValue("SalesPerson")
adw_browser.of_importjson_dddw("salespersonid", ls_json)
adw_master.of_importjson_dddw("salespersonid", ls_json)

//SalesTerritory
ls_json = ljs_pak.GetValue("SalesTerritory")
adw_browser.of_importjson_dddw("territoryid", ls_json)
adw_master.of_importjson_dddw("territoryid", ls_json)

//ShipMethod
ls_json = ljs_pak.GetValue("ShipMethod")
adw_browser.of_importjson_dddw("shipmethodid", ls_json)
adw_master.of_importjson_dddw("shipmethodid", ls_json)

//OrderProduct
ls_json = ljs_pak.GetValue("OrderProduct")
adw_detail.of_importjson_dddw("productid", ls_json )

Return 1
end function

public function integer of_retrievesalesorderlist (long al_customerid, datetime adt_date_from, datetime adt_date_to, ref u_dw adw_browser, ref u_dw adw_master);str_arm lstr_am
jsonpackage ljs_pak
Integer li_ret
String ls_json
String ls_url
String ls_date_from
String ls_date_to

ls_url = of_get_url("RetrieveSaleOrderList")
ls_date_from =  String(adt_date_from, "yyyy-mm-dd")
ls_date_to = String(adt_date_to, "yyyy-mm-dd")
IF Isnull(al_customerid) Then al_customerid = 0

ls_url = ls_url + "/" + String(al_customerid) + "/" + ls_date_from + "/" + ls_date_to
lstr_am.request_type = 'Get'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

ls_json = ljs_pak.GetValue("SalesOrderHeader")

adw_browser.SetRedraw(False)
adw_master.SetRedraw(False)
adw_browser.Reset()
adw_browser.ImportJsonByKey(ls_json)
adw_browser.ResetUpdate()

adw_master.Reset()
adw_master.ImportJsonByKey(ls_json)
adw_master.ResetUpdate()

adw_browser.SetRedraw(True)
adw_master.SetRedraw(True)

Return 1
end function

public function integer of_savechanges (ref u_dw adw_master, ref u_dw adw_detail, ref u_dw adw_browser);Integer li_cnt
Integer li_ret
Integer li_row
String   ls_url
String   ls_json
String   ls_data
str_arm lstr_am
JsonPackage ljs_pak

li_cnt = 0
IF adw_master.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_master
	lstr_am.s_arm[li_cnt] = "SaleOrderHeader"
End IF

IF adw_detail.ModifiedCount() > 0 Then
	li_cnt +=1
	lstr_am.dw_arm[li_cnt] = adw_detail
	lstr_am.s_arm[li_cnt] = "SaleOrderDetail"
End IF

Choose Case li_cnt
	Case 1
		ls_url = of_get_url("SaveChanges")		
	Case 2
		ls_url = of_get_url("SaveSalesOrderAndDetail")			
End Choose

lstr_am.request_type = 'Post'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

li_ret = of_get_servicestatus(ljs_pak, "Save")

adw_master.SetRedraw(False)
adw_detail.SetRedraw(False)
IF adw_master.GetItemStatus(adw_master.GetRow(), 0, Primary!) = NewModified! Then		
	ls_json = ljs_pak.GetValue("SalesOrderHeader")
	li_row = adw_master.GetRow()
	adw_master.DeleteRow(li_row)
	
	If gi_service_type = 3 Then
		adw_master.ImportRowFromJson(ls_json, 1)
	Else		
		adw_master.ImportJsonByKey(ls_json)
	End If
End IF

IF li_cnt = 2 OR lstr_am.s_arm[1] = "SaleOrderDetail" Then
	adw_detail.ReSet()
	ls_json = ljs_pak.GetValue("SalesOrderHeader.SalesOrderDetail")
	adw_detail.ImportJsonByKey(ls_json)
End IF

adw_master.SetRedraw(True)
adw_detail.SetRedraw(True)

adw_master.ResetUpdate()
adw_detail.ResetUpdate()

Destroy(ljs_pak)

Return 1
end function

public function integer of_deletesalesorderbykey (string as_dwname, long al_salesorderid, long al_salesorderdetailid);str_arm lstr_am
JsonPackage ljs_pak
String ls_url
Integer li_ret

lstr_am.s_arm[1] = as_dwname
lstr_am.s_arm[2] = String(al_salesorderid)
lstr_am.s_arm[3] = String(al_salesorderdetailid)

ls_url = of_get_url("DeleteSalesOrderByKey")
lstr_am.request_type = 'Delete'
li_ret = inv_restclient.of_execute_func(ls_url, lstr_am, ljs_pak)
IF li_ret = -1 Then Return -1

li_ret = of_get_servicestatus(ljs_pak, "Delete")

Destroy(ljs_pak)
			
Return li_ret
end function

on n_cst_webapi_salesorder.create
call super::create
end on

on n_cst_webapi_salesorder.destroy
call super::destroy
end on

event constructor;call super::constructor;This.is_controllername = "salesorder"
end event

