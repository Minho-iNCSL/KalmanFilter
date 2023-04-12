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

$$ = \begin{bmatrix} 
\sigma_{1}^2 & \cdots & 0 \\ 
\vdots &  & \vdots \\ 
0 & \cdots & \sigma_{k}^2
\end{bmatrix} 
$$

Now, we will minimize the following quantitiy with respect to $\hat{x}$.

Note that instead of minimizing the sum of squares of the $\epsilon_y$ elements as we did in constant estimation before, 
we will minimize the **weighted sum of squares**. If $y_1$ is a relatively noisy measurement. then we do not care as much about minimizing
the difference between $y_1$ and the first element of $H\hat{x}$. because we do not have much confidence in $y_1$ in the first place.

$$ \epsilon_{yk} = y_k - H\hat{x}_k $$

$$ \mathbf{J} = \epsilon_{y1}^2 / \sigma_1^2 + \cdots + \epsilon_{yk}^2 / \sigma_k^2 $$

$$ = \epsilon_y^T R^{-1} \epsilon_y $$

$$ = (y-H\hat{x})^T R^{-1} (y-H\hat{x}) $$


$$ = y^TR^{-1}y - \hat{x}^T H^T R^{-1} y - y^T R^{-1} H \hat{x} + \hat{x}^T H^T R^{-1} H \hat{x} $$

We take the partial derivative of $\mathbf{J}$ with respect to $\hat{x}$ and set it equal to zero to compute the best estimate $\hat{x}$

$$ {\partial{\mathbf{J}} \over \partial{\hat{x}}} = -y^TR^{-1}H + \hat{x}^T H^T R^{-1} H = 0 $$

The best estimation of $\hat{x}$ is ...

$$ H^T R^{-1} y = H^T R^{-1} H \hat{x} $$

$$ \hat{x} = (H^TR^{-1}H)^{-1}H^TR^{-1}y $$

Note that this method requires that the measurement noise matrix $R$ be nonsingular. In other words, each of the measurement $y_i$ must be corrupted by
at least some noise for this method to work. (if variance is zero, $\mathbf{J} = \infty $)

(이 말은, 노이즈가 없을경우 즉 분산이 0이 되는 경우에 Cost Funtion 이 무한대로 발산하므로 이 Weigted LSE는 동작하지 않는다. )
