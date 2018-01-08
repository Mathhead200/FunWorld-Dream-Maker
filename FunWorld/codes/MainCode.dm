

proc
	setName()
		usr.name=input(usr,"Name?","Save / Load")
		while(usr.name=="")
			usr.name=input(usr,"Name?","Save / Load")

	CutDownTo(a,b)
		if(a>b)
			a=b
		return a

	Death()
		usr.HP=1
		usr.Exp/=1.5
		usr.Exp=round(usr.Exp, 1)
		usr.Goldians = round( (usr.Goldians/10), 1)
		AddTime( 120 )
		usr.Move(locate(/turf/MyMat))

	Win(a,b)
		if(a=="Giant Bug")
			new /obj/Notepad(b)
		if(a=="Bandit Theif")
			new /obj/Goldians/Pile(b)

	AddTime(a)
		for(var/i=0; i<a; i++)
			usr.Clock++
			while( usr.Clock >= (1440) )
				usr.Clock-=1440
				AddDay(1)

	AddDay(a)
		for(var/i=0; i<a; i++)
			switch(usr.Day)
				if("Sun")
					usr.Day="Mon"
				if("Mon")
					usr.Day="Tue"
				if("Tue")
					usr.Day="Wed"
				if("Wed")
					usr.Day="Thu"
				if("Thu")
					usr.Day="Fri"
				if("Fri")
					usr.Day="Sat"
				if("Sat")
					usr.Day="Sun"
	ConvertClock(a)
		var
			Hour
			Min1
			Min2
		Hour = round( (a / 60)-0.5, 1)
		Min2 = a % 60
		Min1 = round( (Min2 / 10)-0.5, 1)
		Min2 %= 10
		return "[Hour]:[Min1][Min2]"

	FindHours(a)
		return round( (a / 60)-0.5, 1)


