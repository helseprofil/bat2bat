## install.packages("hexSticker")
remotes::install_github("GuangchuangYu/hexSticker")

library("hexSticker")

imgFolder <- "/home/ybk/Git-fhi/bat2bat/dev"
img <- file.path(imgFolder, "bat2bat.png")
sticker(img, package = "", s_x = .95, s_width = .55,
        h_color = "#000080", #border
        h_fill = "#ffe0bd",
        filename = file.path(imgFolder, "logo2.png"))
