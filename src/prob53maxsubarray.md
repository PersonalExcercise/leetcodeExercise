# problem 53 Maximum Subarray

[link](https://leetcode.com/problems/maximum-subarray/)

这是一个很神奇的题，可以有很多种方法来求解。

[最大子数组和问题](http://memeda.github.io/%E7%AE%97%E6%B3%95/2015/10/14/%E6%9C%80%E5%A4%A7%E5%AD%90%E6%95%B0%E7%BB%84%E5%92%8C%E9%97%AE%E9%A2%98.html)有更加详细的解释。

以下是各种方法对应的代码。leetcode上的代码编辑器写起来也不错啊，感觉字体配上白色背景简直炫酷，不过在本地编辑器里还是老老实实用黑背景吧，不然眼睛要瞎 - -

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
    
    最大值可能出现在3个地方：

    1. 左边部分

    2. 右边部分

    3. 经过中间原始的序列

    1,2 都是子问题的解，第3个需要在合并时计算。所谓中间，由于我们分的时候是均分的，实际上没有留出中间元素，所以中间元素就是指包含左边部分最右的元素和右边部分最左边的元素。

    ```C++
        class Solution {
        public:
            int maxSubArray(vector<int>& nums) {
                return divideConquerSolver(nums , 0 , nums.size() -1 ) ;
            }
        private :
            const int NEG_INF = - 0x7fff ;
            int divideConquerSolver(vector<int>& nums , int left , int right)
            {
                if(left == right) return nums[left] ;
                int mid = left + (right - left) / 2 ;
                int leftMax = divideConquerSolver(nums , left , mid) ;
                int rightMax = divideConquerSolver(nums , 1 + mid , right) ;
                
                // the max cross cetenter value , must contain the elements in most right element of left part and most left element of right part 
                int centerLeftPartMax = NEG_INF ;
                int centerLeftPartTmpSum = 0 ;
                for(int i = mid ; i >= left ; --i)
                {
                    centerLeftPartTmpSum += nums[i] ;
                    if(centerLeftPartTmpSum > centerLeftPartMax) centerLeftPartMax = centerLeftPartTmpSum ;
                }
                int centerRightPartMax = NEG_INF ;
                int centerRightPartTmpSum = 0 ;
                for(int i = 1 + mid ; i <= right ; ++i)
                {
                    centerRightPartTmpSum += nums[i] ;
                    if(centerRightPartTmpSum > centerRightPartMax) centerRightPartMax = centerRightPartTmpSum ;
                }
                int centerMax = centerLeftPartMax + centerRightPartMax ;
                
                // which is maximum
                return max(max(leftMax , rightMax) , centerMax) ;
            }

        };
    ```

    复杂度O(n lgn)

3. 动态规划

    定义S[i]表示**以第i个元素结尾**的最大连续子数组和，以第i个元素结尾非常重要，这保证了动态规划存在子问题，且有重叠子问题。

    定义M[i]表示0~i间最大连续子数组和。

    代码如下：
    ``` C++
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
    ```
    
    复杂度O(n) ;

4. 一层循环

    > 待完成


