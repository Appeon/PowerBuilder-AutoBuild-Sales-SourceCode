$PBExportHeader$u_createpdf.sru
forward
global type u_createpdf from userobject
end type
type em_3 from editmask within u_createpdf
end type
type st_15 from statictext within u_createpdf
end type
type ddlb_4 from dropdownlistbox within u_createpdf
end type
type st_14 from statictext within u_createpdf
end type
type st_12 from statictext within u_createpdf
end type
type sle_6 from singlelineedit within u_createpdf
end type
type st_11 from statictext within u_createpdf
end type
type cb_1 from commandbutton within u_createpdf
end type
type cbx_3 from checkbox within u_createpdf
end type
type cbx_2 from checkbox within u_createpdf
end type
type cbx_1 from checkbox within u_createpdf
end type
type cb_3 from commandbutton within u_createpdf
end type
type sle_5 from singlelineedit within u_createpdf
end type
type st_17 from statictext within u_createpdf
end type
type ddlb_3 from dropdownlistbox within u_createpdf
end type
type st_9 from statictext within u_createpdf
end type
type sle_4 from singlelineedit within u_createpdf
end type
type st_10 from statictext within u_createpdf
end type
type em_2 from editmask within u_createpdf
end type
type st_8 from statictext within u_createpdf
end type
type ddlb_2 from dropdownlistbox within u_createpdf
end type
type st_7 from statictext within u_createpdf
end type
type sle_3 from singlelineedit within u_createpdf
end type
type st_6 from statictext within u_createpdf
end type
type sle_2 from singlelineedit within u_createpdf
end type
type st_5 from statictext within u_createpdf
end type
type em_1 from editmask within u_createpdf
end type
type st_4 from statictext within u_createpdf
end type
type ddlb_1 from dropdownlistbox within u_createpdf
end type
type st_3 from statictext within u_createpdf
end type
type mle_1 from multilineedit within u_createpdf
end type
type sle_1 from singlelineedit within u_createpdf
end type
type st_1 from statictext within u_createpdf
end type
type gb_2 from groupbox within u_createpdf
end type
type gb_3 from groupbox within u_createpdf
end type
type gb_1 from groupbox within u_createpdf
end type
end forward

global type u_createpdf from userobject
integer width = 3680
integer height = 2124
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_3 em_3
st_15 st_15
ddlb_4 ddlb_4
st_14 st_14
st_12 st_12
sle_6 sle_6
st_11 st_11
cb_1 cb_1
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
cb_3 cb_3
sle_5 sle_5
st_17 st_17
ddlb_3 ddlb_3
st_9 st_9
sle_4 sle_4
st_10 st_10
em_2 em_2
st_8 st_8
ddlb_2 ddlb_2
st_7 st_7
sle_3 sle_3
st_6 st_6
sle_2 sle_2
st_5 st_5
em_1 em_1
st_4 st_4
ddlb_1 ddlb_1
st_3 st_3
mle_1 mle_1
sle_1 sle_1
st_1 st_1
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
end type
global u_createpdf u_createpdf

forward prototypes
public function integer uf_merge ()
end prototypes

public function integer uf_merge ();PDFmultilinetext lpdf_mult,lpdf_mult1
PDFtext lpdf_text,lpdf_text1,lpdf_text2,lpdf_text3,lpdf_titletext,lpdf_contentext,lpdf_context1,lpdf_context2,lpdf_text4,lpdf_title
PDFpage lpdf_page,lpdf_page1,lpdf_page2,lpdf_titlepage,lpdf_contentpage
PDFDocument lpdf_doc
PDFImage lpdf_image,lpdf_imagelogo
long ll_return
string ls_multi

lpdf_mult = create PDFMultilinetext
lpdf_mult1 = create PDFMultilinetext
lpdf_page = create PDFpage
lpdf_doc = create PDFDocument
lpdf_page1 = create PDFpage
lpdf_text = create PDFtext
lpdf_image = create PDFImage
lpdf_imagelogo = create PDFImage
lpdf_page2 = create PDFpage
lpdf_titlepage = create PDFpage
lpdf_titletext = create PDFtext
lpdf_title = create PDFtext
lpdf_contentext = create PDFtext
lpdf_context1 = create PDFtext
lpdf_context2 = create PDFtext
lpdf_text4 = create PDFtext
lpdf_contentpage = create PDFpage

//设置边距
lpdf_titlepage.setrightmargin( 50)
lpdf_titlepage.setleftmargin( 50)
lpdf_titlepage.settopmargin( 50)
lpdf_titlepage.setbottommargin(150 )

lpdf_imagelogo.filename = "image/appeon-01.svg"
lpdf_imagelogo.fitmethod = PDFImageFitmethod_Meet!
lpdf_imagelogo.setsize( 425/2, 63/2)


