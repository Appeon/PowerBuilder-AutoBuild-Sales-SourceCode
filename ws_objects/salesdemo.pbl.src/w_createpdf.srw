$PBExportHeader$w_createpdf.srw
forward
global type w_createpdf from window
end type
type cb_2 from commandbutton within w_createpdf
end type
type cb_1 from commandbutton within w_createpdf
end type
type uo_merge from u_createpdf within w_createpdf
end type
type rb_merge from radiobutton within w_createpdf
end type
type cbx_2 from checkbox within w_createpdf
end type
type cbx_1 from checkbox within w_createpdf
end type
type rb_report from radiobutton within w_createpdf
end type
end forward

global type w_createpdf from window
integer width = 3799
integer height = 2780
boolean titlebar = true
string title = "Create PDF"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = ".\image\create pdf.ico"
boolean center = true
cb_2 cb_2
cb_1 cb_1
uo_merge uo_merge
rb_merge rb_merge
cbx_2 cbx_2
cbx_1 cbx_1
rb_report rb_report
end type
global w_createpdf w_createpdf

type variables
string is_from
end variables

forward prototypes
public function integer wf_pdfreport ()
end prototypes

public function integer wf_pdfreport ();PDFDocument lpdf_doc, lpdf_doc1
long ll_return
lpdf_doc = create PDFDocument
lpdf_doc1 = create PDFDocument
if isvalid(w_salesreport) then
	if cbx_1.checked = true then
		if w_salesreport.uo_1.tab_1.tabpage_1.dw_browser.rowcount() < 1 then
			messagebox('NO Data','Please Retrieve Category Statistics data')
			return -1
		end if
 		ll_return =  lpdf_doc.importdatawindow(w_salesreport.uo_1.tab_1.tabpage_1.dw_browser)
		 lpdf_doc.removepage(2)
		 ll_return = lpdf_doc.save(".\pdf\Category_Statistics.pdf")
	end if
	if cbx_2.checked = true then
		if w_salesreport.uo_1.tab_1.tabpage_2.dw_master.rowcount() < 1 then
			messagebox('NO Data','Please Retrieve SubCategory Statistics data')
			return -1
		end if
		ll_return =  lpdf_doc1.importdatawindow(w_salesreport.uo_1.tab_1.tabpage_2.dw_master)

		 ll_return = lpdf_doc1.save(".\pdf\SubCategory_Statistics.pdf")
	end if
	
end if
return ll_return
end function

on w_createpdf.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_merge=create uo_merge
this.rb_merge=create rb_merge
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.rb_report=create rb_report
this.Control[]={this.cb_2,&
this.cb_1,&
this.uo_merge,&
this.rb_merge,&
this.cbx_2,&
this.cbx_1,&
this.rb_report}
end on

on w_createpdf.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_merge)
destroy(this.rb_merge)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.rb_report)
end on

event open;is_from = message.stringparm
cbx_1.checked = true
cbx_2.checked = true

rb_merge.checked = true
cbx_1.enabled = false
cbx_2.enabled = false
uo_merge.enabled = true
end event

type cb_2 from commandbutton within w_createpdf
integer x = 3351
integer y = 2548
integer width = 389
integer height = 100
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_createpdf
integer x = 2958
integer y = 2548
integer width = 389
integer height = 100
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Create"
end type

event clicked;
long ll_return, ll_return1
if rb_report.checked = true then
	ll_return = wf_pdfreport()
	if ll_return = 1 then
		messagebox('Information','The PDF document is created successfully and saved to:.\PDF\Category_Statistics.pdf.pdf and .\PDF\SubCategory_Statistics.pdf')
	else
		messagebox('Fail','The PDF document is created fail, return is ' + string(ll_return))
	end if
elseif rb_merge.checked = true then
	
	ll_return = wf_pdfreport()
	if ll_return = 1 then
		ll_return1 = uo_merge.uf_merge()
		if ll_return1 = 1 then
			messagebox('Information','The PDF document is created successfully and saved to:.\PDF\Statistics_report.pdf')
		else
			messagebox('Fail','The PDF document is created fail, return is ' + string(ll_return1))
		end if
	else
	end if
end if
	
end event

type uo_merge from u_createpdf within w_createpdf
integer x = 110
integer y = 332
integer width = 3639
integer height = 2136
integer taborder = 60
end type

on uo_merge.destroy
call u_createpdf::destroy
end on

type rb_merge from radiobutton within w_createpdf
integer x = 101
integer y = 240
integer width = 1897
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Create a PDF that merges the statistics reports"
end type

event clicked;if this.checked = true then
	
	cbx_1.enabled = false
	cbx_2.enabled = false
	uo_merge.enabled = true

end if
end event

type cbx_2 from checkbox within w_createpdf
integer x = 1047
integer y = 116
integer width = 722
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "SubCategory Statistics"
end type

type cbx_1 from checkbox within w_createpdf
integer x = 183
integer y = 116
integer width = 741
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Category Statistics"
end type

type rb_report from radiobutton within w_createpdf
integer x = 101
integer y = 20
integer width = 2071
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Create separate PDFs for individual statistics report"
end type

event clicked;if this.checked = true then
	cbx_1.enabled = true
	cbx_2.enabled = true
   uo_merge.enabled = false

end if
end event

