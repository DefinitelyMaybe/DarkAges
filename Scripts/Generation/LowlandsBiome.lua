-------------------------------------------------------------------------------
-- Class LowlandsBiome
if LowlandsBiome == nil then
	LowlandsBiome = EternusEngine.BiomeClass.Subclass("LowlandsBiome")
end

-------------------------------------------------------------------------------
function LowlandsBiome:BuildTree()
	--Top level materials
	local grass1 = self:SwitchMaterial(self:Material("Green Hills"), self:Material("Mountain Green Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

	local grass2 = self:SwitchMaterial(self:Material("Mountain Green Grass"), self:Material("Forest Tall Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

	local theMaterials = self:SwitchMaterial(grass1, grass2, self:Simplex((1.0 / 64.0) / 1.0, 2))

	--The small terrain wobbles
	local theWobbles = self:Multiply(self:Simplex(((1.0 / 32.0) / 1.0), 2), self:Constant(1))

	--Sparse hills
	local hills1 = self:Multiply(self:Simplex((1.0 / 128.0) / 3.0, 4), self:Constant(30))

	--blend the hills into the wobbles
	local theterrain = self:Max(theWobbles, hills1)
	
	--Add the constant so that it blend well with other biomes.
	theterrain = self:Add(theterrain, self:Constant(90))

	return theterrain, theMaterials
end

LowlandsBiome.Lighting =
{
	AmbientColor = vec3.new(1.0, 0.0, 0.0),
	Intensity = 1.0,
	DayColor = vec3.new(1.0, 0.0, 0.0),
	NightColor = vec3.new(1.0, 0.0, 0.0)
}

LowlandsBiome.Objects =
{
	--Characters 
	["MamaGoat Spawn Node"] =
	{
		density = 1,
		chance = 0.04,
		minScale = 1.0,
		maxScale = 1.5
	},
	--Plants
	["Lotus Teeth"] =
	{
		density = 2,
		chance = 0.1,
		minScale = 0.5,
		maxScale = 2.0
	},
	["Lilly Pad Nut"] =
	{
		density = 1,
		chance = 0.025,
		minScale = 0.5,
		maxScale = 1.0
	},
	["Green Vine"] =
	{
		density = 4,
		chance = 0.03,
		minScale = 1.0,
		maxScale = 1.5
	},
	["Gourd Vine"] =
	{
		density = 3,
		chance = 0.02,
		minScale = 1.0,
		maxScale = 1.5
	},
	["Bush Hosta A"] =
	{
		density = 3,
		chance = 0.15,
		minScale = 1.0,
		maxScale = 2.5
	},

	--Trees 
	["Maple Tree"] =
	{
		density = 4,
		chance = 0.4,
		minScale = 1.0,
		maxScale = 2.5
	},
	["Winter Maple Tree"] =
	{
		density = 1,
		chance = 0.05,
		minScale = 1.0,
		maxScale = 2.5
	},
	["Watouwr Tree"] =
	{
		density = 1,
		chance = 0.0012,
		minScale = 2.0,
		maxScale = 4.0
	},
	["Hardwood Sapling"] =
	{
		density = 2,
		chance = 0.03,
		minScale = 0.7,
		maxScale = 2.0
	},
	["Lightwood Sapling"] =
	{
		density = 2,
		chance = 0.03,
		minScale = 0.7,
		maxScale = 2.0
	}
}

LowlandsBiome.Clusters =
{
	--Rocks
	["Rock Cluster Dense"] =
	{
	 	density = 1,
	 	chance = 0.03,
		Objects =
		{
			{
				name = "Loot Object",
				offset = vec3.new(0.5, 0.0, 0.5),
				data = {
					lootName = "Round Rock",
					decayTime = 0.0
				}
			},
			{
				name = "Rock08 Green",
				minScale = 2.0,
				maxScale = 2.5,
				offset = vec3.new(1.0, 0.0, -3.0)
			},
			{
				name = "Rock10 Green",
				minScale = 2.5,
				maxScale = 3.5,
				offset = vec3.new(6.0, 0.0, 2.0)
			}, 
			{
				name = "Rock09 Green",
				minScale = 2.0,
				maxScale = 4.0,
				offset = vec3.new(-1.0, 0.0, 2.0)
			}
		}
	},
	["Rock Cluster Sparse"] =
	{
	 	density = 1,
	 	chance = 0.05,
		Objects =
		{
			{
				name = "Rock08 Green",
				minScale = 2.0,
				maxScale = 2.5,
				offset = vec3.new(10.0, 0.0, -6.0)
			},
			{
				name = "Rock10 Green",
				minScale = 2.5,
				maxScale = 3.5,
				offset = vec3.new(6.0, 0.0, 10.0)
			},
			{
				name = "Loot Object",
				offset = vec3.new(5.0, 0.0, 9.0),
				data = {
					lootName = "Round Rock",
					decayTime = 0.0
				}
			},
			{
				name = "Rock09 Green",
				minScale = 2.0,
				maxScale = 4.0,
				offset = vec3.new(-10.0, 0.0, 4.0)
			}
		}
	},
	--Plants
	["Gourd Vines with fruit"] =
	{
	 	density = 2,
	 	chance = 0.02,
		Objects =
		{
			{
				name = "Purple Gourd",
				offset = vec3.new(1.0, 0.0, -0.5)
			},
			{
				name = "Gourd Vines",
				offset = vec3.new(0.0, 0.0, 0.0)
			},
			{
				name = "Gourd Vines",
				offset = vec3.new(-1.0, 0.0, 3.0)
			}
		}
	},
	--Misc
	["Camping Grounds"] =
	{
	 	density = 1,
	 	chance = 0.0025,
		Objects =
		{
			{
				name = "Fire Pit",
				minScale = 1.0,
				maxScale = 1.0,
				offset = vec3.new(0.0, 0.0, 0.0)
			},
			{
				name = "Leaf Backpack",
				minScale = 1.0,
				maxScale = 1.0,
				offset = vec3.new(1.0, 0.0, -2.0)
			},
			{
				name = "Flat Rock",
				offset = vec3.new(1.0, 0.0, -3.0)
			}
		}
	},
	["Ruins"] =
	{
	 	density = 1,
	 	chance = 0.01,
		Objects =
		{
			{
				name = "Stonehenge Green",
				minScale = 1.0,
				maxScale = 2.0,
				offset = vec3.new(0.0, 0.0, 0.0)
			},
			{
				name = "Flat Rock",
				offset = vec3.new(2.0, 0.0, -4.0)
			}
		}
	}
}

-------------------------------------------------------------------------------
-- Register the LowlandsBiome Generator with the engine.
Eternus.ScriptManager:NKRegisterGeneratorClass(LowlandsBiome)