--// custom module template //--

--[[ You must register the module with LolzenUI
	 this will add the module in LolzenUI.modules table and be eligable for the checkBox and OptionPanel creation
	 
	 LolzenUI.RegisterModule("name", "about", hasOptions)
	 "name": [string] the name of the module
	 "about": [string] a short description of what the module does
	 "hasOptions: [boolean] tells LolzenUI to either or omit the optionpanel xreation for this module
	 
	 in our case we register a module named "template". set the dexription to "Template for LolzenUI modules" and create an Optionpanel
]]
LolzenUI.RegisterModule("template", "Template for LolzenUI modules", true)

--[[ You must tell LolzenUI if your module is either on or off by default

	 LolzenUI.modules["name"] = bool
	 "name": [string] the name of the module (the same we used in LolzenUI.RegisterModule())
	 "bool": [boolean] true = on by default, false = off by default

	 in our case we will make it ON per DEFAULT
]]
LolzenUI.modules["template"] = true

-- Now we use LolzenUI.customModuleOptions to add your module's option variables
--[[ As the module "template" is not a standard part of LolzenUI, LolzenUI does not generate a standard config for it
	 We will now use the function LolzenUI.customModuleOptions() to generate our defaultconfig which can be modified by other users later

	 LolzenUI.customModuleOptions("name", table)
	 "name": the name of the module (again, the same we uses earlier)
	 table: a table which has all relevant defaults
	 Example:
	 local defaults = {
		["option1"] = "a string",
		["option2"] = {}, -- another table
		["option3"] = true, -- a boolean
	 }
	 
	 in our case we use a table named defaults, like in the example
]]

local defaults = {
	["template_checkbox"] = true,
	["template_color"] = {0.9, 0.4, 1},
	["template_string"] = "hi",
	["template_integer"] = 200,
}
LolzenUI.customModuleOptions("template", defaults)