mob
	icon='icons/me.dmi'
	icon_state="Main"
	text="<font color=#ff6600>*<font color=#ff7700>*<font color=#ff8800>*<font color=#ff9900>*<font color=#ffaa00>*<font color=#ffbb00>*<font color=#ffcc00>*<font color=#ffbb00>*<font color=#ffaa00>*<font color=#ff9900>*<font color=#ff8800>*<font color=#ff7700>*"

	var
		savefile
		DogWithYou=0
		MPdrain
		Clock=0
		Day="Sun"
		Bank=50
		Note1="Use the Notepad by typing \"Note\" in the command line (light pink) area."
		Note2="The first text-box is for what line you are writing on (1-9)."
		Note3="The second text-box is for the note itself or the message."
		Note4="If you wanted the note \"Cool\" in line 1, first you would type \"Note\""
		Note5="Then in th first text-box you would type \"1\""
		Note6="Last inthe second text-box you would type \"Cool\""
		Note7="Go ahead and try it if you want."
		Note8="Becareful though, if you write to a line with a message already it will over-write that line!"
		Note9="TRY WRITING A NOTE ON THIS LINE (9)"

		HP=20
		MaxHP=20
		MaxAtt=1
		MinAtt=0
		MaxBlock=0
		MinBlock=0
		Speed=1
		MP=10
		MaxMP=10
		MaxMagicAtt=2
		MinMagicAtt=1
		MaxMagicBlock=0
		MinMagicBlock=0
		MagicSpeed=0
		Exp=0

		Goldians=0
		Potions=0
		MajorPotions=0
		VitalPotions=0
		MPotions=0
		MajorMPotions=0
		VitalMPotions=0

		Weapon="Fist"
		MagicWeapon="Mind"

		Notepad=0
		Watch=0
		ShopPackage=0

		KeyBill=0

		missionBillMay1=1
		missionBillMay2=0
		missionBillMay3=1
		missionShop1=0
		missionShop2=0

		eventStickTownGuard=0

	Login()
		usr.Move(locate(/turf/MyMat))
		client.view=2
		//setName()
		..()

	New()
		while(1)
			sleep(10)
			src.Clock+=1
			while( usr.Clock >= (1440) )
				usr.Clock-=1440
				AddDay(1)

	Stat()
		statpanel("Main Screen")
		stat("HP","[usr.HP]/[usr.MaxHP]")
		stat("MP","[usr.MP]/[usr.MaxMP]")
		stat("Exp","[usr.Exp]")
		stat("Goldians","[usr.Goldians]")
		if(usr.Watch==1)
			stat("Watch","[ConvertClock(usr.Clock)]")

		statpanel("Invintory")
		stat("Physical Weapon","[usr.Weapon]")
		stat("Magic Weapon","[usr.MagicWeapon]")
		if(usr.Potions>0)
			stat("Potions","[usr.Potions]")
		if(usr.MajorPotions>0)
			stat("Major Potions","[usr.MajorPotions]")
		if(usr.VitalPotions>0)
			stat("Vital Potions","[usr.VitalPotions]")
		if(usr.MPotions>0)
			stat("M-Potions","[usr.MPotions]")
		if(usr.MajorMPotions>0)
			stat("Major M-Potions","[usr.MajorMPotions]")
		if(usr.VitalMPotions>0)
			stat("Vital M-Potions","[usr.VitalMPotions]")

		statpanel("Attributes")
		stat("HP ([usr.MaxHP/2+1])","")
		stat("Physical Attack","[usr.MinAtt] - [usr.MaxAtt]" +"\n"+ "( [ (usr.MinAtt+1)*25 ] - [ (usr.MaxAtt+1)*10 ] )")
		stat("Physical Block","[usr.MinBlock] - [usr.MaxBlock]" +"\n"+ "( [ (usr.MinBlock+1)*25 ] - [ (usr.MaxBlock+1)*10 ] )")
		stat("Physical Speed","[usr.Speed]" +"\n"+ "( [(usr.Speed+1)*10] )")
		stat("MP ([usr.MaxMP+2])","")
		stat("Magic Attack","[usr.MinMagicAtt] - [usr.MaxMagicAtt]" +"\n"+ "( [ (usr.MinMagicAtt+1)*25 ] - [ (usr.MaxMagicAtt+1)*10 ] )")
		stat("Magic Block","[usr.MinMagicBlock] - [usr.MaxMagicBlock]" +"\n"+ "( [ (usr.MinMagicBlock+1)*25 ] - [ (usr.MaxMagicBlock+1)*10 ] )")
		stat("Magic Speed","[usr.MagicSpeed]" +"\n"+ "( [(usr.MagicSpeed+1)*10] )")

		if(usr.Notepad==1)
			statpanel("Notepad")
			stat("1.","[usr.Note1]")
			stat("2.","[usr.Note2]")
			stat("3.","[usr.Note3]")
			stat("4.","[usr.Note4]")
			stat("5.","[usr.Note5]")
			stat("6.","[usr.Note6]")
			stat("7.","[usr.Note7]")
			stat("8.","[usr.Note8]")
			stat("9.","[usr.Note9]")


	proc
		changeView(a)
			client.view=a

	verb
		Note(a as text, b as text)
			set hidden=1
			if(usr.Notepad==1)
				switch(a)
					if("1") usr.Note1="[b]"
					if("2") usr.Note2="[b]"
					if("3") usr.Note3="[b]"
					if("4") usr.Note4="[b]"
					if("5") usr.Note5="[b]"
					if("6") usr.Note6="[b]"
					if("7") usr.Note7="[b]"
					if("8") usr.Note8="[b]"
					if("9") usr.Note9="[b]"
			else
				alert(usr,"I have nothing to write on.","Note")

		Use_Potions()
			switch( alert(usr,"What type of potion?","Potion","Physical","Magic","Never Mind") )
				if("Physical")
					switch( alert(usr,"What stregth potion?","Potion","Potion","Major Potion","Vital Potion") )
						if("Potion")
							if(usr.Potions>0)
								usr.Potions--
								usr.HP+=25
								usr.HP=CutDownTo(usr.HP, usr.MaxHP)
								usr<<"<font color=#0000aa>...Tasty..."
							else
								alert(usr,"I have no Potions!","Potion")
						if("Major Potion")
							if(usr.MajorPotions>0)
								usr.MajorPotions--
								usr.HP+=100
								usr.HP=CutDownTo(usr.HP, usr.MaxHP)
								usr<<"<font color=#0000aa>...Refreshing..."
							else
								alert(usr,"I have no Major Potions!","Potion")
						if("Vital Potion")
							if(usr.VitalPotions>0)
								usr.VitalPotions--
								usr.HP=usr.MaxHP
								usr<<"<font color=#0000aa>I feel 100%"
							else
								alert(usr,"I have no Vital Potions!","Potion")


				if("Magic")
					switch( alert(usr,"What stregth potion?","Potion","M-Potion","Major M-Potion","Vital M-Potion") )
						if("M-Potion")
							if(usr.MPotions>0)
								usr.MPotions--
								usr.MP+=25
								usr.MP=CutDownTo(usr.MP, usr.MaxMP)
								usr<<"<font color=#00aa00>YUK!!!"
							else
								alert(usr,"I have no M-Potions!","Potion")
						if("Major M-Potion")
							if(usr.MajorMPotions>0)
								usr.MajorMPotions--
								usr.MP+=100
								usr.MP=CutDownTo(usr.MP, usr.MaxMP)
								usr<<"<font color=#00aa00>Only tastes a bit worse then it looks..."
							else
								alert(usr,"I have no Major M-Potions!","Potion")
						if("Vital M-Potion")
							if(usr.VitalMPotions>0)
								usr.VitalMPotions--
								usr.MP=usr.MaxMP
								usr<<"<font color=#00aa00>'Funky' fresh? Ephasis on 'Funky'!"
							else
								alert(usr,"I have no Vital M-Potions!","Potion")

		/*
		Check_Stats()
			usr<<"<font color=red>~ [usr.name]'s Stats ~"
			usr<<"<font color=blue>-General-"
			usr<<"[usr.HP]/[usr.MaxHP] HP"
			usr<<"[usr.MP]/[usr.MaxMP] MP"
			usr<<"[usr.Exp] Exp"
			usr<<"<font color=blue>-Invintory-"
			usr<<"([usr.Goldians]) Goldians"
			if(usr.Potions>0)
				usr<<"([usr.Potions]) Potions"
			if(usr.MajorPotions>0)
				usr<<"([usr.MajorPotions]) Major Potions"
			if(usr.VitalPotions>0)
				usr<<"([usr.VitalPotions]) Vital Potions"
			if(usr.MPotions>0)
				usr<<"([usr.MPotions]) M-Potions"
			if(usr.MajorMPotions>0)
				usr<<"([usr.MajorMPotions]) Major M-Potions"
			if(usr.VitalMPotions>0)
				usr<<"([usr.VitalMPotions]) Vital M-Potions"
			usr<<"<font color=blue>-Battle Attributes (Exp for next level)-"
			usr<<"[usr.MinAtt]-[usr.MaxAtt] Physical Attack <font color=red>([ (usr.MinAtt+1)*25 ]-[ (usr.MaxAtt+1)*10 ]) Exp"
			usr<<"[usr.MinBlock]-[usr.MaxBlock] Physical Block <font color=red>([ (usr.MinBlock+1)*25 ]-[ (usr.MaxBlock+1)*10 ]) Exp"
			usr<<"[usr.Speed] Physical Speed <font color=red>([ (usr.Speed+1)*10 ]) Exp"
			usr<<"[usr.MinMagicAtt]-[usr.MaxMagicAtt] Magic Attack <font color=red>([ (usr.MinMagicAtt+1)*25 ]-[ (usr.MaxMagicAtt+1)*10 ]) Exp"
			usr<<"[usr.MinMagicBlock]-[usr.MaxBlock] Magic Block <font color=red>([ (usr.MinMagicBlock+1)*25 ]-[ (usr.MaxMagicBlock+1)*10 ]) Exp"
			usr<<"[usr.MagicSpeed] Magic Speed <font color=red>([ (usr.MagicSpeed+1)*10 ]) Exp"
			usr<<"<font color=blue>-Weapoons-"
			usr<<"[usr.Weapon]"
			usr<<"[usr.MagicWeapon]"
			usr<<""
		*/

		Level_Up()
			switch( alert(usr,"Level Up Which School","Level Up","Physical","Magic","Health +2") )
				if("Physical")
					switch( alert(usr,"Which Power","Level Up","Physical Attack","Physical Block","Physical Speed") )
						if("Physical Attack")
							switch( alert(usr,"Which Side","Level Up","Physical Attack Minimum","Physical Attack Maximum") )
								if("Physical Attack Minimum")
									if( usr.Exp >= (usr.MinAtt+1)*25 )
										if(usr.MinAtt<usr.MaxAtt)
											usr.Exp-=(usr.MinAtt+1)*25
											usr.MinAtt++
										else
											alert(usr,"Minimum must be less then Maximum!","Level Up")
									else
										alert(usr,"Not Enough Exp!","Level Up")

								if("Physical Attack Maximum")
									if( usr.Exp >= (usr.MaxAtt+1)*10 )

										usr.Exp-=(usr.MaxAtt+1)*10
										usr.MaxAtt++
									else
										alert(usr,"Not Enough Exp!","Level Up")

						if("Physical Block")
							switch( alert(usr,"Which Side","Level Up","Physical Block Minimum","Physical Block Maximum") )
								if("Physical Block Minimum")
									if( usr.Exp >= (usr.MinBlock+1)*25 )
										if(usr.MinBlock<usr.MaxBlock)
											usr.Exp-=(usr.MinBlock+1)*25
											usr.MinBlock++
										else
											alert(usr,"Minimum must be less then Maximum!","Level Up")
									else
										alert(usr,"Not Enough Exp!","Level Up")

								if("Physical Block Maximum")
									if( usr.Exp >= (usr.MaxBlock+1)*10 )
										usr.Exp-=(usr.MaxBlock+1)*10
										usr.MaxBlock++
									else
										alert(usr,"Not Enough Exp!","Level Up")

						if("Physical Speed")
							if( usr.Exp >= (usr.Speed+1)*10 )
								usr.Exp-=(usr.Speed+1)*10
								usr.Speed++
							else
								alert(usr,"Not Enough Exp!","Level Up")
				if("Magic")
					switch( alert(usr,"Which Power","Level Up","Magic Attack","Magic Block","Magic Speed") )
						if("Magic Attack")
							switch( alert(usr,"Which Side","Level Up","Magic Attack Minimum","Magic Attack Maximum") )
								if("Magic Attack Minimum")
									if( usr.Exp >= (usr.MinMagicAtt+1)*25 )
										if(usr.MinMagicAtt<usr.MaxMagicAtt)
											usr.Exp-=(usr.MinMagicAtt+1)*25
											usr.MinMagicAtt++
										else
											alert(usr,"Minimum must be less then Maximum!","Level Up")
									else
										alert(usr,"Not Enough Exp!","Level Up")

								if("Magic Attack Maximum")
									if( usr.Exp >= (usr.MaxMagicAtt+1)*10 )
										usr.Exp-=(usr.MaxMagicAtt+1)*10
										usr.MaxMagicAtt++
									else
										alert(usr,"Not Enough Exp!","Level Up")

						if("Magic Block")
							switch( alert(usr,"Which Side","Level Up","Magic Block Minimum","Magic Block Maximum") )
								if("Magic Block Minimum")
									if( usr.Exp >= (usr.MinMagicBlock+1)*25 )
										if(usr.MinMagicBlock<usr.MaxMagicBlock)
											usr.Exp-=(usr.MinMagicBlock+1)*25
											usr.MinMagicBlock++
										else
											alert(usr,"Minimum must be less then Maximum!","Level Up")
									else
										alert(usr,"Not Enough Exp!","Level Up")

								if("Magic Block Maximum")
									if( usr.Exp >= (usr.MaxMagicBlock+1)*10 )
										usr.Exp-=(usr.MaxMagicBlock+1)*10
										usr.MaxMagicBlock++
									else
										alert(usr,"Not Enough Exp!","Level Up")

						if("Magic Speed")
							if( usr.Exp >= (usr.MagicSpeed+1)*10 )
								usr.Exp-=(usr.MagicSpeed+1)*10
								usr.MagicSpeed++
							else
								alert(usr,"Not Enough Exp!","Level Up")
				if("Health +2")
					switch( alert(usr,"Which Power","Level Up","HP","MP") )
						if("HP")
							if(usr.Exp >= (usr.MaxHP/2+1) )
								usr.Exp-=(usr.MaxHP/2+1)
								usr.MaxHP+=2
							else
								alert(usr,"Not Enough Exp!","Level Up")
						if("MP")
							if(usr.Exp >= (usr.MaxMP+2) )
								usr.Exp-=(usr.MaxMP+2)
								usr.MaxMP+=2
							else
								alert(usr,"Not Enough Exp!","Level Up")
		/*
		Save()
			new/savefile(usr.name)

		Load()
			Read(savefile/usr.name)
		*/

	Dog
		icon='icons/dog.dmi'
		text="<font color=#ff9900>d"

		verb
			Follow_Me()
				set src in view(1)
				walk_towards( src, usr, round( (8)*(usr.HP/usr.MaxHP)+2, 1 ) )
				if(usr.DogWithYou==1)
					usr<<"<font color=#88333b>He's already following me!"
				else
					usr<<"<font color=#88333b>Come on Doggy!"
				usr<<""
				usr.DogWithYou=1

			Go_Home()
				set src in view(1)
				walk_to( src, locate(/turf/Dog/Bed), 0, round( (-8)*(usr.HP/usr.MaxHP)+10, 1 ) )
				if(usr.DogWithYou==0)
					usr<<"<font color=#88333b>He's already at home"
				else
					usr<<"<font color=#88333b>Stay at home now!"
				usr<<""
				usr.DogWithYou=0

			Pet()
				set src in view(1)
				src.loc=usr.loc

	Guard
		icon='icons/guard.dmi'
		text="<font color=#ff9900>X"

		var
			GTalk="<b>Guard</b>:<font color=#bb7722>"

		Starter_Town_Guard
			icon='icons/guard.dmi'

			verb
				Talk()
					set src in view(1)
					if(usr.missionShop2)
						usr<<"[GTalk] Good luck [usr.name]!"
						usr<<""
					else if(usr.missionShop1)
						usr<<"[GTalk] I got a notice from Simon to let you though. Right this way."
						usr<<""
						usr.missionShop2=1
						step(src,NORTH)
						step(src,WEST)
					else
						usr<<"[GTalk] I'm sorry only merchents are alowed past this point for security reasons."
						usr<<""

		Stick_Town_Guard
			icon='icons/guard.dmi'

			verb
				Talk()
					set src in view(1)
					if(eventStickTownGuard==0)
						usr<<"[GTalk] Welcome to Stick Town. We are having some trouble at the castle latly so becareful."
						usr<<""
						step(src,NORTH)
						step(src,WEST)
						eventStickTownGuard=1
					else
						usr<<"[GTalk] Welcome to Stick Town."
						usr<<""

		Forset_Guard
			icon='icons/guard.dmi'

			verb
				Talk()
					set src in view(1)
					usr<<"[GTalk] I'm sorry, They are having some trouble to the southeast in Stick Town. Untill I get the clear from them I can'let you pass."

	People
		icon='icons/person2.dmi'
		text="<font color=#ff9900>wwwwwwW"

		var
			CTalk="<font color=#bb7722>"

		Guys
			icon='icons/person2.dmi'

			Emo_Bill
				icon='icons/person2.dmi'

				verb
					Talk_to_Bill()
						if(usr.missionBillMay1)
							set src in view(1)
							usr<<"It appers that he's talking to that girl next to him, and they both seem to be ignoring you"
							usr<<"<b>Bill:</b> [CTalk]I told you I can't go back and get your notebook."
							usr<<"<b>May:</b> [CTalk]But I'm shore I lost it in your house!"
							usr<<"<b>Bill:</b> [CTalk]Now Look. My house hasn't been exterminated yet and I'm not looking for your notebook intill it is."
							usr<<"<b>May:</b> [CTalk]Well I hope your happy you sissy! A bug has probably eaten it by now!!!"
							usr<<""
							if(usr.missionBillMay3)
								usr<<"<b>Bill:</b> [CTalk]'Sup [usr.name], did you here all that? My exterminater is taking forever. Can you go do it for me? I'll pay you! Here's my key."
								usr<<"Bill handed me his house key???"
								usr<<""
								usr.KeyBill=1
								usr.missionBillMay3=0
						else
							if(usr.missionBillMay2)
								usr<<"<b>Bill:</b> [CTalk]Thanks again for exterminating my house. Sorry, I was distracted before. Heres the money I was going to pay the exterminater."
								usr<<"<b>Bill:</b> [CTalk]Oh no you don't May!"
								usr<<"Cool I got 50 goldians!"
								usr<<""
								usr<<""
								usr.Goldians+=50
								usr.missionBillMay2=0

								src.density=0
								for(var/i=0; i<11; i++)
									sleep(2)
									step(src,WEST)
								for(var/i=0; i<11; i++)
									sleep(2)
									step(src,NORTH)
								sleep(2)
								step(src,EAST)
								src.density=1
							else
								usr<<"<b>Bill:</b> [CTalk]What's up [usr.name]?"
								usr<<""

			Shop_Keeper_Simon
				icon='icons/shopkeeper.dmi'

				verb
					Talk_to_Simon()
						set src in view(1)
						if(usr.missionShop1==0 && usr.missionShop2==0)
							switch(alert(usr,"Hey [usr.name] I need you to do me a favor.","Simon","Sure, what do you need?","Sorry, I can't right now"))
								if("Sure, what do you need?")
									usr<<"<b>Simon:</b> [CTalk]I haven't gotten my latest shipment from Colorless Village in the North. If you can get me my stuff I can pay you. You will also be able to buy I new wepon here. Thanks!"
									usr<<""
									usr.missionShop1=1
						else if(usr.missionShop1==0 && usr.missionShop2)
							usr<<"<b>Simon:</b> [CTalk]Thanks again [usr.name]"
						else
							if(usr.ShopPackage==1)
								usr<<"<b>Simon:</b> [CTalk]Thank you so much [usr.name]! Here, take a Potion and an M-Potion as payment. Also I'll give you a discount on my new item."
								usr<<""
								usr.ShopPackage--
								usr.Potions++
								usr.MPotions++
								usr.missionShop1=0
							else
								usr<<"<b>Simon:</b> [CTalk]Remember [usr.name], it should be in Colorless Village, north of here."
								usr<<""

		Girls
			icon='icons/person1.dmi'

			Blond_May
				icon='icons/person1.dmi'

				verb
					Talk_to_May()
						if(usr.missionBillMay1)
							if(usr.Notepad==0)
								set src in view(1)
								usr<<"It appers that she's talking to that boy next to her, and they both seem to be ignoring you"
								usr<<"<b>Bill:</b> [CTalk]I told you I can't go back and get your notepad."
								usr<<"<b>May:</b> [CTalk]But I'm shore I lost it in your house!"
								usr<<"<b>Bill:</b> [CTalk]Now Look. My house hasn't been exterminated yet and I'm not looking for your notepad intill it is."
								usr<<"<b>May:</b> [CTalk]Well I hope your happy you sissy! A bug has probably eaten it by now!!!"
								usr<<""
							else
								usr<<"<b>May:</b> [CTalk]Oh, is that my notepad? Ew it all covered in bug slobber! You can keep it."
								usr<<"<b>Bill:</b> [CTalk]Are You Serious?!!!"
								usr<<"<b>May:</b> [CTalk]Well if you hadn't been a big sissy I could have kept it."
								usr<<"<b>Bill:</b> [CTalk]You lost it!"
								usr<<"<b>May:</b> [CTalk]Well \"I'm\" going to the shop thanks anyway [usr.name]."
								usr<<""
								usr.missionBillMay1=0
								usr.missionBillMay2=1

								src.density=0
								for(var/i=0; i<11; i++)
									sleep(2)
									step(src,WEST)
								for(var/i=0; i<10; i++)
									sleep(2)
									step(src,NORTH)
								for(var/i=0; i<2; i++)
									sleep(2)
									step(src,EAST)
								src.density=1
						else
							usr<<"<b>May:</b> [CTalk]Hey [usr.name]. Thanks again for trying to get my notepad back."
							usr<<""

	Enemies
		icon='icons/bug.dmi'

		verb
			Battle()
				set src in view(1)

				var
					Win
					oppAtt
					oppMaxHP=src.HP
					x
					cont=1
					critical
					oppcritical
					miss
					oppmiss

					SigA1p= "-"
					SigA2p= "-"
					SigA1m= "~"
					SigA2m= "~"
					SigB1p= "x-"
					SigB2p= "-x"
					SigB1m= "x~"
					SigB2m= "~x"
					SinC1p= "{-"
					SinC2p= "-}"
					SinC1m= "{+"
					SinC2m= "+}"
					CSwitch
					oppCSwitch

				if(usr.Weapon=="Stick")
					usr.MaxAtt+=1
					usr.MaxMagicAtt+=1

				if(usr.MagicWeapon=="Mind")
					usr.MPdrain=1


				while(usr.HP>0 && src.HP>0 && cont==1)
					if(src.MPdrain<=src.MP)
						oppAtt=rand(1,2)
					else
						oppAtt=1

					critical=CutDownTo(rand(0,19),1)
					oppcritical=CutDownTo(rand(0,19),1)
					miss=CutDownTo(rand(0,9),1)
					oppmiss=CutDownTo(rand(0,9),1)

					CSwitch=""
					oppCSwitch=""
					if(critical==0)
						CSwitch="Critical: "
					if(oppcritical==0)
						oppCSwitch="Critical: "
					if(miss==0)
						CSwitch="Missed: "
					if(oppmiss==0)
						oppCSwitch="Dodged: "

					switch( alert(usr, "Which attack?", "Battle", "Physical", "Magic", "Run") )
						if("Physical")
							if(rand(1,usr.Speed+src.Speed) <= usr.Speed)
								x= rand(usr.MinAtt,usr.MaxAtt)*(-critical+2) - rand(src.MinBlock,src.MaxBlock)*critical
								x=-CutDownTo(-x*miss,0)
								src.HP-=x
								alert(usr,"[SigA1p] [CSwitch]You dealt [x] physical damage [SigA2p]","Battle")
								x= rand(0,rand(usr.MinAtt,usr.MaxAtt)-rand(usr.MinBlock,usr.MaxBlock))*(-CutDownTo(rand(0,4),1)+1)
								usr.HP-=x
								if(x>0)
									alert(usr,"[SinC1p] You hurt yourself [x] damage [SinC2p]","Battle")

								if(usr.HP<=0)
									Win=0
								else if(src.HP<=0)
									Win=1
								else
									if(oppAtt==1)
										x= rand(src.MinAtt,src.MaxAtt)*(-oppcritical+2) - rand(usr.MinBlock,usr.MaxBlock)*oppcritical
										x=-CutDownTo(-x*oppmiss,0)
										usr.HP-=x
										alert(usr,"[SigB1p] [oppCSwitch][src.name] hit you for [x] physical damage [SigB2p]","Battle")
									else
										x= rand(src.MinMagicAtt,src.MaxMagicAtt)*(-oppcritical+2) - rand(usr.MinMagicBlock,usr.MaxMagicBlock)*oppcritical
										x=-CutDownTo(-x*oppmiss,0)
										usr.HP-=x
										src.MP-=usr.MPdrain
										alert(usr,"[SigB1m] [oppCSwitch][src.name] hit you for [x] magic damage [SigB2m]","Battle")

									if(usr.HP<=0)
										Win=0
							else
								if(oppAtt==1)
									x= rand(src.MinAtt,src.MaxAtt)*(-oppcritical+2) - rand(usr.MinBlock,usr.MaxBlock)*oppcritical
									x=-CutDownTo(-x*oppmiss,0)
									usr.HP-=x
									alert(usr,"[SigB1p] [oppCSwitch][src.name] hit you for [x] physical damage [SigB2p]","Battle")
								else
									x= rand(src.MinMagicAtt,src.MaxMagicAtt)*(-oppcritical+2) - rand(usr.MinMagicBlock,usr.MaxMagicBlock)*oppcritical
									x=-CutDownTo(-x*oppmiss,0)
									usr.HP-=x
									src.MP-=usr.MPdrain
									alert(usr,"[SigB1m] [oppCSwitch][src.name] hit you for [x] magic damage [SigB2m]","Battle")

								if(usr.HP<=0)
									Win=0
								else
									x= rand(usr.MinAtt,usr.MaxAtt)*(-critical+2) - rand(src.MinBlock,src.MaxBlock)*critical
									x=-CutDownTo(-x*miss,0)
									src.HP-=x
									alert(usr,"[SigA1p] [CSwitch]You dealt [x] physical damage [SigA2p]","Battle")
									x= rand(0,rand(usr.MinAtt,usr.MaxAtt)-rand(usr.MinBlock,usr.MaxBlock))*(-CutDownTo(rand(0,4),1)+1)
									usr.HP-=x
									if(x>0)
										alert(usr,"[SinC1p] You hurt yourself [x] damage [SinC2p]","Battle")

									if(usr.HP<=0)
										Win=0
									else if(src.HP<=0)
										Win=1

						if("Magic")
							if(CSwitch=="Missed: ")
								CSwitch=""
							if(oppCSwitch=="Dodged: ")
								oppCSwitch=""

							if(usr.MP>=usr.MPdrain)
								usr.MP-=usr.MPdrain
								if(rand(1,usr.MagicSpeed+src.MagicSpeed) <= usr.MagicSpeed)
									x= rand(usr.MinMagicAtt,usr.MaxMagicAtt)*(-critical+2) - rand(src.MinMagicBlock,src.MaxMagicBlock)*critical
									x=-CutDownTo(-x,0)
									src.HP-=x
									alert(usr,"[SigA1m] [CSwitch]You dealt [x] magic damage [SigA2m]","Battle")
									x= rand(0,rand(usr.MinMagicAtt,usr.MaxMagicAtt))*(-CutDownTo(rand(0,4),1)+1)
									usr.HP+=x
									if(x>0)
										alert(usr,"[SinC1m] You heal yourself [x] HP [SinC2m]","Battle")

									if(src.HP<=0)
										Win=1
									else
										if(oppAtt==1)
											x= rand(src.MinAtt,src.MaxAtt)*(-oppcritical+2) - rand(usr.MinBlock,usr.MaxBlock)*oppcritical
											x=-CutDownTo(-x,0)
											usr.HP-=x
											alert(usr,"[SigB1p] [oppCSwitch][src.name] hit you for [x] physical damage [SigB2p]","Battle")
										else
											x= rand(src.MinMagicAtt,src.MaxMagicAtt)*(-oppcritical+2) - rand(usr.MinMagicBlock,usr.MaxMagicBlock)*oppcritical
											x=-CutDownTo(-x,0)
											usr.HP-=x
											src.MP-=usr.MPdrain
											alert(usr,"[SigB1m] [oppCSwitch][src.name] hit you for [x] magic damage [SigB2m]","Battle")

										if(usr.HP<=0)
											Win=0

								else
									if(oppAtt==1)
										x= rand(src.MinAtt,src.MaxAtt)*(-oppcritical+2) - rand(usr.MinBlock,usr.MaxBlock)*oppcritical
										x=-CutDownTo(-x,0)
										usr.HP-=x
										alert(usr,"[SigB1p] [oppCSwitch][src.name] hit you for [x] physical damage [SigB2p]","Battle")
									else
										x= rand(src.MinMagicAtt,src.MaxMagicAtt)*(-oppcritical+2) - rand(usr.MinMagicBlock,usr.MaxMagicBlock)*oppcritical
										x=-CutDownTo(-x,0)
										usr.HP-=x
										src.MP-=usr.MPdrain
										alert(usr,"[SigB1m] [oppCSwitch][src.name] hit you for [x] magic damage [SigB2m]","Battle")

									if(usr.HP<=0)
										Win=0
									else
										x= rand(usr.MinMagicAtt,usr.MaxMagicAtt)*(-critical+2) - rand(src.MinMagicBlock,src.MaxMagicBlock)*critical
										x=-CutDownTo(-x,0)
										src.HP-=x
										alert(usr,"[SigA1m] [CSwitch]You dealt [x] magic damage [SigA2m]","Battle")
										x= rand(0,rand(usr.MinMagicAtt,usr.MaxMagicAtt))*(-CutDownTo(rand(0,4),1)+1)
										usr.HP+=x
										if(x>0)
											alert(usr,"[SinC1m] You heal yourself [x] HP [SinC2m]","Battle")

										if(src.HP<=0)
											Win=1
							else
								alert(usr,"Not Enough MP","Battle")

						if("Run")
							if(rand(0,100)>=(100*usr.Speed)/(usr.Speed+src.Speed))
								cont=0
								Win=0
							else
								x= rand(src.MinAtt,src.MaxAtt)
								usr.HP-=x
								alert(usr,"[SigB1p][src.name] hit you for [x] physical damage[SigB2p]","Battle")

								if(usr.HP<=0)
									Win=0

				if(usr.Weapon=="Stick")
					usr.MaxAtt-=1
					usr.MaxMagicAtt-=1

				if(Win==0 && cont==1)
					src.HP=oppMaxHP
					Death()
				else if(cont==1)
					usr.Exp+=src.Exp
					alert(usr,"You gain [src.Exp] Exp!")
					Win(src.name,src.loc)
					del(src)
				else
					x=rand(0,(usr.Goldians*src.HP)/(usr.HP+src.HP))
					usr.Goldians-=x
					alert(usr,"You lost [x] Goldians","Battle")

		Bug
			icon='icons/bug.dmi'
			text="<font color=#aa0000>o"
			HP=5
			MaxAtt=1
			MinAtt=0
			MaxBlock=0
			MinBlock=0
			Speed=1
			MP=0
			MaxMagicAtt=0
			MinMagicAtt=0
			MaxMagicBlock=0
			MinMagicBlock=0
			MagicSpeed=1
			Exp=5
			MPdrain=1

		Giant_Bug
			icon='icons/giantbug.dmi'
			text="<font color=#aa0000>O"
			HP=10
			MaxAtt=3
			MinAtt=0
			MaxBlock=1
			MinBlock=0
			Speed=1
			MP=3
			MaxMagicAtt=2
			MinMagicAtt=2
			MaxMagicBlock=0
			MinMagicBlock=0
			MagicSpeed=3
			Exp=15
			MPdrain=1

		Bandit_AxeMan
			icon='icons/bandit.dmi'
			text="<font color=#aa0000>A"
			HP=19
			MaxAtt=4
			MinAtt=0
			MaxBlock=0
			MinBlock=0
			Speed=1
			MP=0
			MaxMagicAtt=0
			MinMagicAtt=0
			MaxMagicBlock=0
			MinMagicBlock=0
			MagicSpeed=0
			Exp=16
			MPdrain=1

		Bandit_Theif
			icon='icons/bandit2.dmi'
			text="<font color=#aa0000>t"
			HP=14
			MaxAtt=2
			MinAtt=1
			MaxBlock=1
			MinBlock=0
			Speed=2
			MP=0
			MaxMagicAtt=0
			MinMagicAtt=0
			MaxMagicBlock=1
			MinMagicBlock=0
			MagicSpeed=0
			Exp=18
			MPdrain=1

		Bandit_Boss1
			icon='icons/bandit3.dmi'
			text="<font color=#aa0000>B"
			HP=25
			MaxAtt=7
			MinAtt=2
			MaxBlock=3
			MinBlock=1
			Speed=1
			MP=8
			MaxMagicAtt=3
			MinMagicAtt=2
			MaxMagicBlock=2
			MinMagicBlock=1
			MagicSpeed=1
			Exp=30
			MPdrain=1



