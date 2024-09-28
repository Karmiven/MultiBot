MultiBot.eventHandler = CreateFrame("Frame", nil, UIParent)
MultiBot.eventHandler:RegisterEvent("PLAYER_TARGET_CHANGED")
MultiBot.eventHandler:RegisterEvent("CHAT_MSG_WHISPER")
MultiBot.eventHandler:RegisterEvent("CHAT_MSG_SYSTEM")
MultiBot.eventHandler:RegisterEvent("CHAT_MSG_ADDON")
MultiBot.eventHandler:SetPoint("BOTTOMRIGHT", 1, 1)
MultiBot.eventHandler:SetSize(1, 1)
MultiBot.eventHandler:Show()

MultiBot.eventHandler:SetScript("OnEvent", function()
	if(event == "PLAYER_TARGET_CHANGED") then
	end
	
	if(event == "CHAT_MSG_SYSTEM") then
		if(MultiBot.auto.release and (MultiBot.isInside(arg1, "ist tot") or MultiBot.isInside(arg1, "has died"))) then
			SendChatMessage("release", "WHISPER", nil, MultiBot.doSplit(arg1, " ")[1])
		end
		
		if(MultiBot.isInside(arg1, "Bot roster: ")) then
			local tX = 0 - MultiBot.size - 2
			
			MultiBot.units = MultiBot.newUnits(MultiBot, tX, 0, MultiBot.size)
			MultiBot.units.setButton(MultiBot.config.units, "SHOW:UNITS")
			MultiBot.units.setPlayers(string.sub(arg1, 13))
			MultiBot.units.setMembers()
			MultiBot.units.setFriends()
			tX = tX + MultiBot.size + 2
			
			MultiBot.control = MultiBot.newFrame(MultiBot, tX, 0, MultiBot.size)
			MultiBot.control.addDouble(0, 0, MultiBot.config.control, "HIDE:CONTROL")
			tX = tX + MultiBot.size + 2
			
			MultiBot.gamemaster = MultiBot.newFrame(MultiBot, tX, 0, MultiBot.size)
			MultiBot.gamemaster.addSingle(0, 0, MultiBot.config.gamemaster.start)
			tX = tX + MultiBot.size + 2
			
			-- GAMEMASTER --
			
			local tFrame = MultiBot.gamemaster.addFrame("CONTROLS", -2, 4, MultiBot.size - 4)
			tFrame.addSingle(0, 1, MultiBot.config.gamemaster.summon)
			tFrame.addSingle(0, 2, MultiBot.config.gamemaster.appear)
			tFrame:Hide()
			
			-- CONTROL --
			
			local tFrame = MultiBot.control.addFrame("controls", -2, 4, MultiBot.size - 4)
			tFrame.addSwitch(0, 1, MultiBot.config.auto.release, "")
			tFrame.addSingle(0, 2, MultiBot.config.naxx)
			tFrame.addSingle(0, 3, MultiBot.config.reset)
			tFrame.addSingle(0, 4, MultiBot.config.action)
			tFrame:Hide()
			
			-- LEFT --
			
			MultiBot.left = MultiBot.newFrame(MultiBot, -2 * (MultiBot.size + 2), 2, MultiBot.size - 4)
			local tX = 0
			
			local tFrame = MultiBot.left.addFrame("beastmaster", tX, 0, MultiBot.size - 4)
			tFrame.addSingle(0, 0, MultiBot.config.beastmaster.start)
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addSelect(tX, 0, MultiBot.config.formation, "near").setChat("PARTY")
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addActionbar(tX, 0, MultiBot.config.flee, 1).setChat("PARTY")
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addDouble(tX, 0, MultiBot.config.stay, "follow").setChat("PARTY")
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addModebar(tX, 0, MultiBot.config.mode, 1).setChat("PARTY").setState(false)
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addActionbar(tX, 0, MultiBot.config.attack, 1).setChat("PARTY")
			tX = tX - MultiBot.size + 2
			
			MultiBot.left.addSingle(tX, 0, MultiBot.config.tanker).setChat("PARTY")
			tX = tX - MultiBot.size + 2
			
			-- RIGHT --
			
			MultiBot.right = MultiBot.newFrame(MultiBot, 2 * MultiBot.size, 2, MultiBot.size - 4)
			local tX = 0
			
			MultiBot.right.addSingle(tX, 0, MultiBot.config.drink).setChat("PARTY")
			tX = tX + MultiBot.size - 2
			
			MultiBot.right.addSingle(tX, 0, MultiBot.config.release).setChat("PARTY")
			tX = tX + MultiBot.size - 2
			
			MultiBot.right.addSingle(tX, 0, MultiBot.config.revive).setChat("PARTY")
			tX = tX + MultiBot.size - 2
			
			MultiBot.right.addSingle(tX, 0, MultiBot.config.sumall).setChat("WHISPER")
			tX = tX + MultiBot.size - 2
			
			-- BEASTMASTER --
			
			local tFrame = tFrame.addFrame("SPELLS", -2, MultiBot.size - 2, MultiBot.size - 8)
			tFrame.addSingle(0, 0, MultiBot.config.beastmaster.release)
			tFrame.addSingle(0, 1, MultiBot.config.beastmaster.revive)
			tFrame.addSingle(0, 2, MultiBot.config.beastmaster.heal)
			tFrame.addSingle(0, 3, MultiBot.config.beastmaster.feed)
			tFrame.addSingle(0, 4, MultiBot.config.beastmaster.call)
			tFrame:Hide()
			
			-- RAID --
			
			local tY = 0 - MultiBot.size + 2
			
			MultiBot.addRaidbar(1, -2, tY, MultiBot.size - 4).addGroup(1).addGroup(2)
			tY = tY - MultiBot.size + 2
			
			MultiBot.addRaidbar(2, -2, tY, MultiBot.size - 4).addGroup(3).addGroup(4)
			tY = tY - MultiBot.size + 2
			
			MultiBot.addRaidbar(3, -2, tY, MultiBot.size - 4).addGroup(5).addGroup(6)
			tY = tY - MultiBot.size + 2
			
			MultiBot.addRaidbar(4, -2, tY, MultiBot.size - 4).addGroup(7).addGroup(8)
			tY = tY - MultiBot.size + 2
		end
		
		if(MultiBot.isInside(arg1, " - player already logged in")) then
			local bot = MultiBot.getBot(string.sub(arg1, 6, string.find(arg1, " ", 6) - 1))
			if(bot == nil) then return end
			
			if(MultiBot.isMember(bot.name)) then
				bot.waitFor = "CO"
				SendChatMessage("Asked " .. bot.name .. " for Combat Strategies", "SAY")
				SendChatMessage("co ?", "WHISPER", nil, bot.name)
			else
				if(GetNumPartyMembers() == 4) then ConvertToRaid() end
				MultiBot.doSlash("/invite", bot.name)
			end
		end
		
		if(MultiBot.isInside(arg1, "remove: ")) then
			local bot = MultiBot.getBot(string.sub(arg1, 9, string.find(arg1, " ", 9) - 1))
			if(bot == nil) then return end
			
			if(MultiBot.isInside(arg1, "not your bot")) then
				SendChatMessage("leave", "WHISPER", nil, bot.name)
			end
			
			bot.button.setState(false)
			bot.doHide()
		end
		
		if(arg1 == "Enable player botAI") then
			local bot = MultiBot.getBot(UnitName("player"))
			bot.waitFor = "CO"
			bot.button.setState("true")
			SendChatMessage("co ?", "WHISPER", nil, bot.name)
			SendChatMessage("Asked " .. bot.name .. " for Combat Strategies", "SAY")
			MultiBot.doRaid()
		end
		
		if(arg1 == "Disable player botAI") then
			MultiBot.doRaid()
		end
	end
	
	if(event == "CHAT_MSG_WHISPER") then
		local bot = MultiBot.getBot(arg2)
		if(bot == nil) then return end
		
		if(MultiBot.auto.release and arg1 == "Meet me at the graveyard") then
			SendChatMessage("summon", "WHISPER", nil, bot.name)
		end
		
		if(arg1 == "Hello") then
			bot.waitFor = "CO"
			bot.button.setState(true)
			SendChatMessage("co ?", "WHISPER", nil, arg2)
			SendChatMessage("Asked " .. arg2 .. " for Combat Strategies", "SAY")
			MultiBot.doRaid()
		end
		
		if(arg1 == "Goodbye!") then
			MultiBot.doRaid()
		end
		
		if(arg1 == "Hello!") then
			bot.waitFor = "CO"
			bot.button.setState(true)
			SendChatMessage("co ?", "WHISPER", nil, arg2)
			SendChatMessage("Asked " .. arg2 .. " for Combat Strategies", "SAY")
			MultiBot.doRaid()
		end
		
		if(bot.waitFor == "NC" and MultiBot.isInside(arg1, "Strategies: ")) then
			bot.waitFor = ""
			bot.setNormal(string.sub(arg1, 13))
			bot.setStrate()
		end
		
		if(bot.waitFor == "CO" and MultiBot.isInside(arg1, "Strategies: ")) then
			bot.waitFor = "NC"
			bot.setCombat(string.sub(arg1, 13))
			SendChatMessage("nc ?", "WHISPER", nil, arg2)
			SendChatMessage("Asked " .. arg2 .. " for Normal Strategies", "SAY")
		end
		
		if(bot.waitFor == "=== Inventory ===" and MultiBot.isInside(arg1, "Bag")) then
			InspectUnit(bot.name)
			bot.inventory:Show()
			bot.waitFor = ""
		end
		
		if(bot.waitFor == "=== Inventory ===" and arg1 ~= "=== Inventory ===") then
			SendChatMessage("stats", "WHISPER", nil, arg2)
			bot.inventory.addItem(arg1)
		end
		
		if(bot.waitFor == "equipping" and MultiBot.isInside(arg1, "equipping")) then
			bot.inventory.doRefresh()
		end
	end
end)

SLASH_MULTIBOT1 = "/multibot"
SLASH_MULTIBOT2 = "/mbot"
SLASH_MULTIBOT3 = "/mb"

SlashCmdList["MULTIBOT"] = function()
	if(MultiBot:IsVisible()) then
		for key, value in pairs(MultiBot.units.units) do value.inventory.doClose() end
		for key, value in pairs(MultiBot.raid) do value:Hide() end
		
		MultiBot.control:Hide()
		MultiBot.units:Hide()
		MultiBot.right:Hide()
		MultiBot.left:Hide()
		MultiBot:Hide()
		
		table.wipe(MultiBot.units.units)
		table.wipe(MultiBot.raid)
	else
		SendChatMessage(".playerbot bot list", "SAY")
		MultiBot:Show()
	end
end

print("AfterMultiBotControl")