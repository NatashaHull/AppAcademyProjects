module TracksHelper
  def show_lyrics(lyrics)
    m_lyrics = h(lyrics).split("\r\n")
    html = "<ul id=\"lyrics\">"
    m_lyrics.each do |lyric|
      html += "<li> "
      html += lyric
      html += "</li>"
    end
    html += "</ul>"
    html.html_safe
  end
end
