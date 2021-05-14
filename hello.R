library(tidyverse)

diamonds %>% 
  ggplot(mapping = aes(x = carat, y = price, colour = clarity)) + 
  geom_point() +
  theme_classic() +
  theme(legend.position = 'bottom') +
  ggtitle('Diamonds are forever')
