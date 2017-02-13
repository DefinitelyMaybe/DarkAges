-- DarkAgesModScript
-------------------------------------------------------------------------------
if DarkAgesModScript == nil then
	DarkAgesModScript = EternusEngine.ModScriptClass.Subclass("DarkAgesModScript")
end

-------------------------------------------------------------------------------
function DarkAgesModScript:Constructor()
	NKPrint("Welcome to the Dark Ages.")
	DarkAgesModScript.LinkManager = include( "Scripts/Core/LinkManager.lua").new(self)
end

-------------------------------------------------------------------------------
-- Called once from C++ at engine initialization time
function DarkAgesModScript:Initialize()
	Eternus.CraftingSystem:ParseRecipeFile("Data/Crafting/PortalStone_recipe.txt", "Magic Items")
end

function DarkAgesModScript:Save()
	DarkAgesModScript.LinkManager:Save()
end

-------------------------------------------------------------------------------
function DarkAgesModScript:Restore()
	DarkAgesModScript.LinkManager:Restore()
end

-------------------------------------------------------------------------------
function DarkAgesModScript:Enter()
	--delete later--
	Eternus.World:NKSetMilitaryTime(1200)
	Eternus.World:NKSetTimeScale(0)
	----------------
	
	include("Scripts/Objects/ReturnStone.lua")
	include("Scripts/Mixins/PortalLinker.lua")

	local ReturnStoneConstructor = ReturnStone.Constructor

	ReturnStone.Constructor = function(self, args)
		ReturnStoneConstructor(self, args)
		self:Mixin(PortalLinker, args)
	end
end
-------------------------------------------------------------------------------
-- Called from C++ when the current game enters 
function DarkAgesModScript:Save()
	DarkAgesModScript.LinkManager:Save()
end

-------------------------------------------------------------------------------
-- Called from C++ when the game leaves it current mode
function DarkAgesModScript:Restore()
	DarkAgesModScript.LinkManager:Restore()
end
-------------------------------------------------------------------------------
EntityFramework:RegisterModScript(DarkAgesModScript)