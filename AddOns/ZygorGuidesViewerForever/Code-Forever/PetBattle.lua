local name,ZGV = ...

local PetBattle = {}
ZGV.PetBattle = PetBattle

PetBattle.SpeciesByDisplayId = {}
PetBattle.NPCIdBySpeciesId = {}
for i=1,6000 do
	local name, _, _, companionID = C_PetJournal.GetPetInfoBySpeciesID(i)
	if companionID then
		PetBattle.SpeciesByDisplayId[companionID] = i
		PetBattle.NPCIdBySpeciesId[i]=companionID
	end
end