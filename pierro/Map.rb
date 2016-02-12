#!/usr/bin/env ruby

class Map
	def initialize(row = 0, column = 0)
		# size
		@row = row
		@column = column

		# instances
		@warehouses = []
		@productTypes = []
		@orders = []
		@drones = []
	end

	def add(type, item)
		if type == :warehouse
			@warehouses << item
		elsif type == :productType
			@productTypes << item
		elsif type == :order
			@orders << item
		elsif type == :drone
			@drones << item
		end
	end
	def warehouses(index = nil)
		if index
			if index == :last
				@warehouses.last
			elsif index == :first
				@warehouses.first
			end
			@warehouses[index]
		end
		@warehouses
	end
	def productTypes(index = nil)
		@productTypes[index] if index
		@productTypes
	end
	def orders(index = nil, pending = :no)
		@orders[index] if index
		@orders.each do |order|
			order if pending != :indf && order.pending? == ((pending == :yes) ? true : false)
		end
		@orders
	end
	def drones(index = nil, busy = :no)
		@drones[index] if index
		@drones.each do |drone|
			drone if busy != :indf && drone.busy? == ((busy == :yes) ? true : false)
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