lpdf_title.content = "PDF-Builder Sample"
lpdf_title.setposition(  lpdf_titlepage.getwidth( )/2 -150, 90)
lpdf_title.font.fontsize = 28

lpdf_mult1.content = "Introduction"
lpdf_mult1.font.fontname = "Arial"
//设置备选字体
lpdf_mult1.addfallbackfont( "Calibri")
lpdf_mult1.font.fontsize = 24
lpdf_mult1.textcolor.b = 255
lpdf_mult1.width = lpdf_titlepage.getwidth( )
//lpdf_mult1.height = 842
//lpdf_mult1.setposition(20,80)
lpdf_mult1.y = lpdf_title.y + 50

ls_multi = "This is a sample PDF created that shows you these features about the new PDF Builder:~r~n~r~n "
ls_multi +="    ● Merging the PDFs generated for DataWindows with existing~r~n        PDF file (this cover page), and images.~r~n"
ls_multi +="     ● Adding text to an existing PDF.~r~n"
ls_multi +="     ● Adding watermark to an existing PDF.~r~n~r~nYou may click a link in the Contents section to go to the corresponding PDF."


lpdf_mult.content = ls_multi
lpdf_mult.font.fontsize = long(em_3.text)
lpdf_mult.layout.alignment= PDFTextAlignLeft!
lpdf_mult.layout.linespacing = 140

lpdf_mult.textcolor.rgb = long(trim(ddlb_4.text))
lpdf_mult.width = lpdf_page1.getwidth( ) -120
//lpdf_mult.height = 832
//lpdf_mult.setposition(20,190)
lpdf_mult.y=190


lpdf_titleText.font.fontsize = 24
lpdf_titleText.Content = "Table of Contents"
lpdf_titleText.textcolor.b = 255
//lpdf_titleText.x = 20
lpdf_titleText.y = lpdf_mult.height + 250
//lpdf_titleText.x= 130

if cbx_1.checked = true then
                lpdf_contentext.font.fontsize = 14
                lpdf_contentext.content = "Category Statistics......................................................................................1"
//            lpdf_contentext.x = 20
                lpdf_contentext.y = 530
                lpdf_titlepage.addcontent(lpdf_contentext)
end if


if cbx_2.checked = true then
                lpdf_context1.font.fontsize = 14
                lpdf_context1.content = "SubCategory Statistics................................................................................2"
//            lpdf_context1.x =20
                lpdf_context1.y = 550
                lpdf_titlepage.addcontent(lpdf_context1)
                
end if
if len(trim(sle_4.text)) > 0 then 
                lpdf_context2.font.fontsize = 14
                lpdf_context2.content = "Image..........................................................................................................3"
//            lpdf_context2.x = 20
                lpdf_context2.y = 570
                lpdf_titlepage.addcontent(lpdf_context2)
                
end if
lpdf_titlepage.addcontent(lpdf_imagelogo)
lpdf_titlepage.addcontent(lpdf_title)
lpdf_titlepage.addcontent(lpdf_mult1)
lpdf_titlepage.addcontent(lpdf_mult)
lpdf_titlepage.addcontent(lpdf_titleText)

lpdf_titlepage.addcontent( lpdf_contentext)
lpdf_titlepage.addcontent( lpdf_context1)
lpdf_titlepage.addcontent( lpdf_context2)



lpdf_doc.addpage(lpdf_titlepage)


if cbx_1.checked = true then
                lpdf_text4.font.fontsize = long(em_1.text)
                lpdf_text4.font.bold = true
                lpdf_text4.content = trim(sle_6.text)
                lpdf_text4.setposition(20,30)
                
                if lower(ddlb_1.text) = "red" then
                                
                                lpdf_text4.textcolor.r = 255
                elseif  lower(ddlb_1.text) = "green" then
                
                                lpdf_text4.textcolor.g = 255
                elseif  lower(ddlb_1.text) = "blue" then
                
                                lpdf_text4.textcolor.b = 255
                elseif  lower(ddlb_1.text) = "black" then
                
                                lpdf_text4.textcolor.rgb = 0

                end if
                lpdf_page.addcontent( lpdf_text4)

                
                //height：842，width：595
//            lpdf_page.addcontent( lpdf_mult)
                lpdf_page.importcontent(".\PDF\Category_Statistics.pdf" , 1, 5, lpdf_text4.height+10, 595, 842)
                lpdf_doc.addpage(lpdf_page)
