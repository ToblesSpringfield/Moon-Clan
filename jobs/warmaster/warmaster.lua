local CraftingJob = require 'stonehearth.jobs.crafting_job'

local WarmasterClass = class()
radiant.mixin(WarmasterClass, CraftingJob)

function WarmasterClass:initialize()
   CraftingJob.initialize(self)
   self._sv.max_num_siege_weapons = {}
end

function WarmasterClass:activate()
   CraftingJob.activate(self)

   if self._sv.is_current_class then
      self:_register_with_town()
   end

   self.__saved_variables:mark_changed()
end

function WarmasterClass:restore()
   if self._sv.is_current_class then
      self:_register_with_town()
   end
end

function WarmasterClass:promote(json_path, options)
   CraftingJob.promote(self, json_path, options)
   self._sv.max_num_siege_weapons = self._job_json.initial_num_siege_weapons or { turret = 0, trap = 0 }
   if next(self._sv.max_num_siege_weapons) then
      self:_register_with_town()
   end
   self.__saved_variables:mark_changed()
end

function WarmasterClass:demote()
   local player_id = radiant.entities.get_player_id(self._sv._entity)
   local town = stonehearth.town:get_town(player_id)
   if town then
      town:remove_placement_slot_entity(self._sv._entity)
   end

   CraftingJob.demote(self)
end

function WarmasterClass:increase_max_placeable_siege(args)
   self._sv.max_num_siege_weapons = args.max_num_siege_weapons
   self:_register_with_town() -- re-register with the town because number of max attended hearthlings is increased
   self.__saved_variables:mark_changed()
end

function WarmasterClass:_create_listeners()
   CraftingJob._create_listeners(self)
   self._on_repair_entity_listener = radiant.events.listen(self._sv._entity, 'stonehearth:repaired_entity', self, self._on_repaired_entity)
end

-- Called by base job on demote
function WarmasterClass:_remove_listeners()
   CraftingJob._remove_listeners(self)
   if self._on_repair_entity_listener then
      self._on_repair_entity_listener:destroy()
      self._on_repair_entity_listener = nil
   end
end

function WarmasterClass:_on_repaired_entity(args)
   local key = args.action or 'repair_entity'
   local exp = self._xp_rewards[key]
   if exp then
      self._job_component:add_exp(exp)
   end
end

function WarmasterClass:_register_with_town()
   local player_id = radiant.entities.get_player_id(self._sv._entity)
   local town = stonehearth.town:get_town(player_id)
   if town then
      town:add_placement_slot_entity(self._sv._entity, self._sv.max_num_siege_weapons)
   end
end

return WarmasterClass