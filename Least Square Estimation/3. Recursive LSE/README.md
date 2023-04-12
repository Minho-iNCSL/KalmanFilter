# Recursive Least Square Estimation

Previous Equation (Constant, Weighted) gives us a way to compute the optimal estimate of a constantm, but there is a problem.

**If we obtain measurements sequentially and want to update our estimate of $x$ wtih each new measurement...**

We need to augment the %H$ Matrix and completely recompute the estimate $\hat{x}$.

If the number of measurements becomes large, then the computational effort could become prohibitive... 

---

In this example, we show how to **recursively** compute the "weighted least squares estimate of a constant".

That is, suppose we have $\hat{x}$ after ($k-1$) measurements, and we obtain a new measurement $y_k$. 

How can we update our estimate without completely rewokring Equation $\hat{x} = (H^TR^{-1}H)^{-1}H^TR^{-1}y$ ???

### A Linear Recursive estimator can be written in the form

$$ y_k = H_kx + v_k \qquad \qquad \qquad \qquad \quad$$

$$ \hat{x}\_k = \hat{x}\_{k-1} + K_k(y_k - H_k \hat{x}\_{k-1}) ... (1)$$

$$ (K_k : estimator \ gain \ matrix, \quad (y_k-H_k\hat{x}\_{k-1}) : correction \ term) $$

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

(즉, 측정치 잡음의 모든 $k$에 대해 평균이 0이고, $x$의 초기 추정치가 $x$의 기댓값과 같다면, $\hat{x}\_0 = \mathbf{E}(x)$ )

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

---

Now Let's determinate optimal value of $K_k$, But the estimator is unbiased regardless of what value of $K_k$ we use,

We must choose some other optimality criterion in order to determine $K_k$

($K_k$는 Unbiased Estimator 의 특성으로 인해 크게 중요하지 않다. 따라서 $K_k$를 결정하는 것 대신, 어떤 최적의 기준을 설정해야한다.)

The optimality criterion that we choose to minimize is the ★**Sum of the variances of the estimation errors at time k**

(즉, 최적의 기준인 Cost Function을 $k$ 스텝에서 추정치 오차의 분산으로 설정한다. - 나중에 또 나올 개념으로 중요 !)

$$ \mathbf{J}\_k = \mathbf{E}[(x_1 - \hat{x}\_1)^2] + \cdots + \mathbf{E}[(x_n - \hat{x}\_n)^2] $$

$$ = \mathbf{E}(\epsilon_{x_1,k}^2 + \cdots + \epsilon_{x_n,k}^2) \qquad \qquad \quad $$

$$ = \mathbf{E}(\epsilon_{x,k}^T \epsilon_{x,k}) \qquad \qquad \qquad \qquad \quad \ $$

$$ = \mathbf{E}[\mathbf{Tr}(\epsilon_{x,k} \epsilon_{x,k}^T)] \qquad \qquad \qquad \quad \ \$$

$$ = \mathbf{Tr} P_k \qquad \qquad \qquad \qquad \qquad \quad $$

**$P_k$ is the estimation-error covariance** and obtain a recursive formula for the calculation of $P_k$.

$$ P_k = \mathbf{E}(\epsilon_{x,k} \epsilon_{x,k}^T) \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \quad $$ 

$$ = \mathbf{E}{[(I-K_kH_k)\epsilon_{x,k-1} - K_kv_k][\cdots]^T} \qquad \qquad \qquad \qquad \qquad \qquad \quad \ \ $$

$$ \qquad \ \ \= (I-K_kH_K)\mathbf{E}(\epsilon_{x,k-1}\epsilon_{x,k-1}^T)(I-K_kH_k)^T - K_k\mathbf{E}(v_k\epsilon_{x,k-1}^T)(I-K_kH_K)^T $$

$$ - (I-K_kH_k)\mathbf{E}(\epsilon_{x,k-1}v_k^T)K_k^T + K_k\mathbf{E}(v_kv_k^T)K_k^T \qquad \qquad \qquad \quad  \$$

