-------------------------------------------------------------------------------
-- Class HighlandsBiome
if HighlandsBiome == nil then
	HighlandsBiome = EternusEngine.BiomeClass.Subclass("HighlandsBiome")
end

-------------------------------------------------------------------------------
function HighlandsBiome:BuildTree()

		local theMaterials = self:SwitchMaterial(self:Material("Cliff Rock Gray"), self:Material("Dark Mountain Grass"), self:Simplex((1.0 / 16.0) / 1.0, 1))

		--terrain
		local theterrain = self:Constant(140)
		local x = self:Multiply(self:Simplex(((1.0 / 32.0) / 12.0), 4), self:Constant(300))
		x = self:Add(x, theterrain)
		local y = self:Multiply(self:Simplex(((1.0 / 32.0) / 12.0), 4), self:Constant(30))
		y = self:Add(y, theterrain)
		local z = self:Max(x, y)
		theterrain = self:Max(z, self:Constant(120))
		
		return theterrain, theMaterials
end

HighlandsBiome.Lighting =
{
	AmbientColor = vec3.new(1.0, 0.0, 0.0),
	Intensity = 1.0,
	DayColor = vec3.new(1.0, 0.0, 0.0),
	NightColor = vec3.new(1.0, 0.0, 0.0)
}

HighlandsBiome.Objects =
{
	["Lotus Teeth"] =
	{
		density = 2,
		chance = 0.05,
		minScale = 0.5,
		maxScale = 2.0
	},
	["Bush Hosta A"] =
	{
		density = 3,
		chance = 0.15,
		minScale = 1.0,
		maxScale = 2.5
	},
	["Portal Stone"] =
	{
		density = 1,
		chance = 0.0012,
		minScale = 1.0,
		maxScale = 1.0
	},
}

HighlandsBiome.Clusters =
{
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
	 	chance = 0.2,
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
	}
}

-------------------------------------------------------------------------------
-- Register the HighlandsBiome Generator with the engine.
Eternus.ScriptManager:NKRegisterGeneratorClass(HighlandsBiome)