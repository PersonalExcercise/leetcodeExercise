# problem 202. Happy Number

[题目链接](https://leetcode.com/problems/happy-number/)

## 方法

题目关于快乐数的判断已经非常的清楚了——一个整数，每位平方求和作为下一个迭代数，直到数字变为1，或者进入到一个不含1的循环中。如果变为1，那么这个数就是快乐数，否则就不是。

题目的关键就是判重。很直观的思路就是用HashSet，没什么说的，因为用的是STL。

看DISCUSS，竟然用了与*链表判断是否有环*一样的思路——`Floyd Cycle Detection(弗洛伊德判圈定理)`,从维基百科的[介绍](https://en.wikipedia.org/wiki/Cycle_detection)介绍中，可知通过此判断定理，可以判断是否存在循环，并可求出第一个进入循环的位置、循环圈的大小。

大致如下： 循环必然满足：`x_i = x_{i + \lambda k}` , 其中i就是第一次进入循环的位置，k是整数，而`\lambda`是圈的大小。

我们可以设置两个指针，一个快，一个慢，如果有圈，那么这两个指针必然相交（设经过T步，二者的差变为圈的整数倍，则相交。应该可以意会。这个就是周期运动，弗洛伊德判圈也叫龟兔赛跑算法，只要是一个圈圈，速度有差异，那么二者必然相交）。相交后，我们需要确定从哪个位置开始进入圆圈。这时需要回到`x_i = x_{i + \lambda k}`这个式子，相交时二者的距离差距就是`x_{\lambda k}`，所以我们只需从0开始迭代，直到找到i，使得`x_i = x_{i + \lambda k}`，此时i就是第一次进入圈的位置。这个似乎不是很好理解啊，在纸上写了个例子，走了下发现确实如此。最后，确定圈圈的大小。这个就很简单了。当二者相交时，必然在圈圈上。令一个指针单步移动，直到回到原点，就走了一圈。长度就是圈的大小了。

以上便是Floyd Cycle Detection算法，时间复杂度是O(\lambda + i)，即圈的大小+第一个位置的大小。此外，类似的判断还有Brent判圈法，然而我没有细看...不太明白。

## 代码

只写了Hash版本。

```C++
class Solution {
public:
    bool isHappy(int n) {
        unordered_set<int> seenSet({1});
        while(true)
        {
            int digitSquareSum = 0;
            while(n != 0)
            {
                int digit = n % 10;
                digitSquareSum += digit * digit;
                n /= 10;
            }
            if(digitSquareSum == 1){ return true;}
            else if(seenSet.count(digitSquareSum) > 0){ return false; }
            else
            {
                seenSet.insert(digitSquareSum);
                n = digitSquareSum;
            }
        }
        return false;
    }
};
```