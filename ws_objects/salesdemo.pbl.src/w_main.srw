$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
type rbb_main from ribbonbar within w_main
end type
end forward

global type w_main from window
integer width = 3968
integer height = 2964
boolean titlebar = true
string title = "Sales CRM Demo"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = ".\image\crm.ico"
boolean toolbarvisible = false
boolean center = true
event ue_resize ( )
event ue_tray ( )
mdi_1 mdi_1
rbb_main rbb_main
end type
global w_main w_main

type variables
Boolean ib_modify = False
String    is_model
u_tab_base uo_current
String		is_windowslists[]
String		is_windows[], is_recents[]
String		is_themename, is_themeold

end variables

forward prototypes
public subroutine of_largebuttonclicked (long itemhandle)
public subroutine of_mastermenuclicked (long itemhandle, long index, long subindex)
public subroutine of_recentmenuclicked (long itemhandle, long index, long subindex)
public subroutine of_refresh_historymenu ()
public subroutine of_smallbuttonclicked (long itemhandle)
public subroutine of_tabbuttonclicked (long itemhandle)
public subroutine of_menuitemclicked (long itemhandle, long index, long subindex)
public subroutine of_opensheet (string as_window)
public subroutine of_refresh_status (string as_window, boolean abn_active)
public subroutine of_add_recentmenu (string as_window)
public subroutine of_add_windows (string as_window)
public subroutine of_set_largebutton_active (ribbonlargebuttonitem ar_largebuttonitem, boolean abn_active)
public subroutine of_set_item_enabled (string as_tag, integer ai_type, boolean ab_flag)
public subroutine of_set_actionsbar (boolean ab_flag, string as_panel)
public subroutine of_add_items (ref emf_str_ribbonbaritem astr_item[], string as_tag, integer ai_type)
public subroutine of_refresh_ribbonbartheme ()
public function string of_refreshtheme ()
public subroutine of_screensaver ()
public subroutine of_closewindow (string as_type)
end prototypes

event ue_resize();mdi_1.x = this.workspacex() 
mdi_1.y = this.workspacey()  +  rbb_main.height 		// + 4									 
mdi_1.height = this.workspaceHeight() - rbb_main.height // - 4	
mdi_1.width  = this.workspaceWidth() 

rbb_main.width = this.workspaceWidth() 

//SetReDraw(False)
//This.arrangesheets( Layer! )
//SetReDraw(True)

w_base lw_base
lw_base  = this.getactivesheet( )
if isvalid(lw_base)  then 
	IF lw_base.windowstate <> Maximized! THEN lw_base.windowstate = Maximized!
end if
end event

event ue_tray();nvo_taskbarutil					lnvo_taskbarutil

lnvo_taskbarutil = create nvo_taskbarutil
lnvo_taskbarutil.of_refreshnotificationarea( )

Destroy lnvo_taskbarutil 
end event

public subroutine of_largebuttonclicked (long itemhandle);RibbonLargeButtonItem			lr_largebuttonitem
integer								li_return
string									ls_text


li_return = rbb_main.GetLargebutton(itemhandle, lr_largebuttonitem)
if li_return  = 1 then
	ls_text = lr_largebuttonitem.text
	choose case ls_text
		case "Address","Customer","Product","Order"
			of_opensheet(ls_text)
			of_set_actionsbar(true,"All")
		case "Statistics" 		
			of_opensheet(ls_text)
			of_set_actionsbar(true,"Close")
			of_set_actionsbar(false,"Action")		
			of_set_actionsbar(false,"View")		
			of_set_actionsbar(false,"Print")
		case ""			
			
		case else
			
	end choose 
	
	of_refresh_status(ls_text, true)	
	of_refresh_historymenu()
end if 


end subroutine

public subroutine of_mastermenuclicked (long itemhandle, long index, long subindex);RibbonApplicationMenu			lr_appmenu
RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text, ls_tag


li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_appmenu)
if li_return = 1 then
	if subindex > 0 then 
		li_return = lr_appmenu.getmasteritem(index, subindex, lr_MenuItem)
	else
		li_return = lr_appmenu.getmasteritem( index, lr_MenuItem)
	end if 