($\epsilon_{x,k-1}$ is the estimation error at time ($k-1$), and independent of $v_k$)

$$ \mathbf{E}(v_k\epsilon_{x,k-1}^T) = \mathbf{E}(v_k)\mathbf{E}(\epsilon_{x,k-1})$$ 

$$ = 0 \ \ \$$

(상호 독립인 두 확률변수간에 기대값을 따로 계산할 수 있으며, $v_k$ 의 기대값은 0이다.)

Therefore, Equation becomes

$$ P_k = (I-K_kH_k)P_{k-1}(I-K_kH_k)^T + K_kR_kK_k^T $$

$$ ( R_k : covariance \ of \ v_k) $$

This is the recursive formula for the covariance of the least squares estimation error.

(위의 수식은, 추정 오차에 대한 Least square의 공분산에 대한 재귀 공식이다.)

This is consistent with intuition in the sense that measurement noise increases..  ($R_k$ increases) the uncertainty in our estimate also increases ($P_k$ increases)

(즉, 측정치 오차가 증가하면 추정치에 대한 불확실성도 커지므로 일관성이 있다.)

---

Now, we need to find the value of $K_k$ that makes the cost function as small as possible.

The mean of the estimation error is zero for any value of $K_k$. So if we choose $K_k$ to make the cost function small then the estimation error will not only be zeros-mean, but it will also be consistently close to zero.

($K_k$가 어떤 값이던 간에 추정치 오차의 평균은 0 이다. 따라서 우리는 cost function $\mathbf{J}$을 ($k$ step 에서의 추정치 오차 분산) 가능한 작게하는 $K_k$를 고르게 될 경우, 추정치 오차는 평균이 0이 될 뿐만 아니라, 지속적으로 0에 접근할 것이다. )

using Equation ${\partial{\mathbf{Tr}(ABA^T)} \over \partial{A}} = 2AB$ (if $B$ is symmetric). 

$${\partial{\mathbf{J}\_k} \over \partial{K}\_k} = {\partial{\mathbf{Tr}(P_k)} \over \partial{K}\_k} = 2(I-K_kH_k)P_{k-1}(-H_k^T) + 2K_kR_k $$

In order to find the value of $K_k$ that minimizes $\mathbf{J}\_k$, we set the above derivative equal to zero and solve for $K_k$.

$$ K_kR_k = (I-K_kH_k)P_{k-1}H_k^T $$

$$ K_k(R_k + H_kP_{k-1}H_k^T) = P_{k-1}H_k^T $$

$$ K_k = P_{k-1}H_k^T(H_kP_{k-1}H_k^T + R_k)^{-1} $$

---

## Summary 

**1. Initialize the estimator**

$$ \hat{x}\_0 = \mathbf{E}(x) \qquad \qquad \qquad \quad$$

$$ P_0 = \mathbf{E}[(x-\hat{x}\_0)(x-\hat{x}\_0)^T] $$

$\qquad$ If we don't know about available $x$ before measurements are taken, then $P_0 = \infty I$,

$\qquad$ If perfectly know about available $x$ before measurement are taken, then $P_0 = 0$. 

**2. For $k = 1, 2, ...,$ perform the following**

$\qquad$ (a) Obtain the measurement $y_k$, assuming that $y_k$ is give by the equation

$$ y_k = H_kx + v_k $$

$\qquad$ Where $v_k$ is a zero-mean random vector with covariance $R_k$. (Measurement Noise is white = random noise)

$\qquad$ (b) Update the estimate of $x$ and the estimation-error covariance $P$ as follows

$$ K_k = P_{k-1}H_k^T(H_kP_{k-1}H_k^T + R_k)^{-1}$$

$$ \hat{x}\_k = \hat{x}\_{k-1} + K_k(y_k - H_k\hat{x}\_{k-1}) \quad \ \$$

$$ \qquad \qquad \qquad P_k = (I-K_kH_k)P_{k-1}(I-K_kH_k)^T + K_kR_kK_k^T $$

---

It's Done. Let's understand through an example

