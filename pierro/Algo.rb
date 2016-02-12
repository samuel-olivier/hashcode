#!/usr/bin/env ruby

class Algo
	def initialize(map = nil)
		unless map
			raise "Hmhm ??"
		end
		@map = map
	end

	# bootstraps
	def sortSizeOrderedProduct()
		productTypes = @map.productTypes
		nbProduct = productTypes.count
		weighs = []
		@map.orders.each do |order|
			order.getItems.each do |type|
				weighs << type.weigh
			end
		end
		@sortedByWeight = weighs.each_with_index.sort.reverse.map &:last
	end
	def averagePerStock()
		nbProduct = @map.productTypes.count
		@total = Array.new(nbProduct, 0)
		@average = Array.new(nbProduct, 0)
		@map.orders.each do |order|
			order.getItems.each do |type|
				@total[type.index] += 1
			end
		end
		i = 0
		@total.each do |nbType|
			@average[i] = nbType.to_f / nbProduct.to_f
			i += 1
		end
		@average
	end
	def reorganizeAverage()
		@indexedAverage = @average.each_with_index.sort.reverse.map &:last
	end

	# maestros
	def loadDronesWithAveragePayload()
		# the purpose here is to take care of the big part of the orders first without considering orders as objects.

		@map.drones(nil, :no).each do |drone|
			p @map.productTypes[@indexedAverage.first], @total[@indexedAverage.first]
			@total[@indexedAverage.first] -= 1
		end
	end
end

if __FILE__ == $0

	require_relative 'Map'
	require_relative 'ProductType'
	require_relative 'Warehouse'
	require_relative 'Order'
	require_relative 'Drone'

	# below the subject example
	map = Map.new 100, 100
	map.add :productType, ProductType.new(0, 100)
	map.add :productType, ProductType.new(0, 5)
	map.add :productType, ProductType.new(0, 450)
	warehouse = Warehouse.new(0, 0)
	warehouse.add 5
	warehouse.add 1
	warehouse.add 0
	map.add :drone, Drone.new(warehouse, 500)
	map.add :drone, Drone.new(warehouse, 500)
	map.add :drone, Drone.new(warehouse, 500)
	map.add :warehouse, warehouse
	warehouse = Warehouse.new(5, 5)
	warehouse.add 0
	warehouse.add 10
	warehouse.add 2
	map.add :warehouse, warehouse
	map.add :order, Order.new(1, 1, [map.productTypes[2], map.productTypes[0]])
	map.add :order, Order.new(3, 3, [map.productTypes[0], map.productTypes[0], map.productTypes[0]])
	map.add :order, Order.new(5, 6, [map.productTypes[2]])

p map
	# Algo.new map

end
