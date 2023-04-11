# Least Square Estimation

**How to estimate a constant on the basis of several noisy measurements of that constant ?**

Suppose we have a constant data and we do not know it's real value. (e.g. measurement of voltage, current, resistance ...) Cancel changes

We take several measurement using device that can measure desire data. but device is cheap and measurements are very noisy.

In this case, we want to estimate a constant scalar. (In general, we estimate a constant 'vector', not scalar)

---

To put the problem in mathematical terms, suppose $x$ is a constant, but unknown n-element vector, and $y$ is a k-element noisy measurement vector

$$x = [1,2,3,4,5 .. ,n]$$

Then, How can we find the 'best' estimate $\hat{x}$ of $x$ ? ( $\hat{x}$ means value that estimated from $y$ )
Let us assume that each element of the measurement vector $y$ is a linear combination of the elements of $x$, with the addition of some measurement noise like below

$$ y_1 = H_{11} x_1 + ... + H_{1n} x_n + v_1 $$

$$ y_2 = H_{21} x_1 + ... + H_{2n} x_n + v_2 $$

$$ ... $$

$$ y_k = H_{k1} x_1 + ... + H_{kn} x_n + v_k $$

This set of equation can be put into matrix form as

$$ y = Hx + v $$

Now, define some value that called **'error' or 'measurement residual'**, difference between the noisy measurements and the vector 

( $y$ is the raw measurement of sensor, and $H\hat{x}$ is estimation value. make a rough(대충) estimation can be $\hat{x}$ )

( e.g. "DMM shows 12V [ $y$ ], But I Think that circuit voltage might be 11.7 V [ $\hat{x}$ ], but other guys maybe estimate different value )

$$ \epsilon_y = y - H \hat{x} $$

**The most probable value of the vector $x$ is the vector $\hat{x}$ that minimizes the sum of squares of 'measurement residual'**

So we will define 'Cost Function' **$\mathbf{J}$**  that means sum of squares of 'measurement residual' 

$$ \mathbf{J} = \epsilon_{y1}^2 + ... + \epsilon_{yk}^2 $$

$$ = \epsilon_{y}^T \epsilon_{y} $$ 

( $y$ is column vector, so square in vector is multiply to transpose form )
 
**$\mathbf{J}$** is often referred to cost-function, objective-funtion or return-function. We can rewrite **$\mathbf{J}$**

$$ \mathbf{J} = (y-H\hat{x})^T(y-H\hat{x}) $$

$$ = y^Ty - \hat{x}^TH^Ty - y^TH\hat{x}^T + \hat{x}^TH^TH\hat{x} <br/><br/> $$

And minimize **$\mathbf{J}$** with respect to \hat{x}, we compute its partial derivative and set it equal to zero.

$$ {\partial{\mathbf{J}} \over \partial{\hat{x}}} = -y^TH - y^TH + 2\hat{x}^TH^TH $$

$$ = 0 $$

Solving this equation for \hat{x} results in

$$ H^Ty = H^TH\hat{x} $$

$$ \hat{x} = (H^TH)^-1H^Ty $$

( This is only exists if $k \ge n$ and H is full rank. This means that number of measurement $k$ is greater than the number of variables $n$ )

( 쉽게말해서, 우리가 추정하고자 하는 변수의 개수보다 측정치의 개수가 더 많아야지 위의 수식이 성립한다 -- 역함수가 존재하기 위한 조건을 떠올리자! )

---

Let's start implement of the Least square Estimation of Constant 