//	ls_text = lr_MenuItem.text	
	ls_tag = lr_MenuItem.tag
	if li_return = 1 then		 
		Choose case ls_tag
			case "Quit"
				halt close
			case "Settings"
				open(w_setup)
			case "About"
				open(w_about)
			case "Readme"
				//open(w_help)
				OpenSheet(w_help, w_main, 1, Layered!)
				of_set_actionsbar(true,"Close")
			case "HelpContents"
				of_opensheet("Elevate 2019")
				of_refresh_status("Elevate 2019", true)	
				of_refresh_historymenu()		
				of_set_actionsbar(false,"Action")
				of_set_actionsbar(false,"Print")			
				of_set_actionsbar(true,"Close")
			case ""
				
			case else			

		End Choose		
	end if 
end if 
 







end subroutine

public subroutine of_recentmenuclicked (long itemhandle, long index, long subindex);RibbonApplicationMenu			lr_appmenu
RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text


li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_appmenu)
if li_return = 1 then
	li_return = lr_appmenu.getrecentitem( index, lr_MenuItem)
	if li_return = 1 then
		ls_text = lr_MenuItem.text 
		Choose case ls_text
			case "Address","Customer","Product","Order" 
				of_opensheet(ls_text)
				of_set_actionsbar(true,"All")
//				of_set_actionsbar(false,"Print")		
				of_refresh_status(ls_text, true)	
			case "Statistics"
				of_opensheet(ls_text)
				of_set_actionsbar(true,"All")
				of_set_actionsbar(false,"Action")		
				of_set_actionsbar(false,"View")		
				of_set_actionsbar(false,"Print")		
//				of_set_actionsbar(true,"Close")
				of_refresh_status(ls_text, true)	
			case "Help","Elevate 2019"
				of_opensheet(ls_text)
				of_set_actionsbar(false,"All")				
				of_set_actionsbar(true,"Close")
				of_refresh_status(ls_text, true)	
			case ""
				
			case else			
								
			
		End Choose		
		of_refresh_historymenu()
	end if 
end if 
 







end subroutine

public subroutine of_refresh_historymenu ();w_base								lw_base
RibbonLargeButtonItem			lr_largebutton
Ribbonmenu							lrm_menu
RibbonMenuItem 					lr_MenuItem

string									ls_tag, ls_text, ls_picturename, ls_title
integer								i, li_count, li_return, li_menucount, li_menuitem, li_rtn
boolean								lbn_set_menu, lb_valid
string 								ls_windowsText[]={"Address","Customer","Product","Order","Statistics","Elevate 2019"}		//Help
string 								ls_pic[]={".\image\address.png",".\image\customer.png",".\image\product.png",".\image\order.png",".\image\statistics.png","HelpSmall!"}
string 								ls_pic1[]={".\image\Blue\address_small.png",".\image\Blue\customer_small.png",".\image\Blue\product_small.png",".\image\Blue\order_small.png",".\image\Blue\statistics_small.png",".\image\Elevate.png"}
string 								ls_pic2[]={".\image\Dark\address_small.png",".\image\Dark\customer_small.png",".\image\Dark\product_small.png",".\image\Dark\order_small.png",".\image\Dark\statistics_small.png",".\image\Elevate.png"}

if is_themename = "Blue" then 
	ls_pic = ls_pic1
else
	ls_pic = ls_pic2	
end if 

li_menuitem = 0
li_count = 0
li_menucount = 0

lw_base = this.GetActiveSheet ( )
ls_title = lw_base.title
If IsValid(lw_base) Then
	ls_tag = "Lists"						
	//Get Large Button Object
	li_return = rbb_main.getitembytag(ls_tag, lr_largebutton)
	if li_return = 1 then 
		if lr_largebutton.enabled = false then
			lr_largebutton.enabled = true
			lr_largebutton.defaultcommand = false
		end if 
		li_menucount = upperbound(is_windowslists) 
		li_count = upperbound(ls_windowsText)
		for li_menuitem = 1 to li_menucount
			for i = 1 to li_count
				if is_windowslists[li_menuitem] = ls_windowsText[i] then
					ls_picturename = ls_pic[i]
					ls_text = ls_windowsText[i]
					//Add ribbon menu
					lrm_menu.insertitem( li_menuitem, ls_text, ls_picturename, "ue_menuitemclicked")					
					exit;
				end if				
			next
		next 
		//Add ribbon menu to the Large Button
		lr_largebutton.setmenu( lrm_menu)
		//refresh the Large Button object
		rbb_main.setlargebutton( lr_largebutton.itemhandle , lr_largebutton)
	end if
