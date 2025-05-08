$PBExportHeader$u_survey.sru
forward
global type u_survey from userobject
end type
type tab_1 from tab within u_survey
end type
type tabpage_1 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type rte_1 from richtextedit within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_2 cb_2
rte_1 rte_1
end type
type tabpage_2 from userobject within tab_1
end type
type wb_1 from webbrowser within tabpage_2
end type
type tabpage_2 from userobject within tab_1
wb_1 wb_1
end type
type tab_1 from tab within u_survey
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type u_survey from userobject
integer width = 4425
integer height = 3716
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_1 tab_1
end type
global u_survey u_survey

type variables
string is_company
end variables

forward prototypes
public subroutine of_survey (string as_company)
public subroutine wf_createpdf (string as_company)
end prototypes

public subroutine of_survey (string as_company);Integer 			li_rtn, li_fieldid, i 
Date				ld_date, ld_date1
Boolean 			lbn_flag, lb_rtn
String			ls_data, ls_item[], ls_table1[], ls_table2[], ls_commboitem[], ls_itemText
Long				ll_fieldID, ll_inputPos, ll_ItemLen

SetPointer(Hourglass!)
openwithparm(w_progressbar,"Creating/Loading survey data...")

//Title [Company Name]
ls_data = '\pard\ltrpar\s16\itap0\widctlpar\qc\li0\ri0\lin0\rin0\brdrt\brdrs\brdrw30\brsp100\brdrcf2\brdrb\brdrs\brdrw30\brsp100\brdrcf2\brdrbtw\brdrs\brdrw30\brsp100\brdrcf2\cbpat3\plain\rtlch\af3\afs32\ab\ltrch\f3\fs32\b ['+as_company+']'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)
//How Are We Doing? 
ls_data ='\ltrpar\s1\itap0\outlinelevel0\keep\keepn\widctlpar\ql\li0\ri0\lin0\rin0\sb360\sa180\plain\rtlch\af3\afs22\ab\ai\acf4\ltrch\f3\fs22\b\i\cf4 How Are We Doing?'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)
//We are committed to providing you with the best dining experience possible, so we welcome your comments. Please fill out this questionnaire and send it to us by replying to the email. Thank you.
ls_data ='\fs24\ We are committed to providing you with the best experience possible, so we welcome your comments. Please fill out this questionnaire and send it to us by replying to the email. Thank you.'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)

//Insert textfield
ll_fieldID = tab_1.tabpage_1.rte_1.formtextfieldinsert( "", 11600)	
tab_1.tabpage_1.rte_1.ReplaceText("~r~n")

//Please rate the quality of the products you received:
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Please rate the quality of the products you received:'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)

ls_data =space(60) 
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
For i = 1 To 5
	li_fieldid = tab_1.tabpage_1.rte_1.FormCheckBoxInsert( False)
	ls_data = String(i) +space(12) 
	tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\  "+ls_data+"}", Detail!)
Next 

ll_fieldID = tab_1.tabpage_1.rte_1.TableInsert(1,2,-1)
ls_item={"Disappointing","Exceptional"}
For i = 1 To 2 Step 1
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellText(ll_fieldID,1,i,ls_item[i])
Next

tab_1.tabpage_1.rte_1.TableCellSelect(ll_fieldID, 1, 2)
tab_1.tabpage_1.rte_1.SetAlignment(Right!)

ll_ItemLen = tab_1.tabpage_1.rte_1.TableGetCellLength(ll_fieldID, 1, 2)      		
ll_inputPos = tab_1.tabpage_1.rte_1.TableCellStart(ll_fieldID, 1, 2)            	
tab_1.tabpage_1.rte_1.SelectedStartPos = ll_inputPos +  ll_ItemLen          		
tab_1.tabpage_1.rte_1.SelectedTextLength = 0   												

tab_1.tabpage_1.rte_1.ReplaceText("~r~n")

ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Please rate the quality of the support service you received:'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\ "+ls_data+"\par}", Detail!)

