local CustomMicroMapGenerator = class()

function CustomMicroMapGenerator:_quantize(micro_map)
	local quantizer = self._biome:get_quantizer()
	local plains_max_height = self._terrain_info.plains.height_max
	local foothills_base = self._terrain_info.foothills.height_max
	local exp = 2

	micro_map:process(
		function (value)
			if value <= plains_max_height then
				return plains_max_height
			end
			if value <= foothills_base then
				return foothills_base
			end
			-- x = (value - 35) / 165
			-- new_value = 35 + 165 * (x ^ exp)
			return quantizer:quantize( 35 + 165 * (((value*2 - 35) / 165) ^ exp) )
		end
		)
end

return CustomMicroMapGenerator