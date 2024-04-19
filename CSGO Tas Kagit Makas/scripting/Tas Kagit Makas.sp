#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "pr0mers"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
int kisiler[MAXPLAYERS + 1];
int secim[MAXPLAYERS + 1];
int iptal[MAXPLAYERS + 1];

public Plugin myinfo = 
{
	author = "pr0mers",
	description = "tas kagit makas plugini",
	version = PLUGIN_VERSION
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_tkm", taskagitmakas);
	RegConsoleCmd("sm_tkmiptal", ibidal);
	RegAdminCmd("sm_tkmdebug", tkmdebugla,ADMFLAG_ROOT);
}
public Action tkmdebugla(int client,int args){
	for (int i = 1; i < MaxClients; i++)
	{
		if(IsClientInGame(i)==true)
		{
			
			PrintToConsole(client, "kisi: %d , Eslesme: %d , secim : %d", i, kisiler[i], secim[i]);
		}
	}
}
public Action taskagitmakas(int client,int args){
	int baslatankisi = client;
	char text1[512];
    char text0[512];
    GetCmdArg(1, text1, sizeof(text1));
	int playersConnected = GetMaxClients();
    int bulduk = 0;
	for (int i = 1; i < playersConnected; i++)
	    {
	        if(IsClientInGame(i)==true)
	        {
	            GetClientName(i, text0, sizeof(text0));
	            if (StrContains(text0, text1, false)!=-1){
	            	if(bulduk!=0){
	            		return;
	            	}
	           		bulduk = i;
	           	}
	        }
	}
	if(bulduk == 0){
		PrintToChat(client,"Kimseyle eşleşmedi");
		return;
	}
	if(iptal[bulduk]==1){
		PrintToChat(client,"Davet atmaya çalıştığınız kişi Taş Kağıt Makas davetlerini engellemiş");
		return;
	}
	int asilhedef = bulduk;
	if(kisiler[client]!=0 || kisiler[bulduk]!=0){
		PrintToChat(client, "Zaten baska biriyle oynuyor sonra tekrar dene");
	}
	PrintToChat(asilhedef, "%N adlı kişi sana taş kağıt makasda meydan okudu kabul edicekmisin?", baslatankisi);
	PrintToChat(baslatankisi, "%N adlı kişiye meydan okundu.", asilhedef);
	sifirla(baslatankisi);
	kisiler[baslatankisi] = asilhedef;
	kisiler[asilhedef] = baslatankisi;
	evethayirmenu(baslatankisi,asilhedef);
}
public evethayirmenu(int baslatan,int hedef){
	Menu menu = new Menu(Menu_Callback);
	menu.SetTitle("%N adlı kişi sana taş kağıt makasda meydan okudu kabul edecekmisin?",baslatan);
	menu.AddItem("evet", "Evet");
	menu.AddItem("hayır", "Hayır");
	menu.ExitButton = false;
	menu.Display(hedef, 60);
	return;
}
public int Menu_Callback(Menu menu, MenuAction action,int param1,int param2){
	switch (action){
		case MenuAction_Select:
		{   
			char item[64];
			menu.GetItem(param2, item, sizeof(item));
			if(StrEqual(item,"evet")){
				taskagitmakasmenusu(param1,kisiler[param1]);
			}
			else{
			    sifirla(param1);
				PrintToChatAll("%N taş kağıt makası kabul etmedi! Korkak tavuk!", param1);
				
			}
		}
		case MenuAction_End:
		{			
			//PrintToChatAll("Menusilindievethayir");
			delete menu;
		}
		case MenuAction_Cancel:
		{
			PrintToChatAll("%N isimli kişi taş kağıt makasdan kaçtı", param1);
			sifirla(param1);
		}
		
	}
}
public void taskagitmakasmenusu(int hedef,int yapan){
	Menu menu = new Menu(Menu_Callback2);
	menu.SetTitle("Taş Kağıt Makas Menüsü");
	menu.AddItem("tas", "Taş");
	menu.AddItem("kagit", "Kağıt");
	menu.AddItem("makas", "Makas");
	menu.ExitButton = false;
	menu.Display(hedef, 60);
	menu.Display(yapan, 60);
	
}
public int Menu_Callback2(Menu menu, MenuAction action,int param1,int param2){
	switch (action){
		case MenuAction_Select:
		{  
			char item[64];
			menu.GetItem(param2, item, sizeof(item));
			//PrintToChatAll("%d", param1);
			
			if(StrEqual(item,"tas")){
				
				secim[param1] = 1;
			}
			if(StrEqual(item,"kagit")){
				
				secim[param1] = 2;
			}
			if(StrEqual(item,"makas")){
			
				secim[param1] = 3;
			}	
			if(secim[param1]!=0 && secim[kisiler[param1]]!=0){
				//PrintToChatAll("Menusilindi2kisisecdi");
				delete menu;
			}
			secimyapildi(param1);
		}
		case MenuAction_End:
		{
			if(param1 != MenuEnd_Selected){
				//PrintToChatAll("iptalsilindi");
				delete menu;
			}
			
		}
		case MenuAction_Cancel:
		{
			PrintToChat(param1,"Taş Kağıt Makas İptal Oldu");
			sifirla(param1);
		}
	}
}
public void secimyapildi(int client){
	int baslatansecim = secim[client];
	int hedefsecim = secim[kisiler[client]];
	char text1[256];
   	char text0[256];
	GetClientName(client, text1, sizeof(text1));
	GetClientName(kisiler[client], text0, sizeof(text0));
	if(baslatansecim != 0 && hedefsecim!=0){
		char bassec[10];
		char hedsec[10];
		if(baslatansecim == 1){
			bassec = "Taş";
		}
		if(baslatansecim== 2){
			bassec = "Kağıt";
		}
		if(baslatansecim == 3){
			bassec = "Makas";
		}
		if(hedefsecim == 1){
			hedsec = "Taş";
		}
		if(hedefsecim== 2){
			hedsec = "Kağıt";
		}
		if(hedefsecim == 3){
			hedsec = "Makas";
		}
		if(hedefsecim==baslatansecim){
			PrintToChatAll("Berabere! 2 Oyuncununda seçimi %s idi", hedsec);
			
		}
		if(hedefsecim==1 && baslatansecim==2){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text1, text1, bassec, text0, hedsec);
		}
		if(hedefsecim==1 && baslatansecim==3){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text0, text0, hedsec, text1, bassec);
		}
		if(hedefsecim==2 && baslatansecim==1){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text0, text0, hedsec, text1, bassec);
		}
		if(hedefsecim==2 && baslatansecim==3){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text1, text1, bassec, text0, hedsec);
		}
		if(hedefsecim==3 && baslatansecim==1){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text1, text1, bassec, text0, hedsec);
		}
		if(hedefsecim==3 && baslatansecim==2){
			PrintToChatAll("Kazanan :%s-%s in seçimi %s, %s in seçimi %s idi", text0, text0, hedsec, text1, bassec);
		}
		sifirla(client);
		
	}
	else{
		//PrintToChatAll("herkes secmedi");
	}
}
public OnClientDisconnect(int client){
	iptal[client] = 0;
	sifirla(client);
}
public sifirla(int client){
		secim[client] = 0;
		secim[kisiler[client]] = 0;
		kisiler[kisiler[client]] = 0;
		kisiler[client] = 0;
}
public Action ibidal(int client,int args){
	if(iptal[client]==0){
		PrintToChat(client, "Taş Kağıt Makas davetlerini iptal ettiniz artık kimse size xox daveti atamayacak, bir daha !xoxiptal yazarsanız davet atabilirler");
		iptal[client] = 1;
	}
	else if(iptal[client]==1){
		PrintToChat(client, "Taş Kağıt Makas davetlerinin iptalini kaldırdınız artık xox daveti alabileceksiniz, bir daha !xoxiptal yazarsanız artık davet atamazlar");
		iptal[client] = 0;
	}
}