ls_data =space(60) 
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
For i = 1 To 5
	If i <> 5 Then
		li_fieldid = tab_1.tabpage_1.rte_1.FormCheckBoxInsert( False)
	Else
		li_fieldid = tab_1.tabpage_1.rte_1.FormCheckBoxInsert( True)
	End If	
	ls_data = String(i) +space(12) 
	tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\  "+ls_data+"}", Detail!)
Next 

ll_fieldID = tab_1.tabpage_1.rte_1.TableInsert(1,2,-1)
ls_item={"Disappointing","Exceptional"}
For i = 1 To 2 Step 1
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellText(ll_fieldID,1,i,ls_item[i])
Next

tab_1.tabpage_1.rte_1.TableCellSelect(ll_fieldID, 1, 2)
tab_1.tabpage_1.rte_1.SetAlignment(Right!)

ll_ItemLen = tab_1.tabpage_1.rte_1.TableGetCellLength(ll_fieldID, 1, 2)      		
ll_inputPos = tab_1.tabpage_1.rte_1.TableCellStart(ll_fieldID, 1, 2)            	
tab_1.tabpage_1.rte_1.SelectedStartPos = ll_inputPos +  ll_ItemLen          	
tab_1.tabpage_1.rte_1.SelectedTextLength = 0   												
tab_1.tabpage_1.rte_1.ReplaceText("~r~n")

ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 How frequently do you use our product or support service?'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	
tab_1.tabpage_1.rte_1.ReplaceText("~r~n")

//Insert Table and set cell text
ll_fieldID = tab_1.tabpage_1.rte_1.TableInsert(5,4,-1)
lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellBorderWidth(ll_fieldID,0,0,1)

ls_table2={"","Product A","Product B","Support Service"}
For i = 1 To 4 Step 1
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellText(ll_fieldID,1,i,ls_table2[i])
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellBackColor(ll_fieldID,1,i,RGB(224, 234, 225))
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellBorderColor(ll_fieldID,1,i,rgb(75,126,241))	
Next

ls_item={"","3-5 times per month","1-2 times per month","Once every 2 months","Other"}
For i = 2 To 5 Step 1
	lb_rtn = tab_1.tabpage_1.rte_1.TableSetCellText(ll_fieldID,i,1,ls_item[i])
Next

ls_data =''
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par}", Detail!)

//Was your server
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Was our support service:'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\ "+ls_data+"\par}", Detail!)
ls_data =''
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par}", Detail!)

//Insert Combobox
ls_data ='Choose an item.'
ls_commboitem={"Choose an item.","Courteous","Informative","Prompt and efficient"}
li_rtn = tab_1.tabpage_1.rte_1.formcomboboxinsert( ls_data, ls_commboitem, False, 9000)

ls_data =''
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par\par}", Detail!)

//Would you recommend our restaurant to a friend?
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Would you recommend our products to a friend?'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	

//Insert CheckBox
li_fieldid = tab_1.tabpage_1.rte_1.FormCheckBoxInsert( False)
ls_data='Yes | '
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)
li_fieldid = tab_1.tabpage_1.rte_1.FormCheckBoxInsert( False)
ls_data='No '
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"\par\par}", Detail!)

//Why, or why not?
ls_data ='\pard\brdrt\brdrs\brdrw10\brsp20\brdrcf0\brdrbtw\brdrs\brdrw10\brsp20\brdrcf0\fs24 Why, or why not?'
tab_1.tabpage_1.rte_1.pastertf("{\rtf1"+ls_data+"\par}", Detail!)	

//Insert TextFrame
li_fieldid = tab_1.tabpage_1.rte_1.TextFrameInsertAsChar(-1, 11600, 600)
tab_1.tabpage_1.rte_1.TextFrameSetText(li_fieldid, "Please explain.")
tab_1.tabpage_1.rte_1.TextFrameSetBackColor(li_fieldid, RGB(224, 234, 225))
tab_1.tabpage_1.rte_1.ReplaceText("~r~n")

