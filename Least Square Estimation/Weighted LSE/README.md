# Weighted Least square estimation

We assumed that we had an eqaul amount of confidence in all of our measurement.
Now suppose we have more confidence in some measurements than others.

In this case, some measurements were taken with an expensive device (more accuracy) with low noise, but other measurements were taken with a cheap device. 

Obviously, we have more confidence in the first set of measurements (expensive device). However, even though the second set of measurements (cheap device) is less reliable, it seems that we could get least some information from them.

In Weighted LSE, we can indeed get sonme information from less reliable measurements. 

**We should never throw away measurements, no matter how unreliable they may be**

---

To put the problem im mathematical terms, suppose $\hat{x}$ is a constant but unknown $n$-element vector and $y$ is a $k$-element noisy measurement vector.

the variance of the measurement noise may be different for each element of $y$

$$\begin{bmatrix} 
y_1 \\ 
\vdots \\ 
y_k 
\end{bmatrix} = 
\begin{bmatrix} 
H_{11} & \cdots & H_{1n} \\ 
\vdots & \ddots & vdots \\ 
H_{k1} & \cdots & H_{kn} 
\end{bmatrix} 
\begin{bmatrix} 
x_1 \\ 
\vdots \\ 
x_n 
\end{bmatrix} +
\begin{bmatrix} 
v_1 \\ 
\vdots \\ 
v_k 
\end{bmatrix}
$$

$$ \mathbf{E}(v_i^2) = \sigma_i^2 \quad (i=1,...,k) $$

We assume that the noise for each measurement is **zero-mean** and independent. The measurement covariance matrix is

$$ R = \mathbf{E}(vv^T) $$

$$ \begin{bmatrix} 
\sigma_{1}^2 & \cdots & 0 \\ 
\vdots &  & \vdots \\ 
0 & \cdots & \sigma_{k}^2
\end{bmatrix} 
$$
