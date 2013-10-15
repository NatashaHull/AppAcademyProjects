module TracksHelper
  def show_lyrics(lyrics)
    m_lyrics = h(lyrics).gsub("\r\n", "\r\n&#9835; ")
    html = "<pre>"
    html += "&#9835; "
    html += m_lyrics
    html += "</pre>"
    html.html_safe
  end
end