//Insert DateField
ls_data =' Date:  '
tab_1.tabpage_1.rte_1.pastertf("{\rtf1\fs24\ "+ls_data+"}", Detail!)

ld_date= Today ( )
lbn_flag= False
li_fieldid = tab_1.tabpage_1.rte_1.FormDateFieldInsert(ld_date, lbn_flag, "MM/dd/yyyy", 10000)


close(w_progressbar)
SetPointer(Arrow!)
end subroutine

public subroutine wf_createpdf (string as_company);PDFmultilinetext lpdf_mult
PDFtext lpdf_text,lpdf_text1,lpdf_cktext,lpdf_cktext1,lpdf_title,lpdf_cktext2,lpdf_cktext3,lpdf_cktext4,lpdf_cktext5,lpdf_cktext6,lpdf_cktext7,lpdf_cktext8,lpdf_cktext9
PDFpage lpdf_page
PDFDocument lpdf_doc
PDFformfieldtext lpdf_fieldtext
PDFformfieldcheckbox lpdf_fieldcbox,lpdf_fieldcbox1,lpdf_fieldcbox2,lpdf_fieldcbox3,lpdf_fieldcbox4,lpdf_fieldcbox5,lpdf_fieldcbox6,lpdf_fieldcbox7,lpdf_fieldcbox8,lpdf_fieldcbox9
PDFtext lpdf_text2,lpdf_text3, lpdf_text4,lpdf_text5,lpdf_rbtext,lpdf_rbtext1
PDFformfieldcombobox  lpdf_combobox
PDFformfieldradiobutton lpdf_rb,lpdf_rb1
PDFformfieldGroup lpdf_group
pdfformfieldradiobuttongroup lpdf_rbgroup

PDFformfieldpushbutton lpdf_pushbutton
PDFactionjavascript lpdf_script
PDFactionresetform lpdf_reset
string ls_itemtext[]
int ll_return

lpdf_rbgroup = create pdfformfieldradiobuttongroup
lpdf_mult= create Pdfmultilinetext
lpdf_page = create PDFpage
lpdf_doc = create PDFDocument
lpdf_text = create PDFtext
lpdf_title = create PDFtext
lpdf_fieldtext = create PDFformfieldtext
lpdf_text1 = create pdftext
lpdf_fieldcbox=create PDFformfieldcheckbox
lpdf_cktext = create PDFtext
lpdf_fieldcbox1=create PDFformfieldcheckbox
lpdf_cktext1 = create PDFtext
lpdf_fieldcbox2=create PDFformfieldcheckbox
lpdf_cktext2 = create PDFtext
lpdf_fieldcbox3=create PDFformfieldcheckbox
lpdf_cktext3 = create PDFtext
lpdf_fieldcbox4=create PDFformfieldcheckbox
lpdf_cktext4 = create PDFtext
lpdf_text2 = create pdftext
lpdf_fieldcbox5=create PDFformfieldcheckbox
lpdf_fieldcbox6=create PDFformfieldcheckbox
lpdf_fieldcbox7=create PDFformfieldcheckbox
lpdf_cktext5 = create PDFtext
lpdf_cktext6 = create PDFtext
lpdf_cktext7 = create PDFtext
lpdf_fieldcbox8=create PDFformfieldcheckbox
lpdf_cktext8 = create PDFtext
lpdf_fieldcbox9=create PDFformfieldcheckbox
lpdf_cktext9 = create PDFtext
lpdf_text3 = create pdftext
lpdf_text4 = create pdftext
lpdf_combobox = create pdfformfieldcombobox
lpdf_text5 = create pdftext
lpdf_rb = create pdfformfieldradiobutton
lpdf_rb1 = create pdfformfieldradiobutton
lpdf_rbtext = create pdftext
lpdf_rbtext1 = create pdftext
lpdf_group = create pdfformfieldgroup

lpdf_page.setrightmargin( 50)
lpdf_page.setleftmargin( 50)
lpdf_page.settopmargin( 50)
lpdf_page.setbottommargin(150 )

