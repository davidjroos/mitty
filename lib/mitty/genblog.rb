module Mitty
  class Genblog

    attr_accessor :input_path, :output_path

    def initialize(input_path, output_path)
      @input_path = input_path
      @output_path = output_path
    end

    # Public: Creates "thumbnail" versions of all jpg images in the @input_path directory.
    # Outputs the thumbnails to a folder named for today's current date within
    # the @output_path directory.
    #
    # Returns a String denoting the path to which the thumbnails were outputted
    def init_blogpost(title, date)
      #start draft blog output
      blogdraft = File.open("#{output_path}.md", "w")
      #blog front matter
      blogdraft.puts "---\n"
      blogdraft.puts "layout: post\n"
      blogdraft.puts "title: '#{title}'\n"
      blogdraft.puts "date: #{date}\n"
      blogdraft.puts "category: \n"
      blogdraft.puts "tags:\n"
      blogdraft.puts "description: ''\n"
      blogdraft.puts "post_image:\n"
      blogdraft.puts "bw: false\n"
      blogdraft.puts "---\n\n"
      blogdraft.close
      #end draft blog output
    end

    def blogpicture(title, sizes)
      blogdraft = File.open("#{output_path}.md", "a")
      Dir.glob("#{input_path}/*.{jpg,jpeg}").each do |jpg_file|
        blogdraft.puts "<p class='wideimage'><img src='https://s3-ap-southeast-2.amazonaws.com/davidroos.co.nz/photos/#{title}/#{File.basename(jpg_file, '.*')}_#{sizes[0]}.jpg' srcset='https://s3-ap-southeast-2.amazonaws.com/davidroos.co.nz/photos/#{title}/#{File.basename(jpg_file, ".*")}_#{sizes[2]}.jpg #{sizes[2]}w, https://s3-ap-southeast-2.amazonaws.com/davidroos.co.nz/photos/#{title}/#{File.basename(jpg_file, '.*')}_#{sizes[1]}.jpg #{sizes[1]}w, https://s3-ap-southeast-2.amazonaws.com/davidroos.co.nz/photos/#{title}/#{File.basename(jpg_file, '.*')}_#{sizes[0]}.jpg #{sizes[0]}w' sizes='100vw' width='#{sizes[2]}'/></p>"
      end
      blogdraft.close
    end
  end
end
