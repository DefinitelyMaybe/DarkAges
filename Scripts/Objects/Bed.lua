include("Scripts/Interactable.lua")
include("Scripts/Objects/PlaceableObject.lua")

-------------------------------------------------------------------------------
Bed = PlaceableObject.Subclass("Bed")

-- Mixins
--Bed.Mixin(Interactable)

Bed.StaticMixin(Interactable)

-- Static variables
Bed.HealthRestored = 10.0
Bed.StaminaRestored = 10.0
Bed.EnergyRestored = 10.0
Bed.FadeColor = "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000"

-------------------------------------------------------------------------------
--Register Events
Bed.RegisterScriptEvent("ClientEvent_LockPlayer",
	{
		playerToAffect = "gameobject"
	}
)

Bed.RegisterScriptEvent("ClientEvent_FadeIn",
	{
	}
)

Bed.RegisterScriptEvent("ClientEvent_UnlockPlayer",
	{
	}
)

-------------------------------------------------------------------------------
function Bed:Constructor(args)
	self.m_sleepTimer = 0.0
	self.m_flashTimer = 0.0
	self.m_flashing = false
	self.m_interactor = nil
	self.m_whoUsedMe = nil
end

-------------------------------------------------------------------------------
function Bed:PostLoad()
	Bed.__super.PostLoad(self)
end

-------------------------------------------------------------------------------
function Bed:Spawn()
end
 
-------------------------------------------------------------------------------
function Bed:Despawn()
end

-------------------------------------------------------------------------------
function Bed:Update(dt)
	if self.m_sleepTimer > 0.0 then
		self.m_sleepTimer = self.m_sleepTimer - dt
		if self.m_sleepTimer <= 0.0 then
			self.m_sleepTimer = 0.0
			if Eternus.IsServer then
	 			self:RaiseClientEvent("ClientEvent_UnlockPlayer", { })
	 			self.m_interactor = nil
				self:NKEnableScriptProcessing(false)
	 		end
		end
	end

	if self.m_flashing then
	 	self.m_flashTimer = self.m_flashTimer - dt
	 	if self.m_flashTimer <= 0.0 then
	 		self.m_flashing = false
	 		if Eternus.IsServer then
				self.m_interactor:OnSleep( self )
	 			self:RaiseClientEvent("ClientEvent_FadeIn", { })
	 		end
		end
	 end
end

-------------------------------------------------------------------------------
function Bed:Interact( args )
	
	local player = args.player

	if player and self.m_interactor == nil then
			self.m_interactor = player
			player:ModifyHitPoints(self.HealthRestored)
			player:_ModifyStamina(self.StaminaRestored)
			player:_ModifyEnergy(self.EnergyRestored)

			local pos = player:NKGetPosition()
			player.m_connection:NKSetRespawnLocation(pos)
			self:RaiseClientEvent("ClientEvent_LockPlayer", { playerToAffect = player}, { player.m_connection })
			
			self.m_sleepTimer = 8.0
			self.m_flashTimer = 4.0
			self.m_flashing = true
			self:NKEnableScriptProcessing(true)
			return true
	end
	
	return false
end

-------------------------------------------------------------------------------
-- Client event to lock player in place
function Bed:ClientEvent_LockPlayer( args )
	if args.playerToAffect then
		local player = args.playerToAffect
		player:PlayOverlayFlash(0.0, 1.0, 4.0, self.FadeColor)
		player:SetActionLock(true)
		player:SetMovementLock(true)
		self.m_whoUsedMe = player
	end
end

-------------------------------------------------------------------------------
-- Client event to lock player in place
function Bed:ClientEvent_UnlockPlayer()
	if self.m_whoUsedMe then
		self.m_whoUsedMe:SetActionLock(false)
		self.m_whoUsedMe:SetMovementLock(false)
		self.m_whoUsedMe = nil
	end
end

-------------------------------------------------------------------------------
-- Client event to lock player in place
function Bed:ClientEvent_FadeIn()
	if self.m_whoUsedMe then
		self.m_whoUsedMe:PlayOverlayFlash(1.0, 0.0, 4.0, self.FadeColor)
		if Eternus.IsServer then
			local time = Eternus.World:NKGetMilitaryTime()
			if (time >= 1750) or (time <= 650) then
				Eternus.World:NKSetMilitaryTime(650)
			else
				Eternus.World:NKSetMilitaryTime(time + 100)
			end
		end
	end
end
-------------------------------------------------------------------------------
EntityFramework:RegisterGameObject(Bed)