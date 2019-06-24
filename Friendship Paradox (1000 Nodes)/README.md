# Friendship Paradox: 1000 Nodes

I basically create a simple data structure with 1000 nodes using a matrix. I then populate the matrix with 1s and 0s, and two nodes (a row and a col in a matrix)
have a 5% chance of having a connection. Launch report.html for more information.

## Further Reading

iGraph in R can be used to generate the adjaceny matrix for more functionality and easier computing.

The 0.05 probability of success will determine the number of connections at each node, and this is representative of a binomial distribution P(k).

The binomial distribution can also be modeled by Poisson's Distribution, where lambda = Np.

The friends of friends dataset is representative of kP(k).
