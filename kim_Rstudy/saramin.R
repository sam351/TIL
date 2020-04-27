url <- "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=DATA%20SCIENTIST"

html_doc <- read_html(url)

nodes <- html_nodes(html_doc, xpath = '//label[@class="lbl_sfilter"]/span[@class="txt"]')
tech_name <- html_text(nodes)
tech_name <- gsub("#","",tech_name)

nodes <- html_nodes(html_doc, xpath = '//label/span[@class="count"]')
info_count<- html_text(nodes)
info_count <- gsub("[()]","",info_count)
info_count <- as.numeric(info_count)

result_df <- data.frame(tech_name, info_count)

write.csv(result_df, "saramin.csv")