end if 

end subroutine

public subroutine of_smallbuttonclicked (long itemhandle);RibbonSmallButtonItem			lr_smallbuttonitem
integer								li_return
string									ls_tag, ls_title
w_base								lw_base


lw_base  = this.getactivesheet( )
li_return = rbb_main.GetSmallbutton(itemhandle, lr_smallbuttonitem)
if li_return  = 1 then
	ls_tag = lr_smallbuttonitem.tag
	choose case ls_tag
		case "Close"
			of_closewindow(ls_tag)
		case "Close All"
			of_closewindow(ls_tag)
//		case "Add"
//			//trigger event.
//			//lw_base.event ue_add( )
//			
		case ""
			
		case else
			lw_base.dynamic TriggerEvent("ue_"+ls_tag)
	end choose 
	
end if 


end subroutine

public subroutine of_tabbuttonclicked (long itemhandle);String 							ls_picturename, ls_tag
integer 							li_return
RibbonTabButtonItem 		lr_Tabbuttonitem
w_base							lw_base

li_return = rbb_main.gettabbutton(itemhandle, lr_Tabbuttonitem)
if li_return  = 1 then 
	ls_tag = 	lr_Tabbuttonitem.tag	
	Choose case ls_tag
		case "Tab Minimize"
			If rbb_main.isminimized( ) Then
				rbb_main.setminimized( false)
				ls_picturename ="ArrowUpSmall!"
				gb_expand = True
			Else
				rbb_main.setminimized( true)
				ls_picturename ="ArrowDownSmall!"
				gb_expand = False
			End If
			lr_Tabbuttonitem.picturename = ls_picturename
			li_return = rbb_main.SetTabButton(lr_Tabbuttonitem.itemhandle, lr_Tabbuttonitem)	
			this.event ue_resize( )
			
//			lw_base  = this.getactivesheet( )
//			if isvalid(lw_base)  then 
//				lw_base.windowstate = Maximized!
//			end if
		case "Tab Help"
			//iNet		lo_iNet																									// NO=>use iNet
			//lo_inet	=	CREATE  iNet																						// Instatiate
			//lo_iNet.Hyperlinktourl ("www.appeon.com" )																// Load URL
			//Destroy  lo_iNet																									// Unload

			of_opensheet("Elevate 2019")
			of_refresh_status("Elevate 2019", true)	
			of_refresh_historymenu()		
			of_set_actionsbar(false,"Action")
			of_set_actionsbar(false,"Print")			
			of_set_actionsbar(true,"Close")
		case "Screen Saver"
			of_screensaver()
			
		case ""	
			
		case else
			
	End Choose
End if 
end subroutine

public subroutine of_menuitemclicked (long itemhandle, long index, long subindex);RibbonMenu 						lr_Menu
RibbonMenuItem					lr_MenuItem
integer								li_return
string									ls_text

li_return = rbb_main.getmenubybuttonhandle(itemhandle,lr_Menu)
if li_return = 1 then
	li_return = lr_Menu.getitem(index, lr_MenuItem)
	if li_return = 1 then
		ls_text = lr_MenuItem.text 
		Choose case ls_text			
			case "Address","Customer","Product","Order" 
				of_opensheet(ls_text)
				of_refresh_status(ls_text, true)		
				of_set_actionsbar(true,"All")
//				of_set_actionsbar(false,"Print")			
			case "Statistics"
				of_opensheet(ls_text)
				of_refresh_status(ls_text, true)		
				of_set_actionsbar(true,"All")		
				of_set_actionsbar(false,"Action")
				of_set_actionsbar(false,"View")
				of_set_actionsbar(false,"Print")		
//				of_set_actionsbar(true,"Close")
			case "Help","Elevate 2019"
				of_opensheet(ls_text)
				of_refresh_status(ls_text, true)		
				of_set_actionsbar(false,"Action")
				of_set_actionsbar(false,"View")
				of_set_actionsbar(false,"Print")		
				of_set_actionsbar(true,"Close")
			case else			

		End Choose		
	end if 
end if 
 







end subroutine

