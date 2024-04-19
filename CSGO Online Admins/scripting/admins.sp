#pragma semicolon 1

#define DEBUG

#include <sourcemod>
#include <sdktools>


public void OnPluginStart()
{
	RegAdminCmd("sm_admins", admins, ADMFLAG_ROOT);
}

public Action admins(int client, int args){
	Menu menu = new Menu(menu_callback);
	menu.SetTitle("Online Admins : ");
	for (int i = 1; i <= GetMaxClients(); i++){
		if (CheckCommandAccess(i, "hahaadminsgobrr", ADMFLAG_GENERIC))
		{
			char text[10];
			IntToString(i, text, sizeof(text));
			char text2[512];
			GetClientName(i, text2, sizeof(text));
			
			menu.AddItem(text,text2);
		}
	}
	menu.Display(client,MENU_TIME_FOREVER);
}
public int menu_callback(Menu menu, MenuAction action,int param1,int param2){
	switch (action){
		case MenuAction_Select:
		{

		}
		case MenuAction_End:
		{			
			delete menu;
		}
		case MenuAction_Cancel:
		{
				 
		}
		
	}
}