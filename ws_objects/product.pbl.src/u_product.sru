$PBExportHeader$u_product.sru
forward
global type u_product from u_tab_base
end type
type dw_productlist from u_dw within tabpage_1
end type
type sle_filter from singlelineedit within tabpage_1
end type
type cb_filter from commandbutton within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type uo_search from u_searchbox within tabpage_1
end type
type st_1 from statictext within tabpage_2
end type
type st_cate from statictext within u_product
end type
type dw_cate from u_dw within u_product
end type
type cb_add from u_button within u_product
end type
type cb_del from u_button within u_product
end type
type cb_save from u_button within u_product
end type
end forward

global type u_product from u_tab_base
integer width = 4133
integer height = 2720
long backcolor = 16777215
st_cate st_cate
dw_cate dw_cate
cb_add cb_add
cb_del cb_del
cb_save cb_save
end type
global u_product u_product

type variables
Long il_subcate_id
Long il_cate_id = 1

end variables

forward prototypes
public function integer of_data_verify ()
public function integer of_retrieve (u_dw adw_data, string as_data)
public function integer of_winopen ()
public subroutine of_restore_data ()
public function string of_get_photo (long proid)
end prototypes

public function integer of_data_verify ();//====================================================================
//$<Function>: of_data_verify
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
String ls_colname
String ls_col
Long   ll_data
Integer li_row
Datetime ldt_data
Boolean lb_required

li_row = iuo_currentdw.getrow()
IF li_row < 1 Then Return -1
iuo_currentdw.SetFocus()

lb_required = False
Choose Case iuo_currentdw.ClassName()
	Case "dw_browser" 
		ls_data = iuo_currentdw.GetItemString(li_row, "name")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Name"
			ls_col = 'name'
		End IF
	Case "dw_master"
		ls_data = iuo_currentdw.GetItemString(li_row, "name")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Name"
			ls_col = 'name'
		End IF
		
		ls_data = iuo_currentdw.GetItemString(li_row, "productnumber")
		IF IsNull(ls_data) OR ls_data = "" Then
			lb_required = True
			ls_colname = "Product Number"
			ls_col = 'productnumber'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "safetystocklevel")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Safety Stock Level"
			ls_col = 'safetystocklevel'
		End IF 
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "listprice")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "List Price"
			ls_col = 'listprice'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "reorderpoint")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Reorder Point"
			ls_col = 'reorderpoint'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "standardcost")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Standard Cost"
			ls_col = 'standardcost'
		End IF
		
		ll_data = iuo_currentdw.GetItemNumber(li_row, "daystomanufacture")
		IF IsNull(ll_data) Then
			lb_required = True
			ls_colname = "Daystomanu Facture"
			ls_col = 'daystomanufacture'
		End IF
End Choose


IF lb_required Then
	Messagebox(gs_msg_title, ls_colname +" is required.")
	iuo_currentdw.SetFocus()
	iuo_currentdw.SetColumn(ls_col)
	Return -1
End IF
Return 1
end function

public function integer of_retrieve (u_dw adw_data, string as_data);String ls_photoname
Choose Case adw_data.dataobject
	Case "d_subcategory"
		adw_data.Retrieve(Integer(as_data))
		IF adw_data.RowCount() > 0 Then
			il_subcate_id = adw_data.GetItemNumber(1, "productsubcategoryid")
		End IF	
	Case "d_product"
		adw_data.Retrieve(Long(as_data))
		If adw_data.RowCount() > 0 Then
			adw_data.Post Event RowFocusChanged(1)
		End If
	Case "d_history_price"
		adw_data.Retrieve(Long(as_data))
	Case "d_product_detail"
		adw_data.Retrieve(Long(as_data))
		ls_photoname = of_get_photo(Long(as_data))
		adw_data.modify("p_1.filename='"+ls_photoname+"'")
End Choose

Return 1
end function

public function integer of_winopen ();DataWindowChild ldwc_cate

dw_cate.GetChild("id", ldwc_cate)
IF ldwc_cate.RowCount() > 0 Then
	IF tab_1.tabpage_1.dw_browser.RowCount() > 0 Then
		tab_1.tabpage_1.dw_browser.ScrollToRow(1)
	End IF
	ib_modify = False
	Return 1