public subroutine of_opensheet (string as_window);
choose case as_window
	case "Address"	//Address
		Opensheet(w_address, this, 0, Layered! )
	case "Customer"
		Opensheet(w_person, this, 0, Layered! )
	case "Product"			
		Opensheet(w_product, this, 0, Layered! )		
	case "Order"			
		Opensheet(w_salesorder, this, 0, Layered! )	
	case "Statistics"			
		Opensheet(w_salesreport, this, 0, Layered! )	
	case "Help","Elevate 2019"		
		Opensheet (w_help, this, 0, Layered! )			
	case ""				
		
	case else
		
end choose 
end subroutine

public subroutine of_refresh_status (string as_window, boolean abn_active);RibbonLargeButtonItem			lr_largebuttonitem
string 								ls_windowsTag[]={"Address","Customer","Product","Order","Statistics","Elevate 2019"}
string 								ls_tag, ls_picturename, ls_temp, ls_refreshwindow
integer								i,	li_return,	li_pos, li_count , li_counttag
n_string								ln_string

 
ln_string = create n_string
ln_string.of_arraytostring(ls_windowsTag,",", ls_temp)
//refresh Windows Lists
li_count = upperbound(is_windowslists)
if li_count  > 0 then
	ln_string.of_arraytostring(is_windowslists,",", ls_refreshwindow)
	if right(ls_refreshwindow, 1) <> "," then  ls_refreshwindow = ls_refreshwindow + ","
	li_pos = pos(ls_refreshwindow, as_window+",")
	if li_pos > 0 then
		ls_refreshwindow = ln_string.of_globalreplace(ls_refreshwindow, as_window+",","")
	end if 
	ls_refreshwindow = as_window+","+ls_refreshwindow
	if right(ls_refreshwindow, 1) ="," then ls_refreshwindow = left(ls_refreshwindow, len(ls_refreshwindow) -1)
	ln_string.of_parsetoarray( ls_refreshwindow, ",", is_windowslists)
else
	li_count++
	is_windowslists[li_count] = as_window
end if 

destroy n_string

if right(ls_temp, 1) <> "," then  ls_temp = ls_temp + ","
li_pos = pos(ls_temp, as_window+",")
if isnull(li_pos) or li_pos <= 0 then
	return 
end if 
		
li_counttag = upperbound(ls_windowsTag)		
for i = 1  to li_counttag
	ls_tag = ls_windowsTag[i]
	li_return = rbb_main.getitembytag( ls_tag, lr_largebuttonitem)
	if li_return = 1 then 
		ls_picturename = lr_largebuttonitem.picturename
		if  abn_active  = true then 
			if ls_tag = as_window then
				of_set_largebutton_active(lr_largebuttonitem, true)
			else
				of_set_largebutton_active(lr_largebuttonitem, false)
			end if 
		else			
			of_set_largebutton_active(lr_largebuttonitem, false)
		end if
	end if
next 
	



end subroutine

public subroutine of_add_recentmenu (string as_window);integer 			i , li_win, li_pos
string 			ls_names, ls_recents[]
n_string			ln_string


ln_string = create n_string
li_win = upperbound(is_recents)
if li_win  > 0 then
	ln_string.of_arraytostring(is_recents,",", ls_names)
	ls_names = as_window+","+ls_names
	ln_string.of_parsetoarray( ls_names, ",", is_recents)
	
	//only support have 10 items in the Recent Menu.
	li_win = upperbound(is_recents)
	if li_win > 10 then
		for i = 1 to 10
			ls_recents[i]= is_recents[i]
		next 
		is_recents = ls_recents
	end if 
else
	li_win++
	is_recents[li_win] = as_window
end if 

destroy ln_string
end subroutine

public subroutine of_add_windows (string as_window);integer 			li_win, li_pos
string 			ls_names
n_string			ln_string


ln_string = create n_string
li_win = upperbound(is_windows)
if li_win  > 0 then
	ln_string.of_arraytostring(is_windows,",", ls_names)
	if right(ls_names, 1) <> "," then  ls_names = ls_names + ","
	li_pos = pos(ls_names, as_window+",")
	if li_pos > 0 then
		ls_names = ln_string.of_globalreplace(ls_names, as_window+",","")
	end if 
	ls_names = as_window+","+ls_names
	if right(ls_names, 1) ="," then ls_names = left(ls_names, len(ls_names) -1)
	ln_string.of_parsetoarray( ls_names, ",", is_windows)
