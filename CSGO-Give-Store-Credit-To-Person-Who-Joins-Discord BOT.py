import discord
import random
from discord.ext import commands

client = commands.Bot(command_prefix = "." )

@client.event
async def on_ready():
    await client.change_presence(status=discord.Status.online,activity=discord.Game(".needhelp"))
    print("bot hazir")
@client.command(aliases=["discordcredit"])
async def ezs(ctx,*,msg):
    if("STEAM_" not in msg):
        await ctx.send("you didnt't write your Steam ID ")
        return
    if(len(msg) != 19 and len(msg) != 18):
        await ctx.send("you didnt't write your Steam ID ")
        return
    if(len(msg) == 18):
        msg=msg+"X"
    liste1=["2","3","5","7"]
    liste2=["1","4","6","8","9"]
    aranan=msg+msg[8]+str(random.randint(2,14)*7)+str(random.randint(8,76)*13)+random.choice(liste1)+random.choice(liste2)+msg[11]+msg[14]+msg[17];
    await ctx.send("your code has given you by your dm")
    await ctx.author.send("your in game code: **"+aranan+"** in order to get your credit you need to type **!discordcredit "+aranan +"** in game chat")
@client.command(aliases=["needhelp"])
async def krediverbanaa(ctx):

    await ctx.send("You need to type your steamid like this : .discordcredit STEAMIDHERE") 
client.run("BOTTOKENHERE")