lpdf_title.content = "["+as_company+"]"
lpdf_title.setposition(  lpdf_page.getwidth( )/2 - 100, 0)
lpdf_title.font.fontsize = 28

lpdf_text.content = "How Are We Doing?"
lpdf_text.y=lpdf_title.y+50
lpdf_text.width = lpdf_page.getwidth()
lpdf_text.font.fontsize=12
lpdf_text.font.bold=true
//lpdf_text.font.italic = true

lpdf_mult.content='We are committed to providing you with be best exprience possible, so we welcome your comments. Please fill out this questionnaire and send ti to us by replying to the email. Thank you.'
lpdf_mult.y = lpdf_text.y +15
lpdf_mult.width = lpdf_page.getwidth( )
lpdf_mult.font.fontsize=10

lpdf_page.addcontent(lpdf_title)
lpdf_page.addcontent(lpdf_text)
lpdf_page.addcontent(lpdf_mult)

lpdf_fieldtext.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldtext.setposition(lpdf_mult.x,lpdf_mult.y+30)
lpdf_fieldtext.width=lpdf_mult.width
lpdf_page.addcontent(lpdf_fieldtext)

lpdf_text1.content = 'Please rate the quality of the products you received:'
lpdf_text1.font.fontsize=10
lpdf_text1.y= lpdf_fieldtext.y+50
lpdf_text1.x=lpdf_fieldtext.x
lpdf_text1.width = lpdf_mult.width
lpdf_page.addcontent(lpdf_text1)

lpdf_fieldcbox.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox.setposition(lpdf_text1.x+50,lpdf_text1.y+20)
lpdf_cktext.content = "1"
lpdf_cktext.font.fontsize=14
lpdf_cktext.setposition(5+lpdf_fieldcbox.width+lpdf_fieldcbox.x,lpdf_fieldcbox.y+2)
lpdf_page.addcontent(lpdf_fieldcbox)
lpdf_page.addcontent(lpdf_cktext)

lpdf_fieldcbox1.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox1.setposition(lpdf_cktext.x+50,lpdf_text1.y+20)
lpdf_cktext1.content = "2"
lpdf_cktext1.font.fontsize=14
lpdf_cktext1.setposition(5+lpdf_fieldcbox1.width+lpdf_fieldcbox1.x,lpdf_fieldcbox1.y+2)
lpdf_page.addcontent(lpdf_fieldcbox1)
lpdf_page.addcontent(lpdf_cktext1)

lpdf_fieldcbox2.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox2.setposition(lpdf_cktext1.x+50,lpdf_text1.y+20)
lpdf_cktext2.content = "3"
lpdf_cktext2.font.fontsize=14
lpdf_cktext2.setposition(5+lpdf_fieldcbox2.width+lpdf_fieldcbox2.x,lpdf_fieldcbox2.y+2)
lpdf_page.addcontent(lpdf_fieldcbox2)
lpdf_page.addcontent(lpdf_cktext2)

lpdf_fieldcbox3.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox3.setposition(lpdf_cktext2.x+50,lpdf_text1.y+20)
lpdf_cktext3.content = "4"
lpdf_cktext3.font.fontsize=14
lpdf_cktext3.setposition(5+lpdf_fieldcbox3.width+lpdf_fieldcbox3.x,lpdf_fieldcbox3.y+2)
lpdf_page.addcontent(lpdf_fieldcbox3)
lpdf_page.addcontent(lpdf_cktext3)

lpdf_fieldcbox4.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox4.setposition(lpdf_cktext3.x+50,lpdf_text1.y+20)
lpdf_cktext4.content = "5"
lpdf_cktext4.font.fontsize=14
lpdf_cktext4.setposition(5+lpdf_fieldcbox4.width+lpdf_fieldcbox4.x,lpdf_fieldcbox4.y+2)
lpdf_page.addcontent(lpdf_fieldcbox4)
lpdf_page.addcontent(lpdf_cktext4)

