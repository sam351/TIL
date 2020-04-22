# html 소스 불러오기
url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)


# <h1> 태그의 컨텐츠
nodes_h1 <- html_nodes(text, "h1")
html_text(nodes_h1)

# 텍스트 형식으로 내용을 가지고 있는 <a> 태그의 컨텐츠와 href 속성값
nodes_a <- html_nodes(text, "a")
for (node in nodes_a) {
  cat( html_text(node), ">>>", html_attr(node, "href"), "\n" )
}

# <img> 태그의 src 속성값
nodes_img <- html_nodes(text, "img")
html_attr(nodes_img, "src")

# 첫 번째 <h2> 태그의 컨텐츠
nodes_h2 <- html_nodes(text, "h2:nth-of-type(1)")
html_text(nodes_h2)

# <ul> 태그의 자식 태그들 중 style 속성의 값이 green으로 끝나는 태그의 컨텐츠
nodes_ul_green <- html_nodes(text, "ul > [style$=green]")
html_text(nodes_ul_green)

# 두 번째 <h2> 태그의 컨텐츠
nodes_h2 <- html_nodes(text, "h2:nth-of-type(2)")
html_text(nodes_h2)

# <ul> 태그의 모든 자식 태그들의 컨텐츠 
nodes_ul_children <- html_nodes(text, "ul > *")
html_text(nodes_ul_children)

# <table> 태그의 모든 자손 태그들의 컨텐츠
nodes_table_desc <- html_nodes(text, "table *")
html_text(nodes_table_desc)

# name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠
nodes_tr <- html_nodes( text, "tr.name" )  # html_nodes(text, "tr[class=name]")
html_text(nodes_tr)

# target이라는 아이디 속성을 갖는 <td> 태그의 컨텐츠
nodes_td <- html_nodes(text, "td[id=target]")  # html_nodes(text, "td#target") 또는 html_nodes(text, "#target")
html_text(nodes_td)
