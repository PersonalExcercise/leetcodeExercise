# problem 343. Integer Break

[题目链接](https://leetcode.com/problems/integer-break/)

## 方法

懵逼。按照提示找规律，然而也没有找到。

果然智障。

看了DISCUZZ[Why factor 2 or 3? The math behind this problem](https://leetcode.com/discuss/98276/why-factor-2-or-3-the-math-behind-this-problem) , 算是有个勉强的合理解释。

首先，我们一个先验是，确定有一个唯一的数（实数域上的实数，非整数），使得n只分解为该数，才能够得到最大乘积。如果愿意理解，这个是很好理解的——小学时我们知道，周长一定，正方形面积最大。当然，后来我们知道圆其实是最大的，这其实在暗示越均等（长宽->边长->半径）乘积（面积）越大。

ok（上面其实并没有有力论证...），当我们的n足够大，那么我就设这个数是k。那么n可以分成 $\frac{n}{k}$个k，它们的乘积是$ p = k ^{ \frac{n}{k}}$ ， 我们要求k取何值时，$p$取得最大值. $p$ 对 $k$求导，

$$
\frac{d p}{d k} = \frac{d k^{\frac{n}{k}} }{d k} = \frac{d e^{\ln x ^{ \frac{n}{k}} }}{ d k} = \frac{d e^{ \frac{n}{k} \ln x }}{d k} = k^{\frac{n}{k}-2}n(1- \ln k)
$$

易得当 $ k> e$时，$p$值递减, $ k < e$ 时递增，即在$k = e$时有最大值。即把n分为 $\frac{n}{e}$ 个 $e$时，其乘积最大。

然后从实数回到整数，距离e最近的是3、2。那么足够大的n该多大呢？特别的，验证当n=5时，已经满足分为3时大于分为2，故5可以作为临界值。(` math.pow(3, 5./3)=6.2402,  math.pow(2, 5./2)=5.6568`)。

则特例有 2 ， 3， 4 ， 其值直接算出为1，2，4；

大于此值后，我们就一直从n中分解出3，直到剩余值小于等于4，这时就出发到了特例条件，剩2、3时直接乘2、3，剩4时分解为2、2，也就是4，所以直接乘上剩余值即可。

ok，说完了。或者说，把人家的想法说完了...

能做的就是写代码了。只用了O(1)的空间，把特殊值限制到了4，算是思考后的结果吧。

## 代码

```C++
class Solution {
public:
    int integerBreak(int n) {
        switch(n)
        {
            case 2 :
                return 1 ; // 1 + 1
            case 3 :
                return 2 ; // 1 + 2
            case 4 :
                return 4 ; // 2 + 2
            default :
            {
                assert(n > 4);
                int productResult = 1 ;
                while( n > 4 )
                {
                    productResult *= 3 ;
                    n -= 3 ;
                }
                productResult *= n ;
                return productResult ;
            }
        }
    }
};
```

## 后记

这种题，想不到要用数学...智力题 - -