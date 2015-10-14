###problem [53] [Maximum Subarray]

[link](https://leetcode.com/problems/maximum-subarray/)

这是一个很神奇的题，可以有很多种方法来求解：

1. 枚举
    
    比较直观。

        class Solution {
        public:
            int maxSubArray(vector<int>& nums) {
                int maxSum = -10000 ;
                int numSize = nums.size() ;
                for(int start = 0 ; start < numSize ; ++ start)
                {
                    int currentSum = 0 ;
                    for(int pos = start ; pos < numSize ; ++pos)
                    {
                        currentSum += nums[pos] ;
                        if(currentSum > maxSum) maxSum = currentSum ;
                    }
                }
                return maxSum ;
            }
        };

    已经是优化版本(O(n^2)) ， 但是仍会超时 。


2. 分治

    > 待完成

3. 动态规划

    定义S[i]表示**以第i个元素结尾**的最大连续子数组和，以第i个元素结尾非常重要，这保证了动态规划存在子问题，且有重叠子问题。

    定义M[i]表示0~i间最大连续子数组和。

    代码如下：

        class Solution {
        public:
            int maxSubArray(vector<int>& nums) {
                vector<int> maxSumEndingWithCurrentNum(nums.size()) ;
                int maxSum ;
                maxSumEndingWithCurrentNum[0] = nums[0] ;
                maxSum = nums[0] ;
                for(int i = 1 ; i < nums.size() ; ++i)
                {
                    maxSumEndingWithCurrentNum[i] = max( maxSumEndingWithCurrentNum[i-1] + nums[i] , nums[i]) ;
                    maxSum = (maxSum > maxSumEndingWithCurrentNum[i] ) ? maxSum : maxSumEndingWithCurrentNum[i] ;
                }
                return maxSum ;
            }
        };

    复杂度O(n) ;