//lpdf_text2.content='-'
//lpdf_text2.setposition(lpdf_mult.x,lpdf_fieldcbox.y+20)
//lpdf_text2.width=lpdf_mult.width
//lpdf_page.addcontent(lpdf_text2)
lpdf_text3.Content = 'Please rate the quality of the support service you received:'
lpdf_text3.setposition(lpdf_mult.x,lpdf_fieldcbox.y+30)
lpdf_text3.width = lpdf_mult.width
lpdf_text3.font.fontsize=10
lpdf_page.addcontent(lpdf_text3)

lpdf_fieldcbox5.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox5.setposition(lpdf_text3.x+50,lpdf_text3.y+20)
lpdf_cktext5.content = "1"
lpdf_cktext5.font.fontsize=14
lpdf_cktext5.setposition(5+lpdf_fieldcbox5.width+lpdf_fieldcbox5.x,lpdf_fieldcbox5.y+2)
lpdf_page.addcontent(lpdf_fieldcbox5)
lpdf_page.addcontent(lpdf_cktext5)

lpdf_fieldcbox6.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox6.setposition(lpdf_cktext5.x+50,lpdf_text3.y+20)
lpdf_cktext6.content = "2"
lpdf_cktext6.font.fontsize=14
lpdf_cktext6.setposition(5+lpdf_fieldcbox6.width+lpdf_fieldcbox6.x,lpdf_fieldcbox6.y+2)
lpdf_page.addcontent(lpdf_fieldcbox6)
lpdf_page.addcontent(lpdf_cktext6)

lpdf_fieldcbox7.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox7.setposition(lpdf_cktext6.x+50,lpdf_text3.y+20)
lpdf_cktext7.content = "3"
lpdf_cktext7.font.fontsize=14
lpdf_cktext7.setposition(5+lpdf_fieldcbox7.width+lpdf_fieldcbox7.x,lpdf_fieldcbox7.y+2)
lpdf_page.addcontent(lpdf_fieldcbox7)
lpdf_page.addcontent(lpdf_cktext7)

lpdf_fieldcbox8.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox8.setposition(lpdf_cktext7.x+50,lpdf_text3.y+20)
lpdf_cktext8.content = "4"
lpdf_cktext8.font.fontsize=14
lpdf_cktext8.setposition(5+lpdf_fieldcbox8.width+lpdf_fieldcbox8.x,lpdf_fieldcbox8.y+2)
lpdf_page.addcontent(lpdf_fieldcbox8)
lpdf_page.addcontent(lpdf_cktext8)

lpdf_fieldcbox9.bordercolor.rgb=  rgb(0,0,0)
lpdf_fieldcbox9.setposition(lpdf_cktext8.x+50,lpdf_text3.y+20)
lpdf_cktext9.content = "5"
lpdf_cktext9.font.fontsize=14
lpdf_cktext9.setposition(5+lpdf_fieldcbox9.width+lpdf_fieldcbox9.x,lpdf_fieldcbox9.y+2)
lpdf_page.addcontent(lpdf_fieldcbox9)
lpdf_page.addcontent(lpdf_cktext9)

lpdf_text4.content = 'Was our support service:'
lpdf_text4.setposition(lpdf_mult.x,lpdf_fieldcbox9.y+30)
lpdf_text4.width = lpdf_mult.width
lpdf_text4.font.fontsize=10
lpdf_page.addcontent(lpdf_text4)

//==========PDFformfieldcombobox===========
ls_itemtext ={"Choose an item","Courteous","Informative","Prompt and efficient"}
lpdf_combobox.bordercolor.rgb=  rgb(0,0,0)
lpdf_combobox.setitemlist(ls_itemtext)
lpdf_combobox.setposition(lpdf_mult.x,lpdf_text4.y+20)
lpdf_combobox.currentvalue="Choose an item"
lpdf_page.addcontent(lpdf_combobox)

lpdf_text5.content='Would you recommend our products to a friend?'
lpdf_text5.setposition(lpdf_mult.x,lpdf_combobox.y+30)
lpdf_text5.width = lpdf_mult.width
lpdf_text5.font.fontsize=10
lpdf_page.addcontent(lpdf_text5)

