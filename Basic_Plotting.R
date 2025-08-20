path_to_data = "C:/Users/Chels/Documents/Climate/Community-Solar-Repo"
setwd(path_to_data)

library(readxl)
library(ggplot2)
library(reshape)

# read in primary data spreadsheet
df = read_excel("Community_Solar_Calculations.xlsx", sheet="Savings estimate")
df = df[-which(is.na(df$Year)),]

# subset to 2024
df.2024 = df[which(df$Year == 2024),]

# month order
months = df.2024$Month

# plot energy use by source
df.simple.2024 = df.2024[,c("Month","Community solar generation (kWh)","Energy from utility (kWh)")]
colnames(df.simple.2024) = c("Month","Community solar","Utility")
df.source.melt = melt(df.simple.2024,id.vars=c("Month"))
ggplot(df.source.melt, aes(x=factor(Month, levels=months), 
                           y=value, 
                           color=variable,
                           group=variable)) + 
       geom_point() + geom_line() + ylim(0,1200) +
       scale_color_manual(values=c("Community solar"="darkgoldenrod1",
                                   "Utility"="darkslategray")) +
       labs(x="",y="Energy use (kWh)",color="Energy type",
            title="Energy by source in 2024")
