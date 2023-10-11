library("BBmisc")
library("dplyr")
library("tidyr")

partition_biopsies <- function (data, ngroups) {
  df_long <- data %>% 
    cbind(data.frame(id = 1:nrow(data))) %>%
    pivot_longer(!(id),names_to="biopsy",values_to = "weights" ) %>%
    tidyr::drop_na() %>%
    select(weights, biopsy,id) %>%
    arrange(biopsy, id)
  
  grouplimit <- ngroups
  groupsize <- ceiling(sum(df_long$weights)/grouplimit) # calculate the minimum possible bin size (244)
  groups <- binPack(df_long$weights, groupsize) # pack the bins
  
  if(max(groups) != grouplimit){
    for(i in 1:100){
      groups <- binPack(df_long$weights, groupsize+i) # pack the bins
      if(max(groups) == grouplimit){
        break
      }
    }
  }
  
  res_data <- cbind.data.frame(df_long, group =groups)
  return(res_data)
}