Else
	dw_cate.Reset()
	dw_cate.Insertrow(0)

	ldwc_cate.SetTransObject(Sqlca)
	ldwc_cate.Retrieve( )

	dw_cate.SetItem(1, "id", il_cate_id)
End IF

tab_1.tabpage_1.dw_browser.Retrieve( il_cate_id )

Return 1
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
	IF iuo_currentdw.ClassName( ) = "dw_master" THEN
		IF tab_1.tabpage_1.dw_productlist.GetRow() > 0 THEN
			tab_1.tabpage_1.dw_productlist.Event RowFocusChanged( tab_1.tabpage_1.dw_productlist.GetRow())
		END IF
	END IF
ELSEIF ldws_1 = DataModified! THEN
	f_restore_data(iuo_currentdw, ll_row)
END IF

iuo_currentdw.ResetUpdate()

IF  iuo_currentdw.ClassName( ) <> "dw_browser" THEN
	ldws_1 =  tab_1.tabpage_1.dw_browser.GetItemStatus(il_last_row, 0, Primary!) 
	IF ldws_1 = New! Or ldws_1 =  NewModified! THEN
		tab_1.tabpage_1.dw_browser.DeleteRow(il_last_row)
		tab_1.tabpage_1.dw_browser.ResetUpdate()
	ELSEIF ldws_1 = DataModified! THEN
		f_restore_data(tab_1.tabpage_1.dw_browser, il_last_row)
		tab_1.tabpage_1.dw_browser.ResetUpdate()
	END IF
END IF

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

public function string of_get_photo (long proid);String ls_photoname
Integer li_filenum
Blob  lblb_photo
String ls_directory_temp
Long ll_data_length
Integer li_counter
Integer li_loops
Blob lb_data
Blob lb_all_data
Long ll_start

Select Top 1 ProductPhoto.LargePhotoFileName
Into :ls_photoname
From  Production.ProductPhoto, Production.ProductProductPhoto
Where (ProductPhoto.ProductPhotoID = ProductProductPhoto.ProductPhotoID) 
And (ProductProductPhoto.ProductID = :proid) 
Order By ProductPhoto.ModifiedDate desc;
							  

IF len(ls_photoname) > 0 Then
	
	//Write file
	ls_directory_temp = "c:\appeon\"
	IF Not DirectoryExists (ls_directory_temp) Then
		CreateDirectory(ls_directory_temp)
	End IF
	
	ls_photoname = ls_directory_temp +ls_photoname
	
	// Get file data from database
	SELECT Datalength(ProductPhoto.LargePhoto)
	INTO :ll_data_length
	FROM  Production.ProductPhoto, Production.ProductProductPhoto
	Where (ProductPhoto.ProductPhotoID = ProductProductPhoto.ProductPhotoID) 
	And (ProductProductPhoto.ProductID = :proid)
	Order By ProductPhoto.ModifiedDate desc;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN ""
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		Yield()
		SetPointer(HourGlass!)
		
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(ProductPhoto.LargePhoto,:ll_start,8000)
		INTO :lb_data
		FROM  Production.ProductPhoto, Production.ProductProductPhoto
		Where (ProductPhoto.ProductPhotoID = ProductProductPhoto.ProductPhotoID) 
		And (ProductProductPhoto.ProductID = :proid) 
		Order By ProductPhoto.ModifiedDate desc;
	
		lb_all_data += lb_data
	NEXT 
	
	lblb_photo = lb_all_data

	filedelete(ls_photoname)
	li_filenum = fileopen(ls_photoname, StreamMode!, Write!, LockWrite!)	
	FileWriteEx(li_filenum, lblb_photo)
	fileclose(li_filenum)		
Else
	ls_photoname = ""
End IF

Return ls_photoname
end function

on u_product.create
int iCurrent
call super::create
this.st_cate=create st_cate
this.dw_cate=create dw_cate
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_cate
this.Control[iCurrent+2]=this.dw_cate
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_del
this.Control[iCurrent+5]=this.cb_save
end on

on u_product.destroy
call super::destroy
destroy(this.st_cate)
destroy(this.dw_cate)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_save)
end on

