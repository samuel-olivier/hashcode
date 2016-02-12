#!/usr/bin/env ruby

require_relative 'Warehouse'

class Drone
	def initialize(warehouseStart, maxPayload)
		# start warehouse
		@warehouseStart = warehouseStart
		@row, @column = warehouseStart.getPosition
		@maxPayload = maxPayload
		@curPayload = 0

		# ---
		@busy = false
		@warehouseRelate = warehouseStart
		@payload = []
	end

	def getPosition()
		[@row, @column]
	end
	def busy?()
		@busy
	end
	def busy!(state = :toggle)
		@busy != true if state == :toggle
		@busy = state
	end
	def full(min = 0)
		@maxPayload - @curPayload > min
	end
	def load(productType)
		unless productType.is_a?(ProductType)
			raise "Drones should only carry ProductType classes."
		end
		if productType.weigh <= @maxPayload - @curPayload
			@payload << productType
			return @curPayload += productType.weigh
		end
		return 0
	end

	def to_s()
		"[" + @row.to_s + ", " + @column.to_s + "]"
	end
end

if __FILE__ == $0



end
