require 'gnuplot'

def parseGeomData(filename)
	f = File.open(filename)

	geom_data = [[],[],[]] # format is radius, chord, twist
	f.each_line do |s|
		next if f.lineno < 2
		geom = s.split

		geom_data[0] << geom[0].to_f.round(5)
		geom_data[1] <<	geom[1].to_f
		geom_data[2] <<	geom[2].to_f*Math::PI/180
	end

	return geom_data
end


def parseAirfoil(filename)
	f = File.open(filename)
	result = []
	f.each_line do |line|
		next if f.lineno === 1
		result << [1-line.chomp.split[0].to_f,line.chomp.split[1].to_f]
	end
	return result
end

def writeSolidworksCurve filename, *axes
	n = File.new(filename,'w+')

	for i in 0...axes[0].length
		n << "#{axes[0][i]} #{axes[1][i]} #{axes[2][i]}\n"
	end
end