end if
if cbx_2.checked = true then
                lpdf_text.font.fontsize = long(em_2.text)
                lpdf_text.font.bold = true
                lpdf_text.textcolor.rgb = long(trim(ddlb_2.text))
                lpdf_text.content = trim(sle_3.text)
                lpdf_text.setposition(20,30)
                
                lpdf_page1.importcontent(".\PDF\SubCategory_Statistics.pdf",1,5,lpdf_text.height+10,595,842)
                lpdf_page1.addcontent(lpdf_text)
                lpdf_doc.addpage(lpdf_page1)
end if

//add image
if len(trim(sle_4.text)) > 0 then 
                lpdf_image.filename = trim(sle_4.text)
                
                lpdf_image.width = 590
                lpdf_image.height = 840
                lpdf_page2.addcontent( lpdf_image)
                lpdf_doc.addpage(lpdf_page2)
end if

//Link
lpdf_contentext.linktoobject(lpdf_text4)// = lpdf_text4
lpdf_context1.linktoobject(lpdf_text)// = lpdf_text
lpdf_context2.linktoobject(lpdf_image)// = lpdf_image

if len(trim(sle_5.text)) > 0 then
                lpdf_doc.watermark.image.filename = sle_5.text
                lpdf_doc.watermark.Transparency = 20
                lpdf_doc.watermark.scale = 1
end if

lpdf_doc.compressionlevel = long(ddlb_3.text)

ll_return = lpdf_doc.save(".\PDF\Statistics_report.pdf")


destroy lpdf_mult
destroy lpdf_page
destroy lpdf_doc
destroy lpdf_page1
destroy lpdf_text
destroy lpdf_image
destroy lpdf_page2
destroy lpdf_titlepage
destroy lpdf_titletext
destroy lpdf_contentext
destroy lpdf_context1
destroy lpdf_context2
destroy lpdf_text4
return ll_return

end function

on u_createpdf.create
this.em_3=create em_3
this.st_15=create st_15
this.ddlb_4=create ddlb_4
this.st_14=create st_14
this.st_12=create st_12
this.sle_6=create sle_6
this.st_11=create st_11
this.cb_1=create cb_1
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.sle_5=create sle_5
this.st_17=create st_17
this.ddlb_3=create ddlb_3
this.st_9=create st_9
this.sle_4=create sle_4
this.st_10=create st_10
this.em_2=create em_2
this.st_8=create st_8
this.ddlb_2=create ddlb_2
this.st_7=create st_7
this.sle_3=create sle_3
this.st_6=create st_6
this.sle_2=create sle_2
this.st_5=create st_5
this.em_1=create em_1
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.mle_1=create mle_1
this.sle_1=create sle_1
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.Control[]={this.em_3,&
this.st_15,&
this.ddlb_4,&
this.st_14,&
this.st_12,&
this.sle_6,&
this.st_11,&
this.cb_1,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.cb_3,&
this.sle_5,&
this.st_17,&
this.ddlb_3,&
this.st_9,&
this.sle_4,&
this.st_10,&
this.em_2,&
this.st_8,&
this.ddlb_2,&
this.st_7,&
this.sle_3,&
this.st_6,&
this.sle_2,&
this.st_5,&
this.em_1,&
this.st_4,&
this.ddlb_1,&
this.st_3,&
this.mle_1,&
this.sle_1,&
this.st_1,&
this.gb_2,&
this.gb_3,&
this.gb_1}
end on

on u_createpdf.destroy
destroy(this.em_3)
destroy(this.st_15)
destroy(this.ddlb_4)
destroy(this.st_14)
destroy(this.st_12)
destroy(this.sle_6)
destroy(this.st_11)
destroy(this.cb_1)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.sle_5)
destroy(this.st_17)
destroy(this.ddlb_3)
destroy(this.st_9)
destroy(this.sle_4)
destroy(this.st_10)
destroy(this.em_2)
destroy(this.st_8)
destroy(this.ddlb_2)
destroy(this.st_7)
destroy(this.sle_3)
destroy(this.st_6)
destroy(this.sle_2)
destroy(this.st_5)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.mle_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event constructor;cbx_1.checked = true
cbx_2.checked = true
sle_6.text = 'Report A: Category Statistics Report'
mle_1.text = 'This report compares the sales volumes by category'
sle_3.text = 'Report B: SubCategory Statistic Report'
Sle_4.text = '.\image\image.bmp'
sle_5.text = '.\image\watermark2.png'
ddlb_3.text = '9'
ddlb_1.text ='Black'
ddlb_2.text='0'
ddlb_4.text ='Green'
string ls_multi
ls_multi = "Introduction~r~nThis is a sample PDF created that shows you these features about the new PDF Builder:~r~n "
ls_multi +="•Merging the PDFs generated for DataWindows with existing PDF file (this cover page), and images.~r~n"
ls_multi +=" •Adding text to an existing PDF.~r~n"
ls_multi +=" •Adding watermark to an existing PDF.~r~nYou may click a link in the Contents section to go to the corresponding PDF."
mle_1.text = ls_multi


