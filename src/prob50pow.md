##problem 50 pow(x , n)

### [link](https://leetcode.com/problems/powx-n/)

### 方法

求一个数的n次方，直接相乘，时间复杂度比较明显，是O(n)

使用二分方法 ， 

1. 如果n是奇数，则返回 pow(x , n/2) * pow(x , n/2) * x

2. 如果n是偶数，则返回 pow(x , n/2) * pow(x , n/2) 

3. 边界条件是： 当n=0时，返回1 ； （也可以包含n=1时，返回x ）；

### 复杂度分析

时间复杂度： 虽然分成了两个子问题，但是两个子问题是相同的，只需要求解一次；合并时间就是做一次或两次乘法，认为是常数时间。因而得到递推关系T(n) = T(n/2) + O(1)

使用Master定理，求得时间复杂度为`O(lgn)`

空间复杂度： 常数 . O(1) 

### 注意

1. 不要忘记考虑n为负数的情况！！

2. 不要忘记考虑n为0的情况（所以边界条件一定需要包含n=0的情况）。


### 代码

    class Solution {
    public:
        double myPow(double x, int n) {
            // 首先我们需要判断n的正负！！
            if(n < 0){
                return 1.0 / pow4positive_number(x , -n) ;
            }
            else{
                
                return pow4positive_number(x , n ) ;
            }
        }
    private :
        double pow4positive_number(double x , int n){
            // 边界条件
            if( 0 == n) return 1 ;
            if( 1 == n) return x ;
            int half = n / 2 ;
            double half_pow_value = pow4positive_number(x , half) ;
            // 判断n的奇偶
            if( n % 2 == 0){
                return half_pow_value * half_pow_value ;
            }
            else{
                return half_pow_value * half_pow_value * x ;
            }
        
        }
    };

