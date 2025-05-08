$PBExportHeader$n_smtpclient.sru
forward
global type n_smtpclient from smtpclient
end type
end forward

global type n_smtpclient from smtpclient
end type
global n_smtpclient n_smtpclient

event onsendfinished;//Get the result here
//Messagebox('On Send Finshed Event','Handle =' + String(al_handle) + ', Number= ' + String(ai_number) + ", Text = " + as_text)
end event

on n_smtpclient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_smtpclient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

