library(rvest)
library(xml2)
library(XML)
library(stringr)
library(readr)

Distance_Data <- read_csv("Distance_Data.csv")
View(Distance_Data)

Place <- readline(prompt = "Enter Place to Calculate Distance: ")
Place <- str_replace_all(Place, " ", "+")

for(i in 1:nrow(Distance_Data)){
  print(sprintf("Finding distance for %s, %s", Distance_Data$County[i], Distance_Data$State.x[i]))
  County <- str_replace_all(Distance_Data$County[i], " ", "+")
  State <- str_replace_all(Distance_Data$State[i], " ", "+")
  Name <- paste(County, State, sep = "+")
  url <- paste0("https://www.google.com/search?sxsrf=ALeKk02i5MELHSj-G_ci2fbl7_8vNqXNtg%3A1592750450884&ei=cnHvXoPTNeaAhbIPrd6ImAk&q=how+far+is+",Name,"+from+",Place,"&oq=how+far+is+",Name,"+from+",Place,"&gs_lcp=CgZwc3ktYWIQAzoECAAQR1D9c1iuhwFg8YkBaABwAngAgAFIiAH2A5IBATmYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwiD1NzmkZPqAhVmQEEAHS0vApMQ4dUDCAw&uact=5")
  html <- read_html(url)
  node <- xml_child(xml_child(xml_child(xml_child(xml_child(html, 2), 2), 4), 1), 2)
  distance <- xml_child(node, 1) %>% html_text()
  print(distance)
  distance <- str_remove(distance, "km")
  distance <- str_remove(distance, ",")
  distance <- as.numeric(distance)
  Distance_Data$`Distance (km)`[i] <- distance
  print("Sleeping")
  Sys.sleep(5)
}

print("Done!")