else
	li_win++
	is_windows[li_win] = as_window
end if 

destroy ln_string


//add recentmenu
//of_add_recentmenu(as_window)

end subroutine

public subroutine of_set_largebutton_active (ribbonlargebuttonitem ar_largebuttonitem, boolean abn_active);string					ls_picturename

ls_picturename = ar_largebuttonitem.picturename
if abn_active then
	if right(ls_picturename, len("_active.png")) <> "_active.png" then
		ls_picturename = left(ls_picturename, len(ls_picturename) - len(".png")) + "_active.png"
		ar_largebuttonitem.picturename = ls_picturename
		rbb_main.setlargebutton(ar_largebuttonitem.itemhandle, ar_largebuttonitem)	
	end if 
else
	if right(ls_picturename, len("_active.png")) = "_active.png" then
		ls_picturename = left(ls_picturename, len(ls_picturename) - len("_active.png")) + ".png"
		ar_largebuttonitem.picturename = ls_picturename
		rbb_main.setlargebutton(ar_largebuttonitem.itemhandle, ar_largebuttonitem)	
	end if
end if 
end subroutine

public subroutine of_set_item_enabled (string as_tag, integer ai_type, boolean ab_flag);RibbonLargeButtonItem	lr_LargeButton
RibbonSmallButtonItem 	lr_SmallButton
RibbonCheckBoxItem 		lr_Checkbox
RibbonComboBoxItem		lr_Combobox
integer 						li_return

//ai_type = 2							// Large Button 1, Small Button 2, combo box 3, check box 4
Choose case ai_type
	case 1
		//Get Large Button Object
		li_return = rbb_main.getitembytag( as_tag,lr_LargeButton)			
		if li_return = 1 then
			if lr_LargeButton.enabled <> ab_flag then 
				//Enable the Large Button 
				lr_LargeButton.enabled = ab_flag
				//refresh the Large Button object
				rbb_main.setlargebutton(lr_LargeButton.itemhandle, lr_LargeButton ) 
			end if 
		end if 
	case 2
		//Get Small Button Object
		li_return = rbb_main.getitembytag(as_tag,lr_SmallButton)
		if li_return = 1 then
			if lr_SmallButton.enabled <> ab_flag then 
				//Enable the Small Button 
				lr_SmallButton.enabled = ab_flag
				//refresh the Small Button object
				rbb_main.setsmallbutton( lr_SmallButton.itemhandle , lr_SmallButton)
			end if 
		end if 	
	case 3
		//Get combo box Object
		li_return = rbb_main.getitembytag( as_tag,lr_Combobox)
		if li_return = 1 then
			if lr_Combobox.enabled <> ab_flag then 
				//Enable the combo box
				lr_Combobox.enabled = ab_flag
				//refresh the combo box object
				rbb_main.setcombobox(lr_Combobox.itemhandle, lr_Combobox ) 
			end if 
		end if	
	case 4
		//Get check box Object
		li_return = rbb_main.getitembytag(as_tag,lr_Checkbox)
		if li_return = 1 then
			if lr_Checkbox.enabled <> ab_flag then 
				//Enable the check box
				lr_Checkbox.enabled = ab_flag
				//refresh the check box object
				rbb_main.setcheckbox(lr_Checkbox.itemhandle, lr_Checkbox ) 
			end if 
		end if	
	case else
		//
End Choose 

end subroutine

public subroutine of_set_actionsbar (boolean ab_flag, string as_panel);emf_str_ribbonbaritem	lstr_item[]
integer						i, li_count, li_itemcount

//as_panel = 2							//largebutton 1, smallbutton 2, Combobox 3, Checkbox 4
Choose case as_panel
	case "All"
		of_add_items(lstr_item, "Add" ,2)
		of_add_items(lstr_item, "Delete" ,2)
//		of_add_items(lstr_item, "Edit" ,2)
		of_add_items(lstr_item, "Save" ,2)
		of_add_items(lstr_item, "Export" ,2)		
		of_add_items(lstr_item, "Cancel" ,2)		
		of_add_items(lstr_item, "First" ,2)
		of_add_items(lstr_item, "Prior" ,2)
		of_add_items(lstr_item, "Next" ,2)
		of_add_items(lstr_item, "Last" ,2)
