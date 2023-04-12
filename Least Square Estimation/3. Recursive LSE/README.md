# Recursive Least Square Estimation

Previous Equation (Constant, Weighted) gives us a way to compute the optimal estimate of a constantm, but there is a problem.

**If we obtain measurements sequentially and want to update our estimate of $x$ wtih each new measurement... **

We need to augment the %H$ Matrix and completely recompute the estimate $\hat{x}$.

If the number of measurements becomes large, then the computational effort could become prohibitive... 

---

In this example, we show how to **recursively** compute the "weighted least squares estimate of a constant".

That is, suppose we have $\hat{x}$ after ($k-1$) measurements, and we obtain a new measurement $y_k$. 

How can we update our estimate without completely rewokring Equation $\hat{x} = (H^TR^{-1}H)^{-1}H^TR^{-1}y$ ???

### A Linear Recursive estimator can be written in the form {: .text-center}

$$ y_k = H_kx + v_k \qquad \qquad \qquad \ \$$

$$ \hat{x}\_k = \hat{x}\_{k-1} + K_k(y_k - H_k \hat{x}\_{k-1}) ... (1)$$

$$ (K_k : estimator gain matrix, \quad (y_k-H_k\hat{x}_{k-1}) : correction term) $$

That is, we compute $\hat{x}\_k$ on the basis of the previous estimate $\hat{x}\_{k-1}$ and the new measurement $y_k$

(즉, 현 스텝의 추정치를, 이전스텝의 추정치 그리고 현 스텝의 측정치를 사용하여 계산한다.)

If correction term is zero, or if the gain matrix is zero. then the estimate does not change from time step ($k-1$) to $k$.

---

Before we compute the optimal gain matrix $K_k$, let us think about the mean of the estimation error of the linear recursive estimator.

The estimation error mean can be computed as..

$$ \mathbf{E}(\epsilon_{x,k}) = \mathbf{E}(x-\hat{x}\_k) \qquad \qquad \qquad$$

$$ \qquad \qquad \qquad = \mathbf{E}[x-\hat{x}\_{k-1} - K_k(y_k - H_k\hat{x}\_{k-1})] $$

$$ \qquad \qquad \qquad \qquad= \mathbf{E}[\epsilon_{x,k-1} - K_k(H_kx + v_k - H_k\hat{x}\_{k-1})] $$

$$ \qquad \qquad \qquad \qquad= \mathbf{E}[\epsilon_{x,k-1} - K_kH_k(x-\hat{x}\_{k-1}) - K_kv_k] $$

$$ \qquad \qquad \qquad \ \= (I-K_kH_k)\mathbf{E}(\epsilon_{x,k-1}) - K_k\mathbf{E}(v_k) $$

So, if $\mathbf{E}(v_k) = 0$ and $\mathbf{E}(\epsilon_{x,k-1}) = 0$ then $\mathbf{E}(\epsilon_{x,k}) = 0$.

In other words, the measurement noise $v_k$ is zero-mean for all k, and the initial estimate of $x$ is set equal to the expected value of $x$ .. 

Then expected value of $\hat{x}\_k$ will be equal to $x_k$ for all $k$.

(즉, 측정치 잡음의 모든 $k$에 대해 평균이 0이고, $x$의 초기 추정치가 $x$의 기댓값과 같다면, $\hat{x}\_0 = \mathbf{E}(x)$)

($k$ step 에서의 추정치는, 모든 $k$ 에 대해 $x_k$와 같아진다.)

#### For Understanding above sentence, Let's follow this step..

$\quad$**\*step $k$ = 1 ...**

$\quad \mathbf{E}(v_1) = 0$ and $\mathbf{E}(\epsilon_{x,0}) = \mathbf{E}(x - \hat{x}\_0) = 0$, in other words $\hat{x}\_0 = \mathbf{E}(x)$

$\quad \mathbf{E}(\epsilon_{x,1}) = 0$

$\quad$**\*step $k$ = 2 ...**

$\quad \mathbf{E}(v_2) = 0$ and $\mathbf{E}(\epsilon_{x,1}) = 0$ defined before $k=1$ step.

$\quad \mathbf{E}(\epsilon_{x,2}) = 0$

$\quad \vdots$

$\quad$**\*step $k$ = k ...**

$\quad \mathbf{E}(v_k) = 0$ and $\mathbf{E}(\epsilon_{x,k-1}) = 0$ defined before $k=k-1$ step.

$\quad \mathbf{E}(\epsilon_{x,k}) = 0$

From this, estimation error of mean is zero for all $k$ step. Thus, $\hat{x}\_k = x_k$ for all $k$.

Note that, this property holds regardless of the value of the gain matrix $K_k$.

This is a desirable property of an estimator because it says that, "on average", the estimate $\hat{x}$ will be eqaul to the true value $x$.

Because of this, (1) is called **unbiased estimator**.
