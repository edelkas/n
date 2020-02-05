# This is a Ruby script to automate html table creation
#
# {href: "", alt: "", title: "", text: "", header: false},

$table = [
  col1 = [
    {href: "", alt: "", title: "", text: "WEBSITES", header: true},
    {href: "", alt: "", title: "", text: "Community", header: true},
    {href: "https://discord.gg/nplusplus", alt: "", title: "There's also an N++ section in the official Droni forums", text: "The N++ Discord server", header: false},
    {href: "http://forum.droni.es/", alt: "", title: "Official, currently quite inactive", text: "The forums", header: false},
    {href: "http://n.infunity.com/", alt: "", title: "NReality download, highscoring statistics, level scores, 0th lists, and more.", text: "N Infunity (NReality's Homepage)", header: false},
    {href: "http://www.nmaps.net/", alt: "", title: "", text: "NUMA - The N User Map Archive", header: false},
    {href: "https://n.fandom.com/wiki/Main_Page", alt: "", title: "", text: "The Wiki", header: false},
    {href: "http://n-game-v2.forumactif.org/", alt: "", title: "The bastards created their own boards", text: "The N 2.0 forums", header: false},
    {href: "https://nv2.fandom.com/wiki/Nv2_Wiki", alt: "", title: "And their own Wiki, too!", text: "The N 2.0 Wiki", header: false},
    {href: "https://www.tapatalk.com/groups/metanetfr/", alt: "", title: "Partially recovered (original went down in 2012, lost attachments, user profiles, and more. Inactive but usable", text: "The old forums, archived (2004-2008)", header: false},
    {href: "https://web.archive.org/web/20081014101735/http://metanet.2.forumer.com/", alt: "", title: "Last Wayback Machine snap before the forums moved in 2008, lost in 2012", text: "The old forums, original", header: false},
    {href: "http://irc.mountai.net/", alt: "", title: "Metanet Community Directory", text: "Mountainet", header: false},
    {href: "http://irc.droni.es/", alt: "", title: "", text: "The IRC", header: false},
    {href: "", alt: "", title: "", text: "Official Metanet", header: true},
    {href: "http://www.thewayoftheninja.org/", alt: "", title: "", text: "Official N Website", header: false},
    {href: "http://www.thewayoftheninja.org/nv2.html", alt: "", title: "", text: "Play N 2.0 online", header: false},
    {href: "http://www.harveycartel.org/", alt: "", title: "M&R&co project, hosts N v1.4 highscores", text: "Harvey Cartel", header: false}
  ],
  col2 = [
    {href: "", alt: "", title: "", text: "TOOLS", header: true},
    {href: "", alt: "", title: "", text: "Highscoring", header: true},
    {href: "files/tools/NHighEddy_r2.rar", alt: "", title: "NHigh (2015, by jg9000, last update by Eddy)", text: "NHigh (2015)", header: false},
    {href: "files/tools/N2High_v3.0.rar", alt: "", title: "N2High 3.0 (2013, by Eddy)", text: "N2High (2013)", header: false},
  ],
  col3 = [
    {href: "", alt: "", title: "", text: "DOCUMENTS", header: true},
    {href: "", alt: "", title: "", text: "Spreadsheets", header: true},
    {href: "files/spreadsheets/highscore_history_2012_07_29.xlsx", alt: "", title: "", text: "The HighScore Rankings Master List (2012, Seifer and Raif)", header: false},
    {href: "files/spreadsheets/N_Demo_Code_Generator.xls", alt: "", title: "", text: "N Demo Code Generator (2010, by Raif)", header: false},
    {href: "files/spreadsheets/nmbd.xlsm", alt: "", title: "", text: "N Demo Code Generator (2016, by jp27ace)", header: false},
    {href: "files/spreadsheets/NRSS.xlsm", alt: "", title: "", text: "NReality Score comparer (2010, by Pai_Mei)", header: false},
    {href: "files/spreadsheets/N_Highscores_2014_03.xlsx", alt: "", title: "", text: "N 0ths (2014, by TRO and Raif)", header: false},
    {href: "files/spreadsheets/Deaths.xls", alt: "", title: "", text: "N death calculator (2010, by Eddy)", header: false},
    {href: "files/spreadsheets/Demo_data_codes.xls", alt: "", title: "", text: "Summary of N demo data codes (2009, by Raif)", header: false},
    {href: "files/spreadsheets/EpisodeCalculator.xls", alt: "", title: "", text: "Episode Calculator (2007, by 29403)", header: false},
  ]
]

def to_html()
  max = $table.map{ |col| col.size }.max
  $table.each{ |col| col.push({href: "", alt: "", title: "", text: "", header: false}) while col.size < max }
  html = "<table>\n"
  (0..max - 1).each{ |row|
    html << "<tr>\n"
    (0..$table.size - 1).each{ |col|
      e = $table[col][row]
      if e[:header] == true
        html << "<th>" + e[:text] + "</th>"
      else
        html << "<td><a href=\"" + e[:href] + "\" alt=\"" + e[:alt] + "\" title=\"" + e[:title] + "\">" + e[:text] + "</a></td>"
      end
    }
    html << "</tr>\n"
  }
  html << "</table>"
  File.open("table#{Time.now}", "w") do |f|
    f.write(html)
  end
end

to_html()
