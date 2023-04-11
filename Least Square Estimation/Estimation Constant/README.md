# Least Square Estimation

**How to estimate a constant on the basis of several noisy measurements of that constant ?**
Suppose we have a constant data and we do not know it's real value. (e.g. measurement of voltage, current, resistance ...) Cancel changes
We take several measurement using device that can measure desire data. but device is cheap and measurements are very noisy.
In this case, we want to estimate a constant scalar. (In general, we estimate a constant 'vector', not scalar)

To put the problem in mathematical terms, suppose $x$ is a constant, but unknown n-element vector, and $y$ is a k-element noisy measurement vector

$$x = [ 1 ,2,3,4, 5 .. ,n]$$

$$y = Hx + v $$

Then, How can we find the 'best' estimate $\hat{x}$ of $x$ ? ( $\hat{x}$ means value that estimated from $y$ )
Let us assume that each element of the measurement vector $y$ is a linear combination of the elements of $x$, with the addition of some measurement noise like below

$$ y_1 = H_{11} x_1 + ... + H_{1n} x_n + v_1 $$

$$ y_2 = H_{21} x_1 + ... + H_{2n} x_n + v_2 $$

$$ ... $$

$$ y_k = H_{k1} x_1 + ... + H_{kn} x_n + v_k $$