//		of_add_items(lstr_item, "Sort" ,2)
		of_add_items(lstr_item, "Filter" ,2)		
		of_add_items(lstr_item, "Print" ,1)
		of_add_items(lstr_item, "Page Size" ,3)
		of_add_items(lstr_item, "Preview" ,2)
		of_add_items(lstr_item, "Print Title" ,4)
		of_add_items(lstr_item, "Close All" ,2)
		of_add_items(lstr_item, "Close" ,2)
	case "Action"
		of_add_items(lstr_item, "Add" ,2)
		of_add_items(lstr_item, "Delete" ,2)
		of_add_items(lstr_item, "Edit" ,2)
		of_add_items(lstr_item, "Save" ,2)
		of_add_items(lstr_item, "Export" ,2)	
		of_add_items(lstr_item, "Cancel" ,2)		
	case "View"		
		of_add_items(lstr_item, "First" ,2)
		of_add_items(lstr_item, "Prior" ,2)
		of_add_items(lstr_item, "Next" ,2)
		of_add_items(lstr_item, "Last" ,2)
		of_add_items(lstr_item, "Sort" ,2)
		of_add_items(lstr_item, "Filter" ,2)		
	case "Close"
		of_add_items(lstr_item, "Close All" ,2)
		of_add_items(lstr_item, "Close" ,2)
	case "Print"
		of_add_items(lstr_item, "Print" ,1)
		of_add_items(lstr_item, "Page Size" ,3)
		of_add_items(lstr_item, "Preview" ,2)
		of_add_items(lstr_item, "Print Title" ,4)
	case else
		
End Choose 

li_count = upperbound(lstr_item)
If li_count > 0 then
	for i = 1 to li_count
		of_set_item_enabled(lstr_item[i].s_tag, lstr_item[i].i_type,  ab_flag)
	next 
end if 


end subroutine

public subroutine of_add_items (ref emf_str_ribbonbaritem astr_item[], string as_tag, integer ai_type);integer			li_countitem

li_countitem = upperbound(astr_item)
li_countitem++
astr_item[li_countitem].s_tag = as_tag
astr_item[li_countitem].i_type = ai_type
end subroutine

public subroutine of_refresh_ribbonbartheme ();string 								ls_windowsText[]={"Address","Customer","Product","Order","Statistics"}	//,"Help"
RibbonLargeButtonItem			lr_LargeButton, lr_LargeButtonList
Ribbonmenu							lrm_menu
RibbonMenuItem 					lr_MenuItem
integer								i,	li_return,	li_pos, li_count, li_menucount
n_string								ln_string
string									ls_tag, ls_pic, ls_temp

