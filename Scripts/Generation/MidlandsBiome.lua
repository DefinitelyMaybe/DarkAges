-------------------------------------------------------------------------------
-- Class MidlandsBiome
if MidlandsBiome == nil then
	MidlandsBiome = EternusEngine.BiomeClass.Subclass("MidlandsBiome")
end

-------------------------------------------------------------------------------
function MidlandsBiome:BuildTree()
	--Top level materials
	--------lowland Materials--------
	local dirtMix = self:SwitchMaterial(self:Material("Green Hills"), self:Material("Forest Mountain Dirt"), self:Simplex((1.0 / 64.0) / 1.0, 1))

	local shorterGrass1 = self:SwitchMaterial(dirtMix, self:Material("Forest Tall Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

	local tallerGrass1 = self:SwitchMaterial(self:Material("Mountain Grass"), self:Material("Forest Tall Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

	local lowLandsMaterials = self:SwitchMaterial(shorterGrass1, tallerGrass1, self:Simplex((1.0 / 64.0) / 1.0, 2))

	--------highland Materials--------
	--Cliff Rock Gray, Cliff Rock Light
	local shorterGrass2 = self:SwitchMaterial(self:Material("Cliff Rock Gray"), self:Material("Dark Mountain Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

	local tin = self:Material("Tin Ore")
	local copper = self:Material("Copper Ore")
	local oreMix = self:SwitchMaterial(copper, tin, self:Simplex((1.0 / 5.0) / 1.0, 2))

	local div1 = self:SwitchMaterial(oreMix, shorterGrass2, self:Simplex((1.0 / 10.0) / 1.0, 2))
	local div2 = self:SwitchMaterial(div1, shorterGrass2, self:Simplex((1.0 / 10.0) / 6.0, 1))
	local div3 = self:SwitchMaterial(div2, shorterGrass2, self:Simplex((1.0 / 16.0) / 4.0, 1))
	local div4 = self:SwitchMaterial(div3, shorterGrass2, self:Simplex((1 / 10) / 10, 1))
	local div5 = self:SwitchMaterial(div4, shorterGrass2, self:Simplex((1.0 / 30.0) / 15.0, 2))
	local div6 = self:SwitchMaterial(div5, shorterGrass2, self:Simplex((1.0 / 35.0) / 25.0, 3))

	local highLandsMaterials = self:SwitchMaterial(shorterGrass2, div6, self:Simplex((1.0 / 34.0) / 30.0, 4))

	------Highlands terrain------
	local hills = self:Constant(110)
	local x = self:Multiply(self:Simplex(((1.0 / 32.0) / 8.0), 2), self:Constant(60))
	local y = self:Multiply(self:Simplex(((1.0 / 32.0) / 8.0), 4), self:Constant(90))
	hills = self:Add(y, hills)
	hills = self:Add(x, hills)
	hills = self:Max(self:Constant(110), hills)

	------Lowlands terrain------
	local valleys = self:Constant(110)
	local a = self:Multiply(self:Simplex(((1.0 / 32.0) / 8.0), 4), self:Constant(5))
	valleys = self:Add(a, valleys)

	------combining the two------
	local theterrain = self:Switch(hills, valleys, self:Simplex((1.0 / 32.0) / 8.0, 4), highLandsMaterials, lowLandsMaterials)
	theterrain:NKSetThreshold(0.5)
	theterrain:NKSetFalloff(0.025)
	theterrain:NKSetMaterialThreshold(0.5)

	return theterrain
end

MidlandsBiome.Lighting =
{
	AmbientColor = vec3.new(1.0, 0.0, 0.0),
	Intensity = 1.0,
	DayColor = vec3.new(1.0, 0.0, 0.0),
	NightColor = vec3.new(1.0, 0.0, 0.0)
}

MidlandsBiome.Objects =
{
	--Characters 
	["MamaGoat Spawn Node"] =
	{
		density = 1,
		chance = 0.02,
		minScale = 1.0,
		maxScale = 1.5
	},
	--Plants
	["Lotus Teeth"] =
	{
		density = 2,
		chance = 0.05,
		minScale = 0.5,
		maxScale = 2.0
	},
	["Lilly Pad Nut"] =
	{
		density = 1,
		chance = 0.0125,
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
		density = 3,
		chance = 0.2,
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

MidlandsBiome.Clusters =
{
	--Rocks
	["Rock Cluster Dense"] =
	{
	 	density = 1,
	 	chance = 0.1,
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
	 	chance = 0.1,
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
	 	chance = 0.05,
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
	}
	--Misc
}

-------------------------------------------------------------------------------
-- Register the MidlandsBiome Generator with the engine.
Eternus.ScriptManager:NKRegisterGeneratorClass(MidlandsBiome)