//========PDFformfieldradiobutton=============
//set group type
//lpdf_group.fieldtype = PDFFormFieldGroupType_RadioButton!
lpdf_rb.bordercolor.rgb=  rgb(0,0,0)
lpdf_rb.buttonstyle=PDFFormFieldButtonStyle_Circle!
lpdf_rb.setposition(lpdf_mult.x,lpdf_text5.y+20)
//lpdf_group.addformfield(lpdf_rb)
////lpdf_rbtext = lpdf_text.clone()
lpdf_rbgroup.add(lpdf_rb)
lpdf_rbtext.content = "Yes"
lpdf_rbtext.setposition(lpdf_rb.x+lpdf_rb.width+5,lpdf_rb.y+5)
lpdf_page.addcontent(lpdf_rb)
lpdf_page.addcontent(lpdf_rbtext)

lpdf_rb1.bordercolor.rgb=  rgb(0,0,0)
lpdf_rb1.buttonstyle=PDFFormFieldButtonStyle_Circle!
lpdf_rb1.setposition(lpdf_rbtext.x+10+lpdf_rbtext.width,lpdf_text5.y+20)
//lpdf_group.addformfield(lpdf_rb1)
lpdf_rbgroup.add(lpdf_rb1)
////lpdf_rbtext = lpdf_text.clone()
lpdf_rbtext1.content = "No"
lpdf_rbtext1.setposition(lpdf_rb1.x+lpdf_rb1.width+5,lpdf_rb.y+5)
lpdf_page.addcontent(lpdf_rb1)
lpdf_page.addcontent(lpdf_rbtext1)

//group add to doc
lpdf_doc.addformfieldgroup(lpdf_rbgroup)

//pushubutton  getdate
lpdf_text5 = lpdf_text5.clone()
lpdf_text5.content='Date: '
lpdf_text5.setposition(lpdf_mult.x,lpdf_rbtext1.y+40)
lpdf_text5.width = lpdf_mult.width
lpdf_text5.font.fontsize=10
lpdf_page.addcontent(lpdf_text5)

lpdf_fieldtext = lpdf_fieldtext.clone()
lpdf_fieldtext.borderstyle =PDFFormFieldBorderStyle_Underline!
lpdf_fieldtext.setposition(lpdf_text5.x+lpdf_text5.width+2,lpdf_rbtext1.y+30)
lpdf_fieldtext.width = 70
lpdf_fieldtext.name="Date"
lpdf_page.addcontent(lpdf_fieldtext)

//from JavaScript get date
lpdf_script = create PDFactionjavascript
lpdf_script.script = "var d=util.printd('mm/dd/yyyy',new Date()); var date = this.getField(~"Date~");date.value = d; "
lpdf_pushbutton = create Pdfformfieldpushbutton
//set button is disable print
lpdf_pushbutton.display = PDFFormFieldDisplay_NoPrint!
lpdf_pushbutton.bordercolor.rgb = rgb(0,0,0)
lpdf_pushbutton.caption = "GetDate"
lpdf_pushbutton.setposition(lpdf_fieldtext.x+lpdf_fieldtext.width+2,lpdf_rbtext1.y+35)
lpdf_pushbutton.addaction(PDFFormFieldEvent_Down!,lpdf_script)
lpdf_page.addcontent(lpdf_pushbutton)

//Reset Survey
lpdf_reset = create PDFactionresetform
lpdf_pushbutton = create Pdfformfieldpushbutton
lpdf_pushbutton.display = PDFFormFieldDisplay_NoPrint!
lpdf_pushbutton.bordercolor.rgb = rgb(0,0,0)
lpdf_pushbutton.caption = "Reset Survey"
lpdf_pushbutton.setposition(lpdf_mult.x,lpdf_fieldtext.y+50)
lpdf_pushbutton.addaction(PDFFormFieldEvent_Down!,lpdf_reset)
lpdf_page.addcontent(lpdf_pushbutton)

lpdf_doc.addpage(lpdf_page)

lpdf_doc.watermark.image.filename = ".\image\watermark2.png"
lpdf_doc.watermark.Transparency = 80
lpdf_doc.watermark.scale = 100

//

ll_return = lpdf_doc.save(".\pdf\test.pdf")

if ll_return <> 1 then return
tab_1.tabpage_2.wb_1.navigate( 'file:///' + "./pdf/test.pdf" )

destroy lpdf_mult
destroy lpdf_page
destroy lpdf_doc
destroy lpdf_text
destroy lpdf_title
destroy lpdf_fieldtext
destroy lpdf_text1
destroy lpdf_fieldcbox
destroy lpdf_cktext
destroy lpdf_fieldcbox1
destroy lpdf_cktext1
destroy lpdf_fieldcbox2
destroy lpdf_cktext2
destroy lpdf_fieldcbox3
destroy lpdf_cktext3
destroy lpdf_fieldcbox4
destroy lpdf_cktext4
destroy lpdf_text2
destroy lpdf_fieldcbox5
destroy lpdf_fieldcbox6
destroy lpdf_fieldcbox7
destroy lpdf_cktext5
destroy lpdf_cktext6
destroy lpdf_cktext7
destroy lpdf_fieldcbox8
destroy lpdf_cktext8
destroy lpdf_fieldcbox9
destroy lpdf_cktext9
destroy lpdf_text3
destroy lpdf_text4
destroy lpdf_combobox
destroy lpdf_text5
destroy lpdf_rb
destroy lpdf_rb1
destroy lpdf_rbtext
destroy lpdf_rbtext1
destroy lpdf_group
destroy lpdf_rbgroup
end subroutine

on u_survey.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on u_survey.destroy
destroy(this.tab_1)
end on

type tab_1 from tab within u_survey
event create ( )
event destroy ( )
integer x = 18
integer y = 12
integer width = 4389
integer height = 3672
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 124
integer width = 4352
integer height = 3532
long backcolor = 67108864
string text = "RichText"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_2 cb_2
rte_1 rte_1
end type

on tabpage_1.create
this.cb_2=create cb_2
this.rte_1=create rte_1
this.Control[]={this.cb_2,&
this.rte_1}
end on

on tabpage_1.destroy
destroy(this.cb_2)
destroy(this.rte_1)
end on

type cb_2 from commandbutton within tabpage_1
integer x = 23
integer y = 16
integer width = 466
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Export and Send"
end type

event clicked;String 	ls_Pdffile, ls_newfile
Integer 	li_rtn
Boolean 	lb_exist
PDFdocument lpdf_doc


lpdf_doc = create PDFdocument

//Import the richtextedit content
lpdf_doc.importrichtextedit( tab_1.tabpage_1.rte_1)

lpdf_doc.watermark.image.filename=".\image\watermark2.png"
lpdf_doc.watermark.Transparency = 20
lpdf_doc.watermark.scale = 1


ls_Pdffile = ".\pdf\survey.pdf"
li_rtn = lpdf_doc.save( ls_Pdffile)
Destroy lpdf_doc

If li_rtn = 1 Then
	
	openwithparm(w_sendemail,'Survey')
Else
	Messagebox("Info","Failed to export the PDF file!")	
End IF
end event

type rte_1 from richtextedit within tabpage_1
integer x = 14
integer y = 120
integer width = 4338
integer height = 3388
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_headerfooter = true
long init_leftmargin = 100
long init_rightmargin = 100
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 4352
integer height = 3532
long backcolor = 67108864
string text = "PDFBuilder"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
wb_1 wb_1
end type

on tabpage_2.create
this.wb_1=create wb_1
this.Control[]={this.wb_1}
end on

on tabpage_2.destroy
destroy(this.wb_1)
end on

type wb_1 from webbrowser within tabpage_2
integer x = 41
integer y = 20
integer width = 4283
integer height = 3488
boolean border = false
borderstyle borderstyle = stylebox!
end type

