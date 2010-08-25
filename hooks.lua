-- Plain string.find (no metacharacters)
function sstrfind(s, pattern)
   return string.find(s, pattern, 1, true)
end

-- Reformat the Business Line website
function blonnet_format_html_hook (html)
   html = string.gsub(html, "<body ", '<body text="#000000"') -- I like the text in black on the white background
   html = string.gsub(html, "<[Ff][Oo][Nn][Tt] class=leftnavi color=brown>.-</[Ff][Oo][Nn][Tt]>", '') -- An ugly hack to remove the navigation bar
   html = string.gsub(html, "<TD align=left vAlign=top width=\"500\"><IMG.-</FONT><BR>", '', 1) -- Remove description
   html = string.gsub(html, "<A class=groupnavi href=\"http://epaper.thehindubusinessline.com/\">.-</FONT><BR>", '', 1) -- Remove other group links
   html = string.gsub(html, "(<[Aa] class=navi.-)<li>(.-</[Aa]>)", "<li>%1%2</li>") -- Fix the erroneous section sidebar
   return html
end

-- Use an alternate CSS for the Debian BTS to work around some quirks
function debian_bts_format_html_hook (html)
   return string.gsub(html, "/css/bugs.css", 'file:///home/kumar/Kumar/bugs.css')
end

-- Make the status messages black on Mobile Twitter
function mobile_twitter_format_hook(html)
   return string.gsub(html, ".status.-}", '.status {word-wrap: break-word; color : #000;}')
end

function pre_format_html_hook (url, html)
   if sstrfind (url, "blonnet.com") or sstrfind(url, "thehindubusinessline.com") then
      return blonnet_format_html_hook(html)
   elseif sstrfind (url, "bugs.debian.org") then
      return debian_bts_format_html_hook(html)
   elseif sstrfind (url, "mobile.twitter.com") then
      return mobile_twitter_format_hook(html)
   end
   return nil
end
