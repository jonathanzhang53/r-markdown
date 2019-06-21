library(spatstat)

avgdiff = 0
satisfy = 0

for (i in 1:10) {
	# Generating symmetric matrix (1000x1000) with 1 as a connection index
	## Each row represents a node
	mat = matrix(runif(1000000),1000)
	for(row in 1:nrow(mat)) {
	  for(col in row:ncol(mat)) {
	      if (mat[row,col] < 0.05 && row != col){
	        mat[row,col] = 1
	        mat[col,row] = 1
	      } else {
	        mat[row,col] = 0
	        mat[col,row] = 0
	      }
	  }
	}

	# Data list of # of connections
	data1 = rowSums(mat)
	## summary(data1)

	# Randomly picking nodes and putting their # of connections in a data list
	data2 = vector(mode = "numeric", length = 1000)
	for (i in 1:1000) {
	  x = trunc(runif(1,0,1000) + 1)
	  y = sum(mat[x,])
	  data2[i] = y
	}
	## summary(data2)

	# Randomly picking a starting node and moving along a path to other nodes through connections, but not backtracking
	## Illustrates the friendship paradox
	## Each time a node is reached after the starting node, the # of connections at that node is added to the data list
	data3 = vector(mode = "numeric")
	start = trunc(runif(1,0,1000) + 1)
	list = which(mat[start,] == 1)
	back = sample(list, 1)
	for (k in 1:1000) {
	  node = back
	  list = which(mat[node,] == 1)
	  tempback = back
	  while (tempback == back) {
	    back = sample(list, 1)
	  }
	  data3 = c(data3, sum(mat[node,]))
	}
	## summary(data3)

	if (mean(data3) > max(c(mean(data1),mean(data2)))) {
		satisfy = satisfy + 1;
		avg = mean(data3) - mean(c(mean(data1),mean(data2)))
		avgdiff = avgdiff + avg 
	}
}

print(satisfy) # number of cases satisfied with friendship paradox
print(avgdiff / satisfy) # average difference between mean of (data1 and data2 means) and mean of (data3)