event ue_delete;Integer li_row
Integer li_ret
Integer li_status
Long    ll_productid
Int    ll_subcateid
DwItemStatus ldws_status
Long ll_cnt


li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1

Choose Case iuo_currentdw.ClassName()
	Case "dw_browser"		
		
		li_ret = MessageBox("Delete Sub Category", "All the products associated with this sub category will be deleted if you deleting the sub category. Are you sure you want to delete this sub category?" , Question!, yesno!)
		
		IF li_ret = 1 Then			
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				Return 1
			End IF
			iuo_currentdw.Accepttext()
			
			ll_subcateid = iuo_currentdw.GetItemNumber(li_row, "productsubcategoryid")

			
			Select IsNull(Count(*) , 0 )
			INTO :ll_cnt
			FROM Production.ProductProductPhoto 
			WHERE EXISTS (SELECT 1 FROM production.product                              
					  WHERE  Production.ProductProductPhoto.ProductID = production.product.productid 
					AND production.product.productsubcategoryid = :ll_subcateid);
			
			If ll_cnt > 0 Then
				DELETE FROM Production.ProductProductPhoto 
				WHERE EXISTS (SELECT 1 FROM production.product                              
						  WHERE  Production.ProductProductPhoto.ProductID = production.product.productid 
						AND production.product.productsubcategoryid = :ll_subcateid);
				IF Sqlca.Sqlcode <> 0 THEN
					RollBack;
					Return -1
				END IF
			END IF
			

			
			Select IsNull(Count(*) , 0 )
			INTO :ll_cnt
			FROM production.productlistpricehistory ,production.product  
			WHERE production.product.productid= production.productlistpricehistory.productid
			AND  production.product.productsubcategoryid =  :ll_subcateid; 
			If ll_cnt > 0 Then						
				DELETE FROM production.productlistpricehistory 
				WHERE production.productlistpricehistory.productid IN 
				(SELECT production.product.productid 
				FROM production.product
				WHERE production.product.productsubcategoryid =  :ll_subcateid);
				IF Sqlca.Sqlcode <> 0 THEN
					RollBack;
					Return -1
				END IF
			END IF
			
			Select IsNull(Count(*) , 0 )
			INTO :ll_cnt
			FROM production.product  WHERE production.product.productsubcategoryid = :ll_subcateid; 
			
			If ll_cnt > 0 Then
				DELETE  FROM production.product  WHERE production.product.productsubcategoryid = :ll_subcateid;  
				IF Sqlca.Sqlcode <> 0 THEN
					RollBack;
					Return -1
				END IF
			END IF
			
			tab_1.tabpage_1.dw_browser.DeleteRow(li_row)			
			
			IF tab_1.tabpage_1.dw_browser.Update() <> 1 THEN
				RollBack;
				Return -1
			END IF
		End IF
		
	Case "dw_productlist", "dw_master"
		li_ret = MessageBox("Delete Product", "Are you sure you want to delete this product?" , Question!, yesno!)
		IF li_ret = 1 Then
			
			ldws_status = iuo_currentdw.GetItemStatus(li_row, 0 , Primary!)
			IF ldws_status = New! Or ldws_status = NewModified! Then
				ib_Modify = False
				iuo_currentdw.DeleteRow(li_row)
				Return 1
			End IF
			
			ll_productid = iuo_currentdw.GetItemNumber(li_row, "productid")
			DELETE FROM production.productlistpricehistory  WHERE    production.productlistpricehistory.productid = :ll_productid;
			IF Sqlca.Sqlcode <> 0 THEN
				RollBack;
				Return -1
			END IF
			
			

			DELETE FROM Production.ProductProductPhoto WHERE ProductID = :ll_productid;
			IF Sqlca.Sqlcode <> 0 THEN
				RollBack;
				Return -1
			END IF

			iuo_currentdw.DeleteRow(li_row)
			
			IF iuo_currentdw.Update( ) <> 1 THEN
				RollBack;
				Return -1
			END IF
			
			tab_1.tabpage_2.dw_detail.Reset()
			iuo_currentdw.ReSetUpdate()
			
			IF iuo_currentdw.ClassName() = "dw_master" Then
				li_row = tab_1.tabpage_1.dw_productlist.GetRow()
				tab_1.tabpage_1.dw_productlist.DeleteRow(li_row)
				delete from production.product where productid = :ll_productid;

				IF Sqlca.Sqlcode <> 0 THEN
					RollBack;
					Return -1
				END IF
				IF tab_1.tabpage_1.dw_productlist.RowCount() > 1 Then
					tab_1.tabpage_1.dw_productlist.ScrollToRow(tab_1.tabpage_1.dw_productlist.RowCount())
				End IF
			End IF
		End IF