obj
	icon='icons/bed.dmi'
	text="<font color=#ffffff>+"

	Bed
		icon='icons/bed.dmi'

	MyBed
		icon='icons/mybed.dmi'

		verb
			Sleep()
				set	src in view(0)
				var
					c = usr.Clock
					m = 10*(usr.MaxHP-usr.HP)
				if( FindHours(c) >= 12 )
					switch(alert(usr,"Sleep for [CutDownTo(m,1440-c)] minutes","Sleep","Good Night!","I'm not that tired..."))
						if("Good Night!")
							for(var/i=0; i< CutDownTo(m,1440-c)/10; i++)
								AddTime(10)
								usr.HP++
							if(usr.HP==usr.MaxHP)
								alert(usr,"*Yawn* Good Rest","Sleep")
							else
								alert(usr,"Morning already?","Sleep")
						if("I'm not that tired...")
							alert(usr,"Mabey later","Sleep")
				else
					alert(usr,"I can't sleep at this hour","Sleep")

			Meditate()
				set	src in view(0)
				var
					c = usr.Clock
					m = 10*(usr.MaxMP-usr.MP)
				if( FindHours(c) >= 12 )
					switch(alert(usr,"Meditate for [CutDownTo(m,1440-c)] minutes","Meditate","hmmmm...","Not now."))
						if("hmmmm...")
							for(var/i=0; i< CutDownTo(m,1440-c)/10; i++)
								AddTime(10)
								usr.MP++
							if(usr.MP==usr.MaxMP)
								alert(usr,"I feel refreshed.","Meditate")
							else
								alert(usr,"The sun tells me it's time to stop.","Meditate")
						if("Not now.")
							alert(usr,"Feel the rush!","Meditate")
				else
					alert(usr,"It's too bright out to meditate","Meditate")

	Clock
		icon='icons/clock.dmi'
		text="<font color=#ffffff>OOOOOOOOOX"

		verb
			Check_Time()
				set src in view(1)
				usr<<"The time is [ConvertClock(usr.Clock)]"
				usr<<""

	Calender
		icon='icons/calender.dmi'
		text="<font color=#ffffff>#"

		verb
			Check_Day()
				set src in view(1)
				usr<<"The day is [usr.Day]."
				usr<<""

	Stick
		icon='icons/stick.dmi'
		text="<font color=#664422>l"

		verb
			Equip_Stick()
				set src in view(0)
				switch( alert(usr, "+1 MaxAtt, +1 MaxMagicAtt", "Equip Stick", "Equip Stick", "Leave Stick") )
					if("Equip Stick")
						usr.Weapon="Stick"
						del(src)

	PiggyBank
		icon='icons/piggybank.dmi'
		icon_state="fixed"
		text="<font color=#ffaaaa>m"
		density=1

		verb
			Deposite()
				set src in view(1)
				if(src.icon_state=="fixed")
					switch(alert(usr,"Feed piggy 10 goldians?","Bank","Yea, let's save up for a new hat!","Hell no, I don't trust inanimate objects with my money!"))
						if("Yea, let's save up for a new hat!")
							if(usr.Goldians>=10)
								usr.Goldians-=10
								usr.Bank+=10
								alert(usr,"Yum... Your money's safe with me","Bank")
							else
								alert(usr,"I don't even have 10 goldians!","Bank")
				else
					alert(usr,"I can't keep money in a broken bank, duh!","Bank")

			Check_Bank()
				set src in view(1)
				if(src.icon_state=="broken")
					usr<<"This bank is broken!!!"
				else if(usr.Bank>=1000)
					usr<<"I don't think this bank can get much heavier!"
				else if(usr.Bank>=500)
					usr<<"This bank is heavy as crap!"
				else if(usr.Bank>=250)
					usr<<"This bank is pretty heavy."
				else if(usr.Bank>=100)
					usr<<"This bank is a good weight."
				else if(usr.Bank>=50)
					usr<<"This bank is getting there..."
				else if(usr.Bank>=10)
					usr<<"This bank is pretty light..."
				else
					usr<<"This bank is empty!!!"
				usr<<""

			Break_Open()
				set src in view(1)
				if(src.icon_state=="fixed")
					switch(alert(usr,"Do you want to bust this piggy open and take all the money out?","Bank","Hell yea, let's do this!","I just can't hit something so cute..."))
						if("Hell yea, let's do this!")
							if(usr.Bank==0)
								alert(usr,"Wow, I have no money! You just like breaking piggys open, don't you?","Bank")
							else
								alert(usr,"You spent [usr.Bank/10] minutes couting and found you had saved up [usr.Bank] goldians!","Bank")
							AddTime(usr.Bank/10)
							usr.Goldians+=usr.Bank
							usr.Bank=0
							src.icon_state="broken"
				else
					alert(usr,"The bank is already broken.","Bank")

			Fix_Bank()
				set src in view(1)
				if(src.icon_state=="broken")
					switch(alert(usr,"Do you want to pay 10 goldians for a new piggy bank","Bank","There just so cute, I can't resist!","I kind of like the look of this broken one..."))
						if("There just so cute, I can't resist!")
							if(usr.Goldians>=10)
								usr.Goldians-=10
								src.icon_state="fixed"
							else
								alert(usr,"I don't even have 10 goldians!","Bank")
				else
					alert(usr,"Hey, just 'cause I'm a pig dosen't meen I need to be fixed!","Bank")

	Notepad
		icon='icons/notepad.dmi'
		text="<font color=#ffffff>N"

		verb
			Pick_Up()
				set src in view(0)
				usr.Notepad=1
				usr<<"You found a Notpad!"
				usr<<"Mabey you can put this to good use?"
				usr<<"It appers to have insructions in it already!"
				usr<<""
				del(src)

	Goldians
		icon='icons/coinyellow.dmi'

		Pile
			icon='icons/pileogold.dmi'

			verb
				Serch()
					set src in view(0)
					switch(alert(usr,"It's a pile of coins! Would you like to take them?","Serch","Yey, free money!","Na"))
						if("Yey, free money!")
							var/x=rand(5,15)
							AddTime(15)
							usr<<"You spend 15 mins serching and discover [x] goldians."
							usr<<""
							usr.Goldians+=x
							del(src)

	Potions
		icon='icons/mpotion.dmi'
		text="<font color=#aaffaa>A"

		Potion
			icon='icons/potion.dmi'

			verb
				Buy()
					set src in view(1)
					switch(alert(usr,"Would you like to buy a Potion for 30 goldians","Buy Potion","Sure","No Thanks!"))
						if("Sure")
							if(usr.Goldians>=30)
								usr.Goldians-=30
								usr.Potions++
								alert(usr,"This will come in handy.","Buy Potion")
							else
								alert(usr,"Damn, I don't have enough goldians.","Buy Potion")


		MPotion
			icon='icons/mpotion.dmi'

			verb
				Buy()
					set src in view(1)
					switch(alert(usr,"Would you like to buy an M-Potion for 30 goldians","Buy M-Potion","Sure","No Thanks!"))
						if("Sure")
							if(usr.Goldians>=30)
								usr.Goldians-=30
								usr.MPotions++
								alert(usr,"This will come in handy.","Buy M-Potion")
							else
								alert(usr,"Damn, I don't have enough goldians.","Buy M-Potion")

	Watch
		icon='icons/watch.dmi'
		text="<font color=#ffffaa>0"

		verb
			Buy()
				set src in view(1)
				switch(alert(usr,"Would you like to buy this cool watch for 75 goldians. It lets you keep track of time no mater where you are!","Buy Watch","Sure","No Thanks!"))
					if("Sure")
						if(usr.Goldians>=75)
							if(usr.Watch==0)
								usr.Goldians-=75
								usr.Watch=1
								alert(usr,"Awsome! A watch!","Buy Watch")
							else
								alert(usr,"I already have a watch. Duh!","Buy Watch")
						else
							alert(usr,"Damn, I don't have enough goldians.","Buy Watch")

	Signs
		icon='icons/signs/signme.dmi'
		text="<font color=#664422>Y"
		density=1

		SignMe
			icon='icons/signs/signme.dmi'

			verb
				Check_Sign()
					set src in view(1)
					usr<<"The sign reads: <font color=#337777><i>[usr.name]'s House"
					usr<<""

		SignBill
			icon='icons/signs/signbill.dmi'

			verb
				Check_Sign()
					set src in view(1)
					usr<<"The sign is barely readable as if the house has been abandone: <font color=#337777><i>Bill's House; Away, waiting for extermination!"
					usr<<""

		SingShop
			icon='icons/signs/signshop.dmi'

			verb
				Check_Sign()
					set src in view(1)
					usr<<"The sign reads: <font color=#337777><i>Starter Town General Shop"
					usr<<""


