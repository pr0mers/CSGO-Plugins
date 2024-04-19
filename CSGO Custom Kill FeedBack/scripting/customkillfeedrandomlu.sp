#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR ""
#define PLUGIN_VERSION "0.00"

#include <sourcemod>
#include <sdktools>

int liste[MAXPLAYERS + 1];
//int listebicak[MAXPLAYERS + 1];
char dizi[][] =  {"boom","fish","fuck","hat","kick","pickaxe","piss","skull2","random"};
public void OnPluginStart()
{
	HookEvent("player_death", playerdied, EventHookMode_Pre);
	RegAdminCmd("sm_killfeedmenu", killfeedmenu,ADMFLAG_ROOT ,"killfeedmenu");
}
public void OnMapStart()
{
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/boom.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/fish.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/fuck.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/hat.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/kick.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/pickaxe.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/piss.svg");
	//AddFileToDownloadsTable("materials/panorama/images/icons/equipment/skull.svg");
	AddFileToDownloadsTable("materials/panorama/images/icons/equipment/skull2.svg");
	//AddFileToDownloadsTable("materials/panorama/images/icons/equipment/gulucuk.svg");
}
//CheckCommandAccess(iClient, "adminmi", ADMFLAG_CONVARS)
public Action playerdied(Event event, const String:name[], bool:dontBroadcast){
	char wpn[192];
	GetEventString(event,"weapon", wpn,sizeof(wpn));
    int iClient = GetClientOfUserId(event.GetInt("attacker"));
    //PrintToChatAll("Silah: %s , kişi: %N, seçim: %d", wpn,iClient,liste[iClient]);
    if(!iClient || liste[iClient]==0)
        return Plugin_Continue;
	//PrintToChatAll(dizi[liste[iClient]]);
	
	if(liste[iClient]==9){
		int sayi = GetRandomInt(0,7);
		//dizi[0] = dizi[1];
		SetEventString(event, "weapon", dizi[sayi]);
	}
	else{
		SetEventString(event, "weapon", dizi[liste[iClient]-1]);
	}
	return Plugin_Changed;
}
public Action killfeedmenu(int client,int args){
	Menu menu = new Menu(Menu_Callback,MenuAction_Display);
	menu.SetTitle("Killfeed Menüsü");
	menu.AddItem("0","varsayılan");
	menu.AddItem("1","boom");
	menu.AddItem("2","fish");
	menu.AddItem("3","fuck");
	menu.AddItem("4","hat");
	menu.AddItem("5","kick");
	menu.AddItem("6","pickaxe");
	menu.AddItem("7","piss");
	menu.AddItem("8","skull2");
	menu.AddItem("9","random");
	menu.Display(client,MENU_TIME_FOREVER);
}
public int Menu_Callback(Menu menu, MenuAction action,int param1,int param2){
	switch (action){
		case MenuAction_Select:
		{
			char item[64];
			menu.GetItem(param2, item, sizeof(item));
			int sayi = StringToInt(item);
			liste[param1] = sayi;
			//PrintToChatAll("kişi %N, sayı: %d", param1, sayi);
		}
		case MenuAction_End:
		{
			delete menu;
		}	
	}
	
}
public OnClientDisconnect(int client){
	liste[client] = 0;
}