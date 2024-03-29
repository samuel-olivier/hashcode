#!/usr/bin/env ruby

require_relative 'Map'
require_relative 'ProductType'
require_relative 'Warehouse'
require_relative 'Order'
require_relative 'Drone'

require_relative 'Algo'

if __FILE__ == $0

	require 'optparse'

	options = {}
	OptionParser.new do |opts|
	  opts.banner = "Usage: " + $0 + " [-i|--file FILENAME]"

	  opts.on("-i", "--file=FILENAME", "the input file") do |v|
	    options[:inputfile] = v
	  end
	end.parse!

	lines = []
	(options[:inputfile] ? File.open(options[:inputfile]) : $<).each do |line|
		lines << line.split
	end

	if lines.count > 4
		# map
		row, column, nbDrones, turns, maxPayload = lines.shift
		map = Map.new row, column

		# productTypes
		nbProductType = lines.shift.first.to_i
		i = 0
		lines.shift.each do |weigh|
			map.add :productType, ProductType.new(i, weigh)
			i += 1
		end
		raise "productTypes gone wrong" unless nbProductType == map.productTypes.count

		# warehouses
		nbWarehouse = lines.shift.first.to_i
		(1..nbWarehouse).each do
			row, column = lines.shift
			warehouse = Warehouse.new(row, column)
			map.add :warehouse, warehouse
			lines.shift.each do |nbProduct|
				warehouse.add nbProduct
			end
			map.add :drone, Drone.new(warehouse, maxPayload.to_i)
		end
		raise "warehouses gone wrong" unless nbWarehouse == map.warehouses.count

		# orders
		nbOrder = lines.shift.first.to_i
		(1..nbOrder).each do
			row, column = lines.shift
			nbItem = lines.shift.first.to_i
			map.add :order, Order.new(row, column, lines.shift.map{|t| map.productTypes[t.to_i]})
		end
		raise "orders gone wrong" unless nbOrder == map.orders.count
# p map.orders
		# Calculus
		algo = Algo.new map
		p algo.sortSizeOrderedProduct
		algo.averagePerStock
		algo.reorganizeAverage
		algo.loadDronesWithAveragePayload

		# p "EOF" if lines.count
	end

end
