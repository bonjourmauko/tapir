EPUB_OPF_TEMPLATE =
'%package{:xmlns => "http://www.idpf.org/2007/opf", :version => "2.0", "unique-identifier" => "bookid"}
  %metadata{"xmlns:dc" => "http://purl.org/dc/elements/1.1/", "xmlns:opf" => "http://www.idpf.org/2007/opf"}
    %dc:title
      #{title}
    %dc:creator
      BOOK AUTHOR
    %dc:language
      en-US
    %dc:identifier{"opf:scheme" => "Pictorical", :id => "bookid"}
      UNIQUE ID
  %manifest
    %item{:id => "ncx", :href => "toc.ncx", "media-type" => "application/x-dtbncx+xml"}/
    %item{:id => "copyright-page", :href => "content/00copyright.html", "media-type" => "application/xhtml+xml"}/
    %item{:id => "illustration1", :href => "illustration1", "media-type" => "image/png"}/
    %item{:id => "style-illustrations", :href => "content/styles/artwork.css", "media-type" => "text/css"}/
  %spine{:toc => "ncx"}
    %itemref{:idref => "copyright-page"}/
    %itemref{:idref => "title-page"}/
    %itemref{:idref => "artist-page"}/
    %itemref{:idref => "story"}/
  %guide
    %reference{:type => "copyright-page", :href => "content/00copyright.html" }/
    %reference{:type => "text", :href => "content/01title.html" }/'
    
EPUB_NCX_TEMPLATE =
'%ncx{:xmlns => "http://www.daisy.org/z3986/2005/ncx/", :version => "2005-1"}
  %head
    %meta{:name => "dtb:uid", :content => "THE UNIQUE ID"}/
    %meta{:name => "dtb:depth", :content => "1"}/
    %meta{:name => "dtb:totalPageCount", :content => "0"}/
    %meta{:name => "dtb:maxPageNumber", :content => "0"}/
  %docTitle
    %text
      THE TITLE OF THE BOOK
  %navMap
    %navPoint{:id => "nav-copyright", :playOrder => "1"}
      %navLabel
        %text
          THE TITLE OF THE CHAPTER
      %content{:src => "content/00copyright.html" }/'

EPUB_XHTML_TEMPLATE =
'!!! xml
!!! 1.1
%html{:xmlns => "http://www.w3.org/1999/xhtml"}
  %head
    %meta{"http-equiv" => "Content-Type", :content => "text/html; charset=utf-8"}/
    %title
      BOOK CHAPTER
  %body
    #{body}'
    
EPUB_CSS_STYLE=
'.bold {font-weight: bold;}
.italic {font-style: italic;}
.underline {text-decoration: underline;}
.line-through {text-decoration: line-through;}
.sub {vertical-align: sub;}
.super {vertical-align: super;}
p.left {text-align: left;}
p.right {text-align: right;}
p.center {text-align: center;}
p.justify {text-align: justify;}'