end event

type em_3 from editmask within u_createpdf
integer x = 2149
integer y = 1556
integer width = 457
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "16"
borderstyle borderstyle = stylelowered!
end type

type st_15 from statictext within u_createpdf
integer x = 1879
integer y = 1564
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Size:"
boolean focusrectangle = false
end type

type ddlb_4 from dropdownlistbox within u_createpdf
integer x = 1225
integer y = 1556
integer width = 549
integer height = 476
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Red","Blue","Green",""}
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within u_createpdf
integer x = 919
integer y = 1564
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Color:"
boolean focusrectangle = false
end type

type st_12 from statictext within u_createpdf
integer x = 146
integer y = 1260
integer width = 777
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "PDF Introduction(Multi-line):"
boolean focusrectangle = false
end type

type sle_6 from singlelineedit within u_createpdf
integer x = 928
integer y = 324
integer width = 2578
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within u_createpdf
integer x = 146
integer y = 332
integer width = 786
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add Header Text(single-line):"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within u_createpdf
boolean visible = false
integer x = 2437
integer y = 1768
integer width = 261
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Select"
end type

type cbx_3 from checkbox within u_createpdf
integer x = 64
integer width = 1403
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "A conver page with the table of contents"
boolean checked = true
end type

type cbx_2 from checkbox within u_createpdf
integer x = 64
integer y = 624
integer width = 699
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

type cbx_1 from checkbox within u_createpdf
integer x = 64
integer y = 92
integer width = 599
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

type cb_3 from commandbutton within u_createpdf
integer x = 2537
integer y = 1880
integer width = 329
integer height = 100
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer li_ret
string ls_filepath,ls_filename, ls_currentdir
ls_currentdir = GetCurrentDirectory( )
li_ret = GetFileOpenName( "Select File", ls_FilePath,ls_FileName, "*","All Files(*.*),*.*","",  2 )
sle_5.text = ls_filepath
ChangeDirectory(ls_currentdir)
end event

type sle_5 from singlelineedit within u_createpdf
integer x = 521
integer y = 1884
integer width = 1998
integer height = 92
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
borderstyle borderstyle = stylelowered!
end type

type st_17 from statictext within u_createpdf
integer x = 59
integer y = 1892
integer width = 457
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Watermark:"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within u_createpdf
integer x = 521
integer y = 2012
integer width = 1001
integer height = 404
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"0","1","2","3","4","5","6","7","8","9"}
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within u_createpdf
integer x = 59
integer y = 2020
integer width = 498
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Compress level:"
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within u_createpdf
integer x = 521
integer y = 1752
integer width = 1998
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within u_createpdf
integer x = 59
integer y = 1764
integer width = 494
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add Image:"
boolean focusrectangle = false
end type

type em_2 from editmask within u_createpdf
integer x = 2149
integer y = 980
integer width = 457
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "16"
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within u_createpdf
integer x = 1879
integer y = 988
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Size:"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within u_createpdf
integer x = 1225
integer y = 980
integer width = 549
integer height = 476
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"255","65280","16777215","16711680","0"}
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within u_createpdf
integer x = 928
integer y = 988
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Color:"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within u_createpdf
integer x = 928
integer y = 852
integer width = 2578
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within u_createpdf
integer x = 146
integer y = 860
integer width = 782
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Add Header Text(single-line):"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within u_createpdf
integer x = 928
integer y = 724
integer width = 1801
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ".\PDF\SubCategory_Statistics.pdf"
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within u_createpdf
integer x = 146
integer y = 728
integer width = 375
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "File:"
boolean focusrectangle = false
end type

type em_1 from editmask within u_createpdf
integer x = 2149
integer y = 452
integer width = 457
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "16"
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within u_createpdf
integer x = 1883
integer y = 460
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Size:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within u_createpdf
integer x = 1225
integer y = 452
integer width = 549
integer height = 476
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Red","Green","Blue","Black"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within u_createpdf
integer x = 923
integer y = 460
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Text Color:"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within u_createpdf
integer x = 928
integer y = 1244
integer width = 2578
integer height = 268
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "Compare the sales volumes of the selected period and the previous period by category."
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within u_createpdf
integer x = 928
integer y = 200
integer width = 1801
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = ".\PDF\Category_Statistics.pdf"
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within u_createpdf
integer x = 146
integer y = 212
integer width = 375
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "File:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within u_createpdf
integer x = 69
integer y = 112
integer width = 3529
integer height = 492
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within u_createpdf
integer x = 69
integer y = 628
integer width = 3529
integer height = 504
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within u_createpdf
integer x = 69
integer y = 1164
integer width = 3529
integer height = 544
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

