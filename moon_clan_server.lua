moon_clan = {}

--[[

Equips:
	Fancy outfit (tier3)
	New Beast Tamer armors
	Look at Beast Tamer weapons again
	New Spirit Walker armor
	New Spirit Walker weapons

Decorations/Furniture:
	Giant rug or wall hanging rug
	Goblinfied vanilla_lampposts
	Lamp post and wallhanging versions of lamps/lanterns
	Mat/rug/mosaic 
	More statues
	Painting/tapestry, banner wall, awning
	Weapon/armor decorations (stands from ACE)
	Fancy beds
	Thrones
	Drying rack
	Look at ACE for beds
	Base and comfortable versions of furniture
	Tiles like SG base mod
	"Clan Lua" concept items implementation


Templates:
	Tier 1
	Tier 2
	Tier 3
	(hopefully get Banto or competition people to make it)

Redo:
	Travel stall with moon clan influence
	Cultural spin on all classes clothing! (like RC)

Items with effects:
	Speed up crafting with bonus from nearby items
	Animals haulers requiring food and care (like idea in Shaman section)
	Varanus/mobs/undead (for only lower levels?) repelent
	Bug nests or other mob structures for egg raiders

Goblinpedia:
	Moon Clan backstory
	Warmaster
	Make sure every class has a bit of info

Quests:
	Make new orc/kobold gongs
	Undeads patrols/hordes that pass through. Choose to fight or hide.

Ace stuff:
	Look at beds
	Find out more about ACE

Mobs:
	TBD
	Look at ACE?

Jobs:
	Warsmith
		Crafting stations re-makes/adjustments
		Silver Armor/Weapons
		Snake Blessed Armor/Weapons

	Tinkerer (engineer)
		Ace Engineer port over 
		Blowdart trap
		Swinging log trap
		Beehive trap

	Alchemist 
		Take potions away from Shaman

	Shaman
		Herbal medicines instead of potions
		Spirit summoning of animals instead of engineer automatons (Maybe a collab with high level tamer to instead tame live ones?)
	
	Warrior rework:
		Promotes into tank at level 3
		Like a footman from base game

	Tank class (Warboss from Warhammer?):
		Better armor at lower lvl (like basegame)
		Taunting
		Silver Armor
		Snake Blessed Armor/Weapons

	Steam maker:
		cook(+ace_brewer)

	Grazer:
		farmer+shepherd

	Earthshaper:
		Remake furniture with cultural spin


	Fisher:
		Add some swamp and ACE fish

-----

Add ideas for new concepts here

-----



]]
function moon_clan:_on_biome_set(e)
	if e.biome_uri ~= "moon_clan:biome:floating_mountains" then
		return
	end
	local custom_overview_map = radiant.mods.require('swamp_goblins.services.server.world_generation.custom_overview_map')
	local overview_map = radiant.mods.require('stonehearth.services.server.world_generation.overview_map')
	radiant.mixin(overview_map, custom_overview_map)

	local custom_height_map_renderer = require('services.server.world_generation.custom_height_map_renderer')
	local height_map_renderer = radiant.mods.require('stonehearth.services.server.world_generation.height_map_renderer')
	radiant.mixin(height_map_renderer, custom_height_map_renderer)

	local custom_landscaper = radiant.mods.require('swamp_goblins.services.server.world_generation.custom_landscaper')
	local landscaper = radiant.mods.require('stonehearth.services.server.world_generation.landscaper')
	radiant.mixin(landscaper, custom_landscaper)

	local custom_micro_map_generator = require('services.server.world_generation.custom_micro_map_generator')
	local micro_map_generator = radiant.mods.require('stonehearth.services.server.world_generation.micro_map_generator')
	radiant.mixin(micro_map_generator, custom_micro_map_generator)

	local custom_world_generation_service = radiant.mods.require('swamp_goblins.services.server.world_generation.custom_world_generation_service')
	local world_generation_service = radiant.mods.require('stonehearth.services.server.world_generation.world_generation_service')
	radiant.mixin(world_generation_service, custom_world_generation_service)
end

radiant.events.listen_once(radiant, 'stonehearth:biome_set', moon_clan, moon_clan._on_biome_set)

return moon_clan