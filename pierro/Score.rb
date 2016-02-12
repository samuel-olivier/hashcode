#!/usr/bin/env ruby

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

	nbCommand = lines.shift.first
	(1..nbCommand).each do
		p lines.shift
	end

	p "EOF" if lines.count

end
