#!/usr/bin/ruby
#
require 'id3tag'

class File
	def self.artist(file)
		if file.match(/.mp3$/)
			ID3Tag.read(File.open(file)).artist
		else
			nil
		end
	end
	def self.title(file)
		if file.match(/.mp3$/)
			ID3Tag.read(File.open(file)).title
		else
			nil
		end
	end
end

class Scan
	def scan(dir)
		if ! File.directory?(dir) 
			throw "#{dir} is not a directory"
		end
		Dir.foreach(dir) do |d|
			path="#{dir}/#{d}"
			case 
			when File.file?(path)
				puts "#{path} is a file"
				if d.match(/.mp3$/)
					puts File.artist(path)
					puts File.title(path)
				end
			when File.directory?(path)
				puts "#{path} is a directory"
				next if d.match(/^.{1,2}$/)
				scan(path)
			else
				puts "#{path} is something else"
			end
		end
	end
	def scan_hash(dir)
		if ! File.directory?(dir) 
			throw "#{dir} is not a directory"
		end
		#puts "Scanning #{dir}"
		arr = []
		Dir.foreach(dir) do |d|
			path="#{dir}/#{d}"
			case 
			when File.file?(path)
				#puts "#{path} is a file"
				if d.match(/.mp3$/)
					artist = File.artist(path)
 					title  = File.title(path)
					if artist.nil?
						puts("File #{path} does not have an artist tag")
						artist = path.split(/ - /)[1]
					end
					if title.nil?
						puts("File #{path} does not have a title tag")
						title = path.split(/ - /)[2]
						title.gsub!(/.mp3/)
					end
				
					cdg = path.gsub(/.mp3$/,'.cdg')
					if ! File.file?("#{cdg}")
						puts "No matching CDG file for #{path}"
						base = path.gsub(/.mp3$/,'')
						puts `ls -l "#{base}"*`
					else
						#print '.'
						#puts File.title(path)
						#arr <<  {:artist => File.artist(path),
						#puts "#{{:artist => File.artist(path),
						#	:title => File.title(path),
						#	:path => path }}"
						track = Track.new({:artist => File.artist(path),
							:title => File.title(path),
							:path => path })
						track.save
					end
				end
			when File.directory?(path)
				#puts "#{path} is a directory"
				next if d.match(/^.{1,2}$/)
				arr << scan_hash(path)
			else
				puts "#{path} is something else"
			end
		end
		arr
	end
end
