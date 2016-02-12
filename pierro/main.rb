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
	  opts.banner = "Usage: main.rb [-i|--file FILENAME]"

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
		productTypes = []
		lines.shift.each do |weigh|
			productTypes << ProductType.new(weigh)
		end

		# warehouses
		nbWarehouse = lines.shift.first.to_i
		(0..nbWarehouse).each do
			row, column = lines.shift
			warehouse = Warehouse.new(row, column)
			map.add :warehouse, warehouse
			lines.shift.each do |nbProduct|
				warehouse.add nbProduct
			end
			map.add :drone, Drone.new(warehouse, maxPayload.to_i)
		end

		# orders
		nbOrder = lines.shift.first.to_i
		orders = []
		(0..nbOrder).each do
			row, column = lines.shift
			nbItem = lines.shift.first.to_i
			orders << Order.new(row, column, lines.shift)
		end

		p map.drones
		# Calculus
		algo = Algo.new map
	end

end
