# Weighted Least square estimation

We assumed that we had an eqaul amount of confidence in all of our measurement.
Now suppose we have more confidence in some measurements than others.

In this case, some measurements were taken with an expensive device (more accuracy) with low noise, but other measurements were taken with a cheap device. 

Obviously, we have more confidence in the first set of measurements (expensive device). However, even though the second set of measurements (cheap device) is less reliable, it seems that we could get least some information from them.

In Weighted LSE, we can indeed get sonme information from less reliable measurements. 

**We should never throw away measurements, no matter how unreliable they may be**

---

To put the problem im mathematical terms, suppose $\hat{x}$ is a constant but unknown $n$-element vector and $y$ is a $k$-element noisy measurement vector.
