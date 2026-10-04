local EssenceKnowledgeBuff = class()

function EssenceKnowledgeBuff:on_buff_added(entity, buff)
    local job = stonehearth.job:get_job_info(radiant.entities.get_player_id(entity), "moon_clan:jobs:warmaster")
    job:manually_unlock_recipe("warfare:alligator_small_guardian")
	job:manually_unlock_recipe("warfare:essence_core")
end

return EssenceKnowledgeBuff