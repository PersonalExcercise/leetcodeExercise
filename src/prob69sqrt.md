###problem 50 int sqrt(int x)

[link](https://leetcode.com/problems/sqrtx/)

### 方法

返回一个整数的（非精确）平方根。

因为返回的是int，所以是非精确平方根。而且该值应该是实际平方根**向下取整，而非四舍五入取整**。

最直接的办法当然是从小到大依次找，直到遇到其平方第一次大于或等于x的数n；如果大于，则返回该数的前一个数（n -1 ）;如果相等，则返回该值（n） ;

优化方法是使用二分法（分治？准确的是减治）。

首先明确边界条件：

1. 如果x是负数，则返回-1 

2. 如果x是0 ， 返回0 ；

3. 否则就是大于等于1的数，那么它的平方根的取值范围必然在 [ 1 , x ] 之间！

使用二分，将中间值作为平方根的尝试。设中间值为mid ， 则另一个值为 x / mid ; 设为 another_value ; 

1. 如果 mid > another_value , 说明mid太大 ， 真正的平方根应该在二分区域中左边较小的部分。

2. 如果 mid < another_value , 说明mid太小 ， 平方根应该在右边区域。

3. 如果相等，直接返回mid即可。

需要注意的一点是： 当 mid 和 another_value在二分查找退出(left > right)时，都没有相等，那么我们应该怎么返回。

从上面的过程中，我们知道其实我们把mid和another_value当作平方根的候选。**一个大一个小，取小的作为结果即可**。

### 正确性证明

这道题使用二分法其实真的不是非常确信。

之前二分法也很少写。导致写的时候都写错了。希望后续做到更多题之后能够更好的理解。

### 代码

    class Solution {
    public:
        int mySqrt(int x) {
           if( 0 == x) return 0 ;
           if( 1 == x) return 1 ;
           int last_opt_value = 0 ;
           int left = 1 ;
           int right = x ;
           while(left <= right){
               int mid = left + ( right - left )/2 ;
               int another_value = x / mid ;
               
               if(another_value < mid ){
                    // mid should be smaller
                    right = mid - 1 ;
                    last_opt_value = another_value ;
               }
               else if(another_value > mid ){
                    // mid should be bigger
                    left = mid + 1 ;
                    last_opt_value = mid ;
               }
               else return mid ;
           }
           return last_opt_value ;
        }
    };