End Choose

ib_Modify = False
w_main.ib_modify = False
Commit;

Return 1


end event

event ue_save;call super::ue_save;Integer li_row
Integer li_prow
Integer li_listrow
Integer li_status
Decimal ldc_price
Long     ll_productid
String   ls_dwname
String   ls_data
Boolean lb_history = False
Long ll_currow
Long ll_pkid

DwItemStatus ldws_1
DwItemStatus ldws_sign
DataWindowChild ldwc_product 

tab_1.tabpage_1.dw_browser.AcceptText()
tab_1.tabpage_2.dw_master.AcceptText()

if tab_1.tabpage_1.dw_browser.Modifiedcount() + tab_1.tabpage_2.dw_master.Modifiedcount() < 1 Then Return 1

li_row = iuo_currentdw.GetRow()
IF li_row < 1 Then Return 1
IF of_data_verify() = -1 Then Return -1

ls_dwname = ClassName(iuo_currentdw)
IF ls_dwname = "dw_master" Then
	ldws_1 = iuo_currentdw.GetItemStatus(li_row, "listprice", Primary!)
	IF ldws_1 = NewModified! OR ldws_1 = DataModified! Then
		//iuo_currentdw.SetItem( li_row, "ModifiedDate", DateTime(Today(), Now()))
		li_prow = tab_1.tabpage_2.dw_detail.InsertRow(1)
		ldc_price = iuo_currentdw.GetItemDecimal(li_row, "listprice")
		ll_productid = iuo_currentdw.GetItemNumber(li_row, "productid")
		
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "productid", ll_productid)	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "listprice", ldc_price)	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "startdate", DateTime(today(),now()))	
		tab_1.tabpage_2.dw_detail.SetItem(li_prow, "modifieddate", DateTime(today(),now()))	
		lb_history = True
	End IF
End IF


li_row = tab_1.tabpage_2.dw_master.GetRow()
li_listrow =  tab_1.tabpage_1.dw_productlist.GetRow()
ldws_sign = tab_1.tabpage_2.dw_master.GetItemStatus(li_row, 0, Primary!)

//Save data
w_main.ib_modify = False
ib_Modify = False

IF iuo_currentdw.update( ) = 1 THEN
      Commit;
ELSE
     IF ldws_1 = NewModified! OR ldws_1 = DataModified! Then
          tab_1.tabpage_2.dw_detail.DeleteRow( li_prow )
     END IF
     RollBack;
	Return -1
END IF
IF ls_dwname =  "dw_master" and ldws_sign = NewModified! Then
	SELECT MAX(IsNull(productid, 0)) INTO :ll_pkid FROM production.product;
	iuo_currentdw.SetItem(li_row, "productid", ll_pkid)
	tab_1.tabpage_2.dw_detail.SetItem(li_prow, "productid", ll_pkid)	
END IF

tab_1.tabpage_2.dw_detail.AcceptText()

IF lb_history THEN
	IF tab_1.tabpage_2.dw_detail.Update( ) <> 1 THEN
		RollBack;
		Return -1
	END IF
END IF


Choose Case ls_dwname
	Case "dw_browser"
		ll_currow = tab_1.tabpage_1.dw_browser.GetRow()
		of_retrieve(tab_1.tabpage_1.dw_browser, String(il_cate_id))
		//tab_1.tabpage_1.dw_browser.SetRow(ll_currow)
		tab_1.tabpage_1.dw_browser.ScrollToRow(ll_currow)		
End Choose

tab_1.tabpage_1.dw_browser.SetRedraw(True)
tab_1.tabpage_2.dw_master.SetRedraw(True)
tab_1.tabpage_2.dw_detail.SetRedraw(True)


