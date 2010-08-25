-- Plain string.find (no metacharacters)
function sstrfind(s, pattern)
   return string.find(s, pattern, 1, true)
end

function pre_format_html_hook (url, html)
   if sstrfind (url, "blonnet.com") or sstrfind(url, "thehindubusinessline.com") then
      html = string.gsub(html, "<[Ff][Oo][Nn][Tt] class=leftnavi color=brown>.-</[Ff][Oo][Nn][Tt]>", '')
      html = string.gsub(html, "<TD align=left vAlign=top width=\"500\"><IMG.-</FONT><BR>", '', 1)
      html = string.gsub(html, "<A class=groupnavi href=\"http://epaper.thehindubusinessline.com/\">.-</FONT><BR>", '', 1)
      html = string.gsub(html, "<[Aa]", "<a")
      html = string.gsub(html, "(<[Aa] class=navi.-)<li>(.-</[Aa]>)", "<li>%1%2</li>") --<a class=\"navi\" href=\"%0\">%1%2</a></li>")
--      html = string.gsub(html, "<A class=navi href=\"([^\"]+)\"><font color=white><li>([^<]+)</font></A>", "<li><a class=\"navi\" href=\"%0\"><font color=\"white\">%1</font></li>", 1)
      return html
   end
   if sstrfind (url, "bugs.debian.org") then
      html = string.gsub(html, "/css/bugs.css", 'file:///home/kumar/Kumar/bugs.css')
      return html
   end
   if sstrfind (url, "mobile.twitter.com") then
      html = string.gsub(html, ".status.-}", '.status {word-wrap: break-word; color : #000;}')
      return html
   end
   return nil
end
