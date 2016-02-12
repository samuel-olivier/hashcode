#!/usr/bin/env ruby

class Map
	def initialize(row = 0, column = 0)
		# size
		@row = row
		@column = column

		# instances
		@warehouses = []
		@drones = []
		@orderDests = []
	end

	def add(type, item)
		if type == :warehouse
			@warehouses << item
		elsif type == :drone
			@drones << item
		end
	end
	def warehouses(index = nil)
		if index
			if index == :last
				return @warehouses.last
			elsif index == :first
				return @warehouses.first
			end
			return @warehouses[index]
		end
		@warehouses
	end
	def drones(index = nil, busy = :no)
		@drones[index] if index
		@drones.each do |drone|
			drone if busy != :indf && drone.busy? == ((busy == :yes) ? true : false)
		end
	end
	def orderDests(index = nil, pending = :no)
		@orderDests[index] if index
		@orderDests.each do |orderDest|
			orderDest if pending != :indf && orderDest.pending? == ((pending == :yes) ? true : false)
		end
	end

	def to_s()
		"[" + @row.to_s + ", " + @column.to_s + "]"
	end
end

if __FILE__ == $0

	map = Map.new
	p map
end