Commit;
MessageBox(gs_msg_title, "Saved the data successfully.")

IF ldws_sign = NewModified! Then
	li_listrow =  tab_1.tabpage_1.dw_productlist.RowCount()
	tab_1.tabpage_2.dw_master.RowsCopy(li_row, li_row, Primary!, tab_1.tabpage_1.dw_productlist, li_listrow + 1, primary!)
	
	tab_1.tabpage_1.dw_productlist.SetRow(li_listrow + 1)
	tab_1.tabpage_1.dw_productlist.ScrollToRow(li_listrow + 1)
	
	ll_productid = tab_1.tabpage_2.dw_master.GetItemNumber(li_row, "productid")
	ls_data = tab_1.tabpage_2.dw_master.GetItemString(li_row, "name")
	tab_1.tabpage_2.dw_detail.GetChild("productid", ldwc_product)
	li_row = ldwc_product.InsertRow(0)
	ldwc_product.SetItem(li_row, "productid", ll_productid)
	ldwc_product.SetItem(li_row, "name", ls_data)
	tab_1.tabpage_2.dw_detail.SetItem(1, "productid", ll_productid)
	
ElseIF ldws_sign = DataModified! Then
	tab_1.tabpage_2.dw_master.RowsCopy(li_row, li_row, Primary!, tab_1.tabpage_1.dw_productlist, li_listrow + 1, primary!)
	tab_1.tabpage_1.dw_productlist.DeleteRow(li_listrow)
	tab_1.tabpage_1.dw_productlist.SetRow(li_listrow)
	tab_1.tabpage_1.dw_productlist.ScrollToRow(li_listrow)
End IF

w_main.ib_modify = False
ib_Modify = False

li_row = tab_1.tabpage_1.dw_browser.GetRow()
IF li_row > 0 Then
	il_subcate_id = tab_1.tabpage_1.dw_browser.GetItemNumber(li_row, "productsubcategoryid")
End IF

Return 1

end event

event ue_add;call super::ue_add;//====================================================================
//$<Event>: ue_add
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_row
String   ls_dwname
DateTime ldt_now

ls_dwname = ClassName(iuo_currentdw)

ldt_now =  DateTime(Today(),Now())

IF ls_dwname = "dw_detail" Then
	Return 1
End IF

IF ls_dwname = "dw_browser" Then	
	IF tab_1.tabpage_1.dw_browser.ModifiedCount() > 0 Then
		MessageBox(gs_msg_title, "Please save the data first.")
		Return -1
	End IF	
	
	IF tab_1.tabpage_2.dw_master.ModifiedCount() > 0 Then
		MessageBox(gs_msg_title, "Please save the data first.")
		Return -1
	End IF	
	il_subcate_id = 0
	tab_1.tabpage_2.dw_detail.Reset()
	
ElseIF ls_dwname= "dw_productlist" OR ls_dwname = "dw_master" Then
	
	tab_1.SelectedTab = 2
	tab_1.tabpage_2.dw_master.Modify("p_1.filename=''")		
	tab_1.tabpage_2.dw_detail.reset()	
End IF

IF ls_dwname = "dw_browser" Then
	li_row = iuo_currentdw.InsertRow(0)
	iuo_currentdw.SelectRow(0, False)
	iuo_currentdw.SelectRow(li_row, True)
	iuo_currentdw.ScrollToRow(li_row)
	iuo_currentdw.SetItem(li_row, "productcategoryid", il_cate_id)
	iuo_currentdw.SetItem(li_row, "modifieddate", ldt_now)
Else
	iuo_currentdw = tab_1.tabpage_2.dw_master
//	iuo_currentdw.SetFilter("1<>1")
//	iuo_currentdw.Filter()
	iuo_currentdw.InsertRow(1)	
	iuo_currentdw.SetItem(1, "productsubcategoryid", il_subcate_id)
	iuo_currentdw.SetItem(1, "modifieddate", ldt_now)
	iuo_currentdw.SetItem(1, "sellstartdate", ldt_now)
	IF il_subcate_id > 0 Then
		iuo_currentdw.SetItem(1, "productsubcategoryid", il_subcate_id)
	End IF		
	iuo_currentdw.SetItem(1, "makeflag", 0)
	