--[[	IMPORTANT NOTICE
	 #######################################################################################################
	 # LolzenUI.createButtons() and LolzenUI_Options.createOptionPanels() HAVE TO BE RUN again!			   #
	 # without calling LolzenUI.createButtons() there will be no checkbutton				 			   #
	 # without calling LolzenUI_Options.createOptionPanels() the LolzenUI_Options functions will error out #
	 #######################################################################################################
	 
]]
-- Here we create a frame and Register an event "ADDON_LOADED" http://wowprogramming.com/docs/events/ADDON_LOADED
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
-- now we set a script with the "OnEvent" handler, so we can do stuff when our event (="ADDON_LOADED") fires
-- we get some arguments we can use, in our case we use "addon" to get the name of the AddOn which was loaded succesfull and fired the event "ADDON_LOADED"
f:SetScript("OnEvent", function(self, event, addon)
	-- we check if our addon "LolzenUI_ModuleTemplate" is loaded
	if addon == "LolzenUI_ModuleTemplate" then
		-- create the checkbutton to enable or disable the module (see IMPORTANT NOTICE)
		if LolzenUI.panel ~= nil then
			LolzenUI.createButtons()
		end

		-- use a check to determine if the module is activated (on) or deactivated (off)
		if LolzenUIcfg.modules["template"] == false then return end
		-- do module stuff

		-- let's say hi
		print("Hi "..UnitName("player")..", nice to meet you!")
	end
	--[[	usable LolzenUI_Options functions
		LolzenUI_Options.createTitle("name")
		"name": the name of your module

		LolzenUI_Options.createDescription("name", "text")
		"name": the name of your module
		"text": the text which describes your module in a simple and informative way

		LolzenUI_Options.createHeader("name", "text")
		"name": the name of your module
		"text": header text which describes where the following column of options belong to

		LolzenUI_Options.createFontstring("name", "text")
		"name": the name of your module
		"text": any text, can be used to create options like >size: [220]< 
				where "size" is the text from LolzenUI_Options.createFontstring and the [220] being an inptbox with 220 as it's current value

		LolzenUI_Options.createInputbox("name", witdh, height, num)
		"name": the name of your module
		width: a number representing the width of the inputbox
		height: a number representing the height of the inputbox
		num: a number which is displayed in the inputbox [OPTIONAL]

		LolzenUI_Options.createCheckBox("name", "checkbox-name", "text", bool)
		"name": the name of your module
		"checkbox-name": the name of your checkbox
		"text": the text which is displayed right next to the checkbox
		bool: true/false; true = the checkBox is ticked, false = the checkbox is unticked

		LolzenUI_Options.createButtonTexture("name", size, "texture")
		"name": the name of your module
		size: a number for height & width of your button
		"texture": the path to your texture (e.g: "LolzenUI\\media\\gloss"); right now the texture has to be in LolzenUI\\media!

		LolzenUI_Options.createButtonOverlay("name", parent, "texture")
		"name": the name of your module
		parent: the parent for the overlay (e.g the button we created earlier with LolzenUI_Options.createButtonTexture)
		"texture": the path to your texture (e.g: "LolzenUI\\media\\gloss"); right now the texture has to be in LolzenUI\\media!

		LolzenUI_Options.createPicker = function("name", "pickertype", "pickerName", width, selected)
		"name": the name of your module
		"pickertype": the type of your picker ["alpha", "anchor", "font", "flag", "bin", "growth", "statusbar", "background", "border"]
				"alpha": a number ranging from 0.1 to 1
				"anchor": an anchor point, e.g. "TOPLEFT"
				"font": LibSharedMedia supported. For fonts. e.g. "DroidSans"
				"flag":	font flag. e.g. "THINOUTLINE"
				"bin": binary picker 0/1 (aka. on/off)
				"growth": similar to anchor, but not as feature rich. valid values are "ABOVE", BELOW, "LEFT" and "RIGHT"
				"statusbar": LibSharedMedia supported. For statusbar. e.g. "LolzenUI Standard"
				"background": LibSharedMedia supported. For background. e.g. "LolzenUI Standard"
				"border":LibSharedMedia supported. For background. e.g. "LolzenUI Standard"
	
	]]
	-- let's add some options, but only if LolzenUI_Options is loaded
	if addon == "LolzenUI_Options" then
		-- use a check to determine if the module is activated (on) or deactivated (off)
		if LolzenUIcfg.modules["template"] == false then return end

		-- we call LolzenUI_Options.createOptionPanels() so we can use LolzenUI_Options' functions (see IMPORTANT NOTICE)
		LolzenUI_Options.createOptionPanels()

		-- now we create a title
		local title = LolzenUI_Options.createTitle("template")

		-- and a description which is a simple statement of what our module does
		local about = LolzenUI_Options.createDescription("template", "User module template with example options")
		about:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)

		-- a header
		local header1 = LolzenUI_Options.createHeader("template", "This is a Header")
		header1:SetPoint("TOPLEFT", about, "BOTTOMLEFT", 0, -30)

		-- we create a checkbox which is ticked per default settings (["template_checkbox"] = true), but can be unticked
		-- we use the saved variable (LolzenUIcfg["template_checkbox"]) and let the function handle whetever the checkbox is checked or unchecked
		-- the saved variable can be changed later in the LolzenUI_Options[template"].okay function
		local cb1 = LolzenUI_Options.createCheckBox("template", "template_checkbox", "This is a checkbox", LolzenUIcfg.template["template_checkbox"])
		cb1:SetPoint("TOPLEFT", header1, "BOTTOMLEFT", 0, -8)

		--text with inputboxes
		local example_text = LolzenUI_Options.createFontstring("template", "right next to me is an inputbox with a number")
		example_text:SetPoint("TOPLEFT", cb1, "BOTTOMLEFT", 0, -8)

		local inputbox = LolzenUI_Options.createInputbox("template", 40, 30, 50)
		inputbox:SetPoint("LEFT", example_text, "RIGHT", 10, 0)

		local example_text2 = LolzenUI_Options.createFontstring("template", "right next to me is an inputbox without number or text")
		example_text2:SetPoint("TOPLEFT", example_text, "BOTTOMLEFT", 0, -8)

		local inputbox2 = LolzenUI_Options.createInputbox("template", 40, 30)
		inputbox2:SetPoint("LEFT", example_text2, "RIGHT", 10, 0)

		local header2 = LolzenUI_Options.createHeader("template", "Showcase PickerTypes")
		header2:SetPoint("TOPLEFT", example_text2, "BOTTOMLEFT", 0, -30)

		-- an examle of various picker types
		local picker1_text = LolzenUI_Options.createFontstring("template", "alpha picker:")
		picker1_text:SetPoint("TOPLEFT", header2, "BOTTOMLEFT", 0, -8)

		local picker1 = LolzenUI_Options.createPicker("template", "alpha", "example_picker_alpha", 50, 0.5)
		picker1:SetPoint("LEFT", picker1_text, "RIGHT", -10, -3)

		local picker2_text = LolzenUI_Options.createFontstring("template", "anchor picker:")
		picker2_text:SetPoint("TOPLEFT", picker1_text, "BOTTOMLEFT", 0, -15)

		local picker2 = LolzenUI_Options.createPicker("template", "anchor", "example_picker_anchor", 100, "TOPLEFT")
		picker2:SetPoint("LEFT", picker2_text, "RIGHT", -10, -3)

		local picker3_text = LolzenUI_Options.createFontstring("template", "font picker:")
		picker3_text:SetPoint("TOPLEFT", picker2_text, "BOTTOMLEFT", 0, -15)

		local picker3 = LolzenUI_Options.createPicker("template", "font", "example_picker_font", 100, "DroidSans")
		picker3:SetPoint("LEFT", picker3_text, "RIGHT", -10, -3)

		local picker4_text = LolzenUI_Options.createFontstring("template", "flag picker:")
		picker4_text:SetPoint("TOPLEFT", picker3_text, "BOTTOMLEFT", 0, -15)

		local picker4 = LolzenUI_Options.createPicker("template", "flag", "example_picker_flag", 100, "THINOUTLINE")
		picker4:SetPoint("LEFT", picker4_text, "RIGHT", -10, -3)

		local picker5_text = LolzenUI_Options.createFontstring("template", "bin picker:")
		picker5_text:SetPoint("TOPLEFT", picker4_text, "BOTTOMLEFT", 0, -15)

		local picker5 = LolzenUI_Options.createPicker("template", "bin", "example_picker_bin", 40, 1)
		picker5:SetPoint("LEFT", picker5_text, "RIGHT", -10, -3)

		local picker6_text = LolzenUI_Options.createFontstring("template", "growth picker:")
		picker6_text:SetPoint("TOPLEFT", picker5_text, "BOTTOMLEFT", 0, -15)

		local picker6 = LolzenUI_Options.createPicker("template", "growth", "example_picker_growth", 80, "ABOVE")
		picker6:SetPoint("LEFT", picker6_text, "RIGHT", -10, -3)

		local picker7_text = LolzenUI_Options.createFontstring("template", "statusbar picker:")
		picker7_text:SetPoint("TOPLEFT", picker6_text, "BOTTOMLEFT", 0, -15)

		local picker7 = LolzenUI_Options.createPicker("template", "statusbar", "example_picker_statusbar", 140, "LolzenUI Standard")
		picker7:SetPoint("LEFT", picker7_text, "RIGHT", -10, -3)

		local picker8_text = LolzenUI_Options.createFontstring("template", "background picker:")
		picker8_text:SetPoint("TOPLEFT", picker7_text, "BOTTOMLEFT", 0, -15)

		local picker8 = LolzenUI_Options.createPicker("template", "background", "example_picker_background", 140, "LolzenUI Standard")
		picker8:SetPoint("LEFT", picker8_text, "RIGHT", -10, -3)

		local picker9_text = LolzenUI_Options.createFontstring("template", "border picker:")
		picker9_text:SetPoint("TOPLEFT", picker8_text, "BOTTOMLEFT", 0, -15)

		local picker9 = LolzenUI_Options.createPicker("template", "border", "example_picker_border", 140, "LolzenUI Standard")
		picker9:SetPoint("LEFT", picker9_text, "RIGHT", -10, -3)

		--[[	These are the okay & default functions
				with these funcions we tell the optionpanel what to do when we press the okay or default buttons
				
				In this example we only set the saved variable "LolzenUIcfg.template["template_checkbox"]" to the status which cb1 is set on okay, or true on default
				Normally you would set every option we have in these two functions, else as you an test, the picker and editbox options aren't saved
		]]
		LolzenUI_Options["template"].okay = function(self)
			LolzenUIcfg.template["template_checkbox"] = cb1:GetChecked()
		end

		LolzenUI_Options["template"].default = function(self)
			LolzenUIcfg.template["template_checkbox"] = true
			ReloadUI()
		end
	end
end)
