# ======= ======= ======= trail_seed.rb ======= ======= =======
# require 'Nokogiri'
# require 'JSON'

module Trailseed

    def self.trail_seed()
        puts "\n******* trail_seed *******"
        raw_data = []
        puts "\n=== First Loop ==="
        Dir.glob('public/*.geojson') do |geojson|
            puts "\n*** Loop through geojson files ***"
            # puts "geojson.type #{geojson}"
            # puts " before raw_data: #{raw_data.inspect}"
            file_name = geojson
            puts "file_name: #{file_name.inspect}"
            file_data = File.read(geojson)
            puts "file_data: #{file_data.inspect}"
            raw_data.push({file_name:file_name, file_data:file_data})
            puts "raw_data.length: #{raw_data.length}"
            puts "after raw_data: #{raw_data.inspect}"
        end
        puts "\n=== Second Loop ==="
        raw_data.each do |d|
            # puts "d.file_data:, #{d.file_data,inspect} "
            puts "d[:file_name]:, #{d[:file_name].inspect} "
            parsed_data = JSON.parse(d[:file_data])
            # puts "parsed_data: #{parsed_data}"
            data = parsed_data['features']
            data.each do |feature|
                puts "d[:file_name]: #{d[:file_name].inspect}"
                puts "feature['properties']['NAME']: #{feature['properties']['NAME'].inspect}"
                puts "feature['properties']['MILES']: #{feature['properties']['MILES'].inspect}"
                Trail.create([
                    { name:feature['properties']['NAME'], length:feature['properties']['MILES'], filename:d[:file_name],  }
                ])
            end
        end
    end
end