End IF

ib_Modify = True
w_main.ib_modify = True

Return 1

end event

event ue_filter;call super::ue_filter;String ls_filter
String ls_txt

ls_txt = tab_1.tabpage_1.uo_search.of_getsearchtext() //tab_1.tabpage_1.sle_filter.text
ls_filter = ""
IF Len(ls_txt) > 0 Then
	ls_txt = "%" + ls_txt + "%"
	tab_1.tabpage_1.dw_productlist.SetFilter("(name like '" + ls_txt+"') or (Productnumber like '" + ls_txt+"')")
	tab_1.tabpage_1.dw_productlist.Filter()
Else
	tab_1.tabpage_1.dw_productlist.SetFilter("")
	tab_1.tabpage_1.dw_productlist.Filter()
End IF

Return 1
end event

type tab_1 from u_tab_base`tab_1 within u_product
integer x = 0
integer width = 4133
integer height = 2708
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
call super::destroy
end on

event tab_1::selectionchanged;call super::selectionchanged;DateTime ldt_now

ldt_now = DateTime(Today(), Now())

Choose Case newindex
	Case 1
		st_cate.Visible = True
		dw_cate.Visible = True
	Case 2
		st_cate.Visible = False
		dw_cate.Visible = False
		IF tab_1.tabpage_1.dw_productlist.GetRow()<=0 Then
			tab_1.tabpage_2.dw_detail.Reset()
			tab_1.tabpage_2.dw_master.Reset()
			tab_1.tabpage_2.dw_master.InsertRow(0)
			tab_1.tabpage_2.dw_master.Modify("p_1.filename=''")
			tab_1.tabpage_2.dw_master.SetItem(1, "modifieddate", ldt_now)
			tab_1.tabpage_2.dw_master.SetItem(1, "sellstartdate", ldt_now)
			IF il_subcate_id > 0 Then
				tab_1.tabpage_2.dw_master.SetItem(1, "productsubcategoryid", il_subcate_id)
			End IF		
			tab_1.tabpage_2.dw_master.SetItem(1, "makeflag", 0)
		END IF
End Choose

IF newindex = 1 THEN
	IF oldindex = 2 THEN tab_1.tabpage_1.dw_productlist.SetFocus()
ELSE
	IF oldindex = 1 THEN tab_1.tabpage_2.dw_master.SetFocus()
END IF
end event

type tabpage_1 from u_tab_base`tabpage_1 within tab_1
integer width = 3973
integer height = 2676
dw_productlist dw_productlist
sle_filter sle_filter
cb_filter cb_filter
st_2 st_2
uo_search uo_search
end type

on tabpage_1.create
this.dw_productlist=create dw_productlist
this.sle_filter=create sle_filter
this.cb_filter=create cb_filter
this.st_2=create st_2
this.uo_search=create uo_search
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_productlist
this.Control[iCurrent+2]=this.sle_filter
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_search
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_productlist)
destroy(this.sle_filter)
destroy(this.cb_filter)
destroy(this.st_2)
destroy(this.uo_search)
end on

type dw_browser from u_tab_base`dw_browser within tabpage_1
integer x = 64
integer y = 228
integer width = 3845
integer height = 1088
string dataobject = "d_subcategory"
end type

event dw_browser::rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
Integer li_ret
DwItemStatus ldws_1

IF currentrow < 1 Then Return

IF ib_modify = True Then
	tab_1.tabpage_2.dw_master.AcceptText()
	IF tab_1.tabpage_2.dw_master.Modifiedcount() > 0 Then
		li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
		IF li_ret = 1 Then
			tab_1.SelectedTab = 2	
			Return
		ELSE
			iuo_currentdw = tab_1.tabpage_2.dw_master
			of_restore_data()
			iuo_currentdw = This
		End IF
		tab_1.tabpage_2.dw_master.ResetUpdate()
	End IF

	ldws_1 = This.GetItemStatus(currentrow, 0, Primary!)
	IF ldws_1 = NotModified!  And This.GetItemStatus(il_last_row, 0, Primary!) <> NotModified! Then
		li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
		IF li_ret = 1 Then
			This.SetRow(il_last_row)
			cb_save.Event Clicked()
			Return
		ELSE
			of_restore_data()
		End IF
		This.ResetUpdate()
	End IF
End IF

ib_modify = False
w_main.ib_modify = False

This.SelectRow(0,False)
This.SelectRow(currentrow,True)
This.ScrollToRow(currentrow)

il_last_row = currentrow

il_subcate_id = This.GetItemNumber(currentrow, "productsubcategoryid")
IF il_subcate_id = 0 OR Isnull(il_subcate_id) Then 
	dw_productlist.Reset()	
	Return
End if
ls_data = String(il_subcate_id)
of_retrieve(dw_productlist, ls_data)
end event

event dw_browser::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True
end event

event dw_browser::clicked;call super::clicked;IF row = il_last_row THEN Post Event RowFocusChanged(row)
end event

event dw_browser::doubleclicked;DwItemStatus ldws_1

IF row > 0 THEN
	ldws_1 = This.GetItemStatus(row, 0, Primary!)
	IF ldws_1 = New! Or ldws_1 =  NewModified! THEN
		MessageBox(gs_msg_title, "Please save the data first.")
		Return 1
	END IF
END IF

tab_1.SelectTab(2)
end event

type tabpage_2 from u_tab_base`tabpage_2 within tab_1
integer width = 3973
integer height = 2676
st_1 st_1
end type

on tabpage_2.create
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.st_1)
end on

type dw_master from u_tab_base`dw_master within tabpage_2
integer x = 64
integer y = 64
integer width = 3845
string dataobject = "d_product_detail"
end type

event dw_master::buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filename, ls_path
String ls_currentpath
Long   ll_productid
Integer li_Return
Integer li_FileNum
Blob lbb_data
Long ll_pk
DateTime ldt_now

IF row < 1 Then Return

ll_productid = This.GetItemNumber(row, "productid")

IF isnull(ll_productid) OR ll_productid = 0 Then
	MessageBox(gs_msg_title, "Please save the added data first.")
	Return
End IF
ls_currentpath = GetCurrentDirectory()

li_Return = GetFileOpenName("Select File", ls_path, ls_filename, "gif", &
									 "GIF File (*.gif),*.gif," + &
									 "Bitmap Files (*.bmp),*.bmp," + &
									 "JPG Files (*.jpg),*.jpg" )

This.Modify("p_1.filename = '"+ls_path+"'")
ChangeDirectory(ls_currentpath)
IF li_Return <> 1 Then Return

li_FileNum = FileOpen(ls_path, StreamMode!, Read!)
FileReadEx (li_FileNum, lbb_data)
FileClose(li_FileNum)

SELECT Max(Isnull(ProductPhotoID, 0)) + 1 INTO :ll_pk FROM Production.ProductPhoto; 

ldt_now = DateTime(Today(), Now())
INSERT INTO Production.ProductPhoto (LargePhotoFileName, ModifiedDate) Values (:ls_filename, :ldt_now);
IF Sqlca.sqlcode <> 0 THEN
	Messagebox("Failed", "Saved the product photo failed." )
	RollBack;
	Return 
END IF

UPDATEBLOB Production.ProductPhoto
SET LargePhoto = :lbb_data
WHERE ProductPhotoID = :ll_pk;

IF Sqlca.sqlcode <> 0 THEN
	Messagebox("Failed", "Saved the product photo failed." )
	RollBack;
	Return 
END IF

INSERT INTO Production.ProductProductPhoto Values (:ll_productid, :ll_pk, 1, :ldt_now);  // (ProductID,ProductPhotoID,Primary,ModifiedDate ) 

IF Sqlca.sqlcode <> 0 THEN
	Messagebox("Failed", "Saved the product photo failed." )
	RollBack;
	Return 
END IF


Commit;
MessageBox("Save Product Photo", "Saved the product photo successfully.")
end event

event dw_master::itemchanged;call super::itemchanged;ib_modify = True
w_main.ib_modify = True
end event

type dw_detail from u_tab_base`dw_detail within tabpage_2
integer x = 64
integer y = 1616
integer width = 3845
integer height = 988
string dataobject = "d_history_price"
end type

type dw_productlist from u_dw within tabpage_1
integer x = 64
integer y = 1564
integer width = 3845
integer height = 1056
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_product"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;iuo_currentdw = This
end event

event doubleclicked;call super::doubleclicked;tab_1.SelectTab(2)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_data
Integer li_ret


IF currentrow < 1 or This.RowCount( ) < 1 Then Return

IF ib_modify = True Then
	tab_1.tabpage_2.dw_master.Accepttext()
	IF tab_1.tabpage_2.dw_master.Modifiedcount() > 0  Then
		li_ret = MessageBox("Save Change", "You have not saved your changes yet. Do you want to save the changes?" , Question!, YesNo!, 1)
		IF li_ret = 1 Then
			tab_1.SelectedTab = 2
			Return
		ELSE
			iuo_currentdw = tab_1.tabpage_2.dw_master
			of_restore_data()
			iuo_currentdw = This
		End IF
	End IF
End IF

This.SelectRow(0,False)
This.SelectRow(currentrow,True)

ls_data = String(This.GetItemNumber(currentrow, "productid"))
IF Not(isnull(ls_data) OR ls_data = "") Then
	of_retrieve(tab_1.tabpage_2.dw_master, ls_data)		
	of_retrieve(tab_1.tabpage_2.dw_detail, ls_data)	
Else
	tab_1.tabpage_2.dw_detail.Reset()
	tab_1.tabpage_2.dw_master.Reset()
	tab_1.tabpage_2.dw_master.InsertRow(0)
	tab_1.tabpage_2.dw_master.Modify("p_1.filename=''")
End IF
end event

event constructor;call super::constructor;This.SetTransObject(Sqlca)
end event

type sle_filter from singlelineedit within tabpage_1
boolean visible = false
integer x = 69
integer y = 1388
integer width = 896
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string placeholder = "Name"
end type

type cb_filter from commandbutton within tabpage_1
boolean visible = false
integer x = 1029
integer y = 1388
integer width = 366
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;iuo_parent.Event ue_filter()

end event

type st_2 from statictext within tabpage_1
boolean visible = false
integer x = 69
integer y = 1324
integer width = 1129
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16446706
string text = "Explain:"
boolean focusrectangle = false
end type

type uo_search from u_searchbox within tabpage_1
integer x = 64
integer y = 1392
integer width = 1454
integer taborder = 50
boolean bringtotop = true
end type

on uo_search.destroy
call u_searchbox::destroy
end on

event ue_search;call super::ue_search;iuo_parent.Event ue_filter()

end event

event constructor;call super::constructor;of_setplaceholder("Filter by Name / Productnumber")
of_setrealtimesearch(true)
end event

type st_1 from statictext within tabpage_2
integer x = 69
integer y = 1496
integer width = 640
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 553648127
string text = "ProductCostHistory:"
boolean focusrectangle = false
end type

type st_cate from statictext within u_product
integer x = 219
integer y = 84
integer width = 498
integer height = 92
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 553648127
string text = "Select Category:"
boolean focusrectangle = false
end type

type dw_cate from u_dw within u_product
integer x = 741
integer y = 84
integer width = 901
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_catesel"
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
IF row < 1 Then Return
il_cate_id = Long(data)
of_retrieve(tab_1.tabpage_1.dw_browser, data)
end event

type cb_add from u_button within u_product
boolean visible = false
integer x = 2789
integer y = 76
integer width = 366
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Parent.Event ue_add()
end event

type cb_del from u_button within u_product
boolean visible = false
integer x = 3227
integer y = 76
integer width = 366
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_modified

Parent.Event ue_delete()

li_modified =  tab_1.tabpage_2.dw_master.Modifiedcount() 
li_modified = li_modified + tab_1.tabpage_1.dw_browser.Modifiedcount()

IF li_modified  > 0 Then
	ib_modify = True
	w_main.ib_modify = True
Else
	ib_modify = False
	w_main.ib_modify = False
End IF
end event

type cb_save from u_button within u_product
boolean visible = false
integer x = 3666
integer y = 76
integer width = 366
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;Parent.Event ue_save()
end event

