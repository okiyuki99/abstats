library(ggplot2)
library(ggbeeswarm)
library(ggthemes)
library(hexSticker)

lv <- 4
sample_size <- 25
effect <- 2
C <- c(rnorm(sample_size, 10, 1), rnorm(sample_size, 11, 1), rnorm(sample_size, 12, 1), rnorm(sample_size, 13, 1))
T1 <- c(rnorm(sample_size, 10 + 2, 1), rnorm(sample_size, 11 + 2, 1), rnorm(sample_size, 12 + 2, 1), rnorm(sample_size, 13 + 2, 1))

colors_C <- tableau_gradient_pal("Blue")(seq(0.2, 0.8, length = lv))
colors_T1 <- tableau_gradient_pal("Orange")(seq(0.2, 0.8, length = lv))
colors <- c(colors_C, colors_T1)

data.frame(
  variant = c(rep('C',sample_size * lv),rep('T',sample_size * lv)),
  user_level = c(sort(rep(paste0('C', seq(lv)), sample_size)),sort(rep(paste0('T', seq(lv)), sample_size))),
  value = c(C, T1)
) %>%
  ggplot(aes(x = variant, y = value, group = variant, color = user_level)) +
  geom_quasirandom(alpha = 0.5) +
  geom_line(data = data.frame(variant = c('C','T'), value = c(mean(C),mean(T1))), aes(x = variant, y = value, group = 1), color = "#111111", linetype = "dotted") +
  geom_point(data = data.frame(variant = c('C','T'), value = c(mean(C),mean(T1))), aes(x = variant, y = value, group = 1), color = "#111111", shape = 1, size = 1) +
  scale_color_manual(values =  colors) +
  scale_y_continuous(breaks = seq(0, 20, by=1)) +
  theme_void() +
  theme_transparent() +
  guides(color = FALSE) -> g

sticker(g,
        package = "abstats", p_size=20, s_x=1, s_y=.75, s_width=1.3, s_height=1,
        h_fill = "#404b69", h_color = "#283149",
        filename = "man/figures/logo.png")