turf
	icon='icons/grass.dmi'
	text="<font bgcolor=#000000> "

	Click()
		walk_to(usr,src,0,3)

	MyMat
		icon='icons/mymat.dmi'
		text="<font bgcolor=#ffffff color=#ff0000>M"

	Counter
		icon='icons/counter.dmi'
		text="<font bgcolor=#ffffff color=#ffff00>$"
		density=1

	Dog
		Bed
			icon='icons/dogbed.dmi'
			text="<font bgcolor=#000088 color=#ffbb55>O"

			/*
			Entered()
				alert(usr,"Awsome!")
				sleep( rand(150,600) )
				switch( rand(1,7) )
					if(1,2)
						walk_to( src, locate(/turf/Dog/Food_Dish), 0, rand(2,10) )

					if(3,4)
						walk_to( src, locate(/turf/Dog/Water_Dish), 0, rand(2,10) )

					if(5,6)
						walk_to( src, locate(/turf/Dog/Flower), 0, rand(2,10) )

					if(7)
						walk_to( src, locate(/turf/Dog/Tree), 0, rand(1,5) )
			*/

		Tree
			icon='icons/tree.dmi'
			text="<font color=#338800>T"
			density=1

		Water_Dish
			icon='icons/waterdish.dmi'

		Food_Dish
			icon='icons/dogdish.dmi'

		DogBowl
			icon='icons/dogbowl.dmi'
			text="<font bgcolor=#aaaaaa color=#000000>8"

		Flower
			icon='icons/flowers.dmi'
			text="<font color=#ff7777>iiii<font color=#77ff77>iiii<font color=#7777ff>iiii"

			Entered()
				src.icon='icons/flowersdead.dmi'
				sleep(600)
				src.icon='icons/flowers.dmi'

	Grounds
		icon='icons/grass.dmi'
		text="<font bgcolor=#22aa22> "

		Grass
			icon='icons/grass.dmi'
			text="<font bgcolor=#22aa22> "

		Dirt
			icon='icons/dirt.dmi'
			text="<font bgcolor=#996633> "

		Sand
			icon='icons/sand.dmi'
			text="<font bgcolor=#aaaa99> "

		Water
			icon='icons/water.dmi'
			text="<font bgcolor=#2222aa> "

			Water
				icon='icons/water.dmi'

				Entered()
					usr.icon_state="Swim"
				Exited()
					usr.icon_state="Main"

			Bridge
				icon='icons/bridge.dmi'
				text="<font bgcolor=#664422 color=#332211>l"

			WaterEdge
				icon='icons/wateredgen.dmi'

				WaterEdgeN
					icon='icons/wateredgen.dmi'

				WaterEdgeS
					icon='icons/wateredges.dmi'

				WaterEdgeE
					icon='icons/wateredgee.dmi'

				WaterEdgeW
					icon='icons/wateredgew.dmi'

			WaterRock
				icon='icons/bolder.dmi'
				text="<font color=#332211>O"
				density=1

	Paths
		icon='icons/paths/pathNS.dmi'
		text="<font color=#999966>="

		PathNS
			icon='icons/paths/pathNS.dmi'

		PathEW
			icon='icons/paths/pathEW.dmi'

		PathNE
			icon='icons/paths/pathNE.dmi'

		PathSE
			icon='icons/paths/pathSE.dmi'

		PathSW
			icon='icons/paths/pathSW.dmi'

		PathNW
			icon='icons/paths/pathNW.dmi'

	Fences
		icon='icons/fenceh.dmi'
		text="<font color=#332211>F"
		density=1

		FenceV
			icon='icons/fencev.dmi'

		FenceH
			icon='icons/fenceh.dmi'

		FenceUR
			icon='icons/fenceur.dmi'

		FenceUL
			icon='icons/fenceul.dmi'

		FenceDR
			icon='icons/fencedr.dmi'

		FenceDL
			icon='icons/fencedl.dmi'

	Flowers
		icon='icons/flowers.dmi'
		text="<font color=#ff7777>iiii<font color=#77ff77>iiii<font color=#7777ff>iiii"

		Entered()
			src.icon='icons/flowersdead.dmi'
			src.text="<font color=#bb4444>iiii<font color=#44bb44>iiii<font color=#4444bb>iiii"
			sleep(600)
			src.icon='icons/flowers.dmi'
			src.text="<font color=#ff7777>iiii<font color=#77ff77>iiii<font color=#7777ff>iiii"

		FlowerAlive
			icon='icons/flowers.dmi'

		FlowersDead
			icon='icons/flowersdead.dmi'
			text="<font color=#bb4444>iiii<font color=#44bb44>iiii<font color=#4444bb>iiii"

	Trees
		icon='icons/tree.dmi'
		text="<font color=#338800>T"
		density=1

		Tree
			icon='icons/tree.dmi'

		Jungle_Tree
			icon='icons/jungletree.dmi'

		Potted_Tree
			icon='icons/pottedtree.dmi'
			text="<font color=#338800>t"

	Walls
		icon='icons/stonewall.dmi'
		text="<font bgcolor=#000000 color=#333333>#"
		density=1
		opacity=1

		StoneWall
			icon='icons/stonewall.dmi'

	Floors
		icon='icons/woodfloor.dmi'
		text="<font bgcolor=#664422 color=#996633>_"

		WoodFloor
			icon='icons/woodfloor.dmi'

	Doors
		icon='icons/doors/wooddoor.dmi'
		text="<font color=#553b1b>]"
		icon_state="closed"
		opacity=1

		Entered()
			src.icon_state="open"

		Exited()
			src.icon_state="closed"

		WoodDoor
			icon='icons/doors/wooddoor.dmi'
			icon_state="closed"

			DoorEmoBill
				icon='icons/doors/wooddoor.dmi'
				icon_state="closed"

				Enter()
					if(usr.KeyBill)
						return 1
					return 0

		WoodDoorGreen
			icon='icons/doors/wooddoorG.dmi'
			icon_state="closed"

		Arch
			icon='icons/doors/arch.dmi'
			icon_state="closed"

		ArchWall
			icon='icons/doors/archwall.dmi'
			icon_state="closed"

		OpenDoor
			icon='icons/doors/opendoor.dmi'
			icon_state="closed"


area
	icon='icons/gray.dmi'
	text="<font color=#22aa22> "

	Indoor
		icon='icons/black.dmi'

		Entered()
			usr.changeView(2)

		Exited()
			usr.changeView(5)

	Outdoor
		icon='icons/white.dmi'