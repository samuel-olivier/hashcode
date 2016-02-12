#!/usr/bin/env ruby

require_relative 'Map'
require_relative 'ProductType'
require_relative 'Warehouse'
require_relative 'Order'

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
		while nbWarehouse > 0 do
			row, column = lines.shift
			map.add :warehouse, Warehouse.new(row, column)
			lines.shift.each do |nbProduct|
				map.warehouses(:last).add nbProduct
			end
			nbWarehouse -= 1
		end

		# orders
		nbOrder = lines.shift.first.to_i
		orders = []
		while nbOrder > 0 do
			row, column = lines.shift
			nbItem = lines.shift.first.to_i
			orders << Order.new(row, column, lines.shift)
			nbOrder -= 1
		end
		# p map.warehouses :first
		# p orders
		# p lines
		# drones = Drone.new
	end

end
