#!/usr/bin/env ruby

require_relative 'Warehouse'

class Drone
	def initialize(warehouseStart, maxPayload)
		# start warehouse
		@warehouseStart = warehouseStart
		@row, @column = warehouseStart.getPosition

		# ---
		@busy = false
		@warehouseRelate = warehouseStart
	end

	def busy?()
		@busy
	end

	def to_s()
		"[" + @row.to_s + ", " + @column.to_s + "]"
	end
end

if __FILE__ == $0



end
