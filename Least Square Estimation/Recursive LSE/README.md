# Recursive Least Square Estimation

Previous Equation (Constant, Weighted) gives us a way to compute the optimal estimate of a constantm, but there is a problem.

**If we obtain measurements sequentially and want to update our estimate of $x$ wtih each new measurement... **

We need to augment the %H$ Matrix and completely recompute the estimate $\hat{x}$.

If the number of measurements becomes large, then the computational effort could become prohibitive... 

---

In this example, we show how to **recursively** compute the "weighted least squares estimate of a constant".
