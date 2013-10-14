module TracksHelper
  def show_lyrics(lyrics)
    lines = lyrics.split(/\r\n/)
    html = ""
    lines.each do |line|
      html += "<p>"
      html += h(line)
      html += "</p>"
    end
    html.html_safe
  end
end
