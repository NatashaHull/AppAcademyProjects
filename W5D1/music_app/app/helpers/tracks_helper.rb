module TracksHelper
  def show_lyrics(lyrics)
    m_lyrics = lyrics.gsub("\r\n", "\r\n♫ ")
    html = "<pre>"
    html += "&#9835; "
    html += h(m_lyrics)
    html += "</pre>"
    html.html_safe
  end
end
