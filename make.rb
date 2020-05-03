# Ruby script to produce the final HTML files by inserting the desired content
# stored in the plain txt files inside the bare HTML file that contains
# the common structure of all pages of the site. The title of the section
# has to be specified as a parameter.
#
# The naming of the plain text files is important. If it doesn't contain an
# underscore, it will be assumed to be a main section, and if it does,
# it will be assumed to be a subsection. The name of the file will be used
# to name the HTML files, the sections, etc.
#
# Note: Something like ERB could be used for this purpose more efficiently.
#
# Eddy, Feb 2020.

if ARGV.length == 0
  entries = Dir.entries("plain")
  files = entries.select{ |f| File.file?("plain/" + f) && !f[/_/] }.map{ |f| f[0..-5].downcase }
  subfiles = files.map{ |f|
    [
      f,
      entries.select{ |sf| File.file?("plain/" + sf) && !!sf[/_/] && sf.split("_")[0] == f }.map{ |sf| sf[0..-5].downcase }
    ]
  }.to_h
else
  files = ARGV.map(&:downcase)
end

def update_file(file, superfile = "")
  if !File.exist?("plain/" + file + ".txt")
    puts "File " + file + ".txt not found."
    return
  end

  # Use titleize (Rails) to capitalize all initial letters
  bare = File.read("bare.html")
  content = File.read("plain/" + file + ".txt")
  link = file != "index" ? "> <a href=\"http://edelkas.github.io/#{!superfile.empty? ? superfile : file}\">#{(!superfile.empty? ? superfile : file).capitalize}</a>" : ""
  sublink = !superfile.empty? ? "> <a href=\"http://edelkas.github.io/#{file}\">#{file.capitalize}</a>" : ""
  full = bare.gsub("ruby_content", content)
              .gsub("ruby_link", link)
              .gsub("ruby_sublink", sublink)
              .gsub("ruby_title", (file == "index" ? "home" : file).capitalize)
              .gsub("ruby_date", Time.now.strftime("%Y-%m-%d"))
  File.write(file + ".html", full)
end

files.each{ |f|
  update_file(f)
  subfiles[f].each{ |sf|
    update_file(sf, f)
  }
}