if is_themeold <> is_themename then
	//refresh largebutton		
	ln_string = create n_string
	li_count = upperbound(ls_windowsText)
	for i =1 to li_count
		ls_tag = ls_windowsText[i]
		li_return = rbb_main.getitembytag(ls_tag, lr_largebutton)
		if li_return = 1 then
			ls_pic = lr_largebutton.picturename
			li_pos = pos(ls_pic, "\"+is_themename+"\") 
			if li_pos <= 0  then
				ls_pic = ln_string.of_globalreplace(ls_pic,"\"+ is_themeold+"\","\"+is_themename+"\")
				lr_largebutton.picturename = ls_pic
				rbb_main.setlargebutton( lr_largebutton.itemhandle , lr_largebutton)
			end if 
		end if 		
	next
	
	//refresh history menuitem
	ls_tag = "Lists"			
	li_return = rbb_main.getitembytag(ls_tag, lr_LargeButtonList)
	li_return = lr_LargeButtonList.getmenu( lrm_menu)
	li_menucount =  lrm_menu.getitemcount( )
	if li_return = 1 and  li_menucount > 0 then 
		for i =1 to li_menucount
			li_return = lrm_menu.getitem( i, lr_MenuItem)
			if li_return = 1 then 
				ls_pic = lr_MenuItem.picturename
				li_pos = pos(ls_pic, "\"+is_themename+"\") 
				if li_pos <= 0  then
					ls_pic = ln_string.of_globalreplace(ls_pic,"\"+ is_themeold+"\","\"+is_themename+"\")
					lr_MenuItem.picturename = ls_pic
					lrm_menu.setitem( i , lr_MenuItem)
				end if 
			end if 
		next
		lr_LargeButtonList.setmenu( lrm_menu)
		rbb_main.setlargebutton( lr_LargeButtonList.itemhandle , lr_LargeButtonList)
	end if 
	destroy ln_string
end if 

//reset
is_themeold = is_themename
end subroutine

public function string of_refreshtheme ();String 								ls_themename 


ls_themename = GetTheme()
Choose case ls_themename
	case "Flat Design Blue"
		is_themename = "Blue"
	case "Flat Design Dark"
		is_themename = "Dark"
	case "Flat Design Grey"
		is_themename = "Grey"
	case "Flat Design Silver"
		is_themename = "Silver"
	case  else
		is_themename = "Blue"			//default 
End Choose 


return is_themename
end function

public subroutine of_screensaver ();nvo_apiclass					ln_apiclass


ln_apiclass = create nvo_apiclass
ln_apiclass.of_lockworkstation( )
destroy ln_apiclass 
end subroutine

public subroutine of_closewindow (string as_type);w_base			lw_base
string 			ls_title 

lw_base  = this.getactivesheet( )
if IsValid(lw_base) then 
	//Get current window title
	ls_title = lw_base.title				
	If as_type = "Close All" then			
		do 
			Close(lw_base)
			lw_base = this.getfirstsheet()			
		Loop while IsValid(lw_base)
		of_set_actionsbar(false,"All")
		of_refresh_status(ls_title, false)
	else		
		//close current window
		Close(lw_base)
		lw_base = this.getfirstsheet()
		if not isvalid(lw_base) then
			of_set_actionsbar(false,"All")
			of_refresh_status(ls_title, false)
		else
			//set false status for the close window
			of_refresh_status(ls_title, false)
			ls_title = lw_base.title	
			//refresh the firstsheet window.
			of_refresh_status(ls_title, true)
			if ls_title ="Statistics" or ls_title ="Elevate 2019" or ls_title = "Help"then
				of_set_actionsbar(false,"Action")		
				of_set_actionsbar(false,"View")		
				of_set_actionsbar(false,"Print")
			else
				of_set_actionsbar(True,"Action")		
				of_set_actionsbar(True,"View")		
				of_set_actionsbar(True,"Print")
			end if 
		end if 
	end if 
end if 
end subroutine

on w_main.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.mdi_1=create mdi_1
this.rbb_main=create rbb_main
this.Control[]={this.mdi_1,&
this.rbb_main}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rbb_main)
end on

event resize;this.event ue_resize( )

if sizetype  = 1 then	//minimized!
//	this.event ue_tray()
end if 

end event

event open;rbb_main.importfromxmlfile( "RibbonBar_show.xml" )	

is_themeold = of_refreshtheme( )
of_refresh_ribbonbartheme()
end event

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

type rbb_main from ribbonbar within w_main
event ue_largebuttonclicked ( long itemhandle )
event ue_mastermenuclicked ( long itemhandle,  long index,  long subindex )
event ue_recentmenuclicked ( long itemhandle,  long index,  long subindex )
event ue_smallbuttonclicked ( long itemhandle )
event ue_tabbuttonclicked ( long itemhandle )
event ue_menuitemclicked ( long itemhandle,  long index,  long subindex )
integer width = 3931
integer height = 492
long backcolor = 15132390
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event ue_largebuttonclicked(long itemhandle);of_largebuttonclicked(itemhandle)
end event

event ue_mastermenuclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_mastermenuclicked( itemhandle, index,subindex)
end event

event ue_recentmenuclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_recentmenuclicked( itemhandle, index,subindex)
end event

event ue_smallbuttonclicked(long itemhandle);of_smallbuttonclicked(itemhandle)
end event

event ue_tabbuttonclicked(long itemhandle);of_tabbuttonclicked(itemhandle)
end event

event ue_menuitemclicked(long itemhandle, long index, long subindex);//•	ItemHandle. The handle of the button the menu associated with.
//•	Index.The index of the menu item clicked. 
//•	SubIndex. The index of the submenu item clicked. 0 
//ReturnValues
//Long.
//Return code choices (specify in a RETURN statement):
//0 -- Continue processing
//

of_menuitemclicked( itemhandle, index,subindex)
end event

