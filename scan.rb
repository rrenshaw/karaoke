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
end

s=Scan.new
s.scan('/karaoke')
