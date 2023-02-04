AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	PObj:SetMass( 5000 )

	local DriverSeat = self:AddDriverSeat( Vector(0,0,160), Angle(0,-90,0) )
	DriverSeat:SetCameraDistance( 0.75 )

	local Legs = {
		[1] = {
			id = "FL",
			name = "leg_front_left",
			ang = 180,
		},
		[2] = {
			id = "FR",
			name = "leg_front_right",
			ang = 0,
		},
		[3] = {
			id = "RL",
			name = "leg_rear_left",
			ang = 180,
		},
		[4] = {
			id = "RR",
			name = "leg_rear_right",
			ang = 0,
		},
	}

	for _, data in pairs( Legs ) do
		local ID = self:LookupAttachment( data.name )
		local Att = self:GetAttachment( ID )

		if not Att then self:Remove() return end

		local Leg = ents.Create( "lvs_walker_hsd_leg" )
		Leg:SetPos( Att.Pos )
		Leg:SetAngles( self:LocalToWorldAngles( Angle(0,data.ang,0) ) )
		Leg:Spawn()
		Leg:Activate()
		Leg:SetParent( self, ID )
		Leg:SetBase( self )
		Leg:SetBaseAngle( data.ang )
		Leg:SetLocationIndex( data.id )
	end
end

function ENT:OnTick()
	self:SetEngineActive( true )
end