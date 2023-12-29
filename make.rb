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
# Created: Feb 2020.
# Updated: Dec 2023.

documents = {
  'name'     => 'Documents',
  'filename' => 'docs',
  'files'    => [
    { 'name' => 'Tutorial A', 'filename' => 'tutoA' },
    { 'name' => 'Tutorial B', 'filename' => 'tutoB' },
    { 'name' => 'Tutorial C', 'filename' => 'tutoC' },
  ]
}

images   = { 'name' => 'Images',   'filename' => 'images'   }
tools    = { 'name' => 'Tools',    'filename' => 'tools'    }
websites = { 'name' => 'Websites', 'filename' => 'websites' }
about    = { 'name' => 'About',    'filename' => 'about'    }


root = {
  'name'     => 'Home',
  'filename' => 'index',
  'files'    => [
    documents,
    images,
    tools,
    websites,
    about
  ]
}

PREFIX    = '/n'
ROOT      = Dir.pwd
IN_FILES  = 'plain'
OUT_FILES = ''

def update_file(file, path = '')
  # Read plain TXT file
  fn = File.join(ROOT, IN_FILES, path, "#{file['filename']}.txt")
  if !File.file?(fn)
    puts "File #{fn} not found."
    return
  end
  content = File.read(fn)
  
  # Inject content inside our wrapper
  links = "#{path}/#{file['filename']}".split("/")[1..-1]
  links = links.inject(['']) { |acc, x| acc << acc.last + '/' + x }[1..-1]
  links = links.map.with_index{ |link, i| "<a href=\"#{PREFIX}#{link}.html\">#{link[/.*\/(.+)/, 1]}</a>" }.join(' > ')
  full = File.read("bare.html")
             .gsub("ruby_content",     content)
             .gsub("ruby_breadcrumbs", links)
             .gsub("ruby_title",       file['name'])
             .gsub("ruby_date",        Time.now.strftime("%Y-%m-%d"))
  
  # Write resulting HTML file
  out = File.join(ROOT, OUT_FILES, path)
  Dir.mkdir(out) unless Dir.exist?(out)
  File.write(File.join(out, file['filename'] + '.html'), full)

  # Parse sub-files, if any
  file['files'].each{ |f| update_file(f, File.join(path, file['filename'])) } if file.key?('files')
end

update_file(root)
