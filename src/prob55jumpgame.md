###problem [55] [Jump Game]

[link](https://leetcode.com/problems/jump-game/)

一眼看过去就傻了，该怎么做呢？看了题解，真是恍然大悟！！

思维的差距~

###方法

1. 正向的贪心

    在每一步，我们看能够到达的最远的位置；取每步能到达的最大位置作为当前能够到达的最远位置；如果当前的位置比当前能够到达的最远位置远了，那么就不能往前再走了，也就不能到达最后位置了。
    ```C++
    class Solution {
    public:
        bool canJump(vector<int>& nums) {
            int numSize = nums.size() ;
            int canMaxReachPosition = 0 ;
            for(int i = 0 ; i < numSize ; ++i)
            {
                if( i > canMaxReachPosition)
                {
                    break ;
                }
                int currentMaxReachPosition = i + nums[i] ;
                if(currentMaxReachPosition > canMaxReachPosition)
                {
                    canMaxReachPosition = currentMaxReachPosition ;
                }
            }
            // if has reach ?
            if(canMaxReachPosition >= numSize - 1)
            {
                return true ;
            }
            else 
            {
                return false ;
            }
            
        }
    };
    ```

2. 反向贪心

    倒过来想，先设能够到达的最右边的距离为 N ，然后从N-1的位置忘后走，如果在当前的位置能够到达的最远距离比需要到达的最右边距离大或者等，说明在当前位置能够到达最右边的距离，那么只要保证后面的点能够到达当前点，就肯定能够到达最右边的距离了。

    这么来看，的确包含了贪心的思想。只是感觉有些隐晦，不能很好的说清楚，究竟贪心选择了什么？
    
    ```C++
    class Solution {
    public:
        bool canJump(vector<int>& nums) {
            int numSize = nums.size() ;
            int rightMost = numSize -1 ;
            for (int i = numSize -2 ; i >= 0 ; --i )
            {
                int currentReachMost = i + nums[i] ;
                if(currentReachMost >= rightMost)
                {
                    rightMost = i ;
                }
            }
            if(rightMost == 0) return true ;
            else return false ;
        }
    };
    ```

3. 动态规划

    子问题： 用f[i]表示当前位置能够到达的*最远位置*。则最远位置，可能是前一个位置出发能到达的最远的位置和从当前位置出发能到达的最远位置。

    即`f[i] = max(f[i-1] , i + A[i]) ; f[0] = A[0]` ；

    如果当前的位置比前一个位置能够到达的最远位置还大，说明不能再继续。即`i > f[i-1]`，则退出。

    ```C++
    class Solution {
    public:
        bool canJump(vector<int>& nums) {
            int numSize = nums.size() ;
            vector<int> maxPosition(numSize , 0) ;
            maxPosition[0] = nums[0] ;
            for(int i = 1 ; i < numSize ; ++i)
            {
                if(i > maxPosition[i-1]) break ;
                maxPosition[i] = max(maxPosition[i-1] , i + nums[i]) ;
            }
            if(maxPosition[numSize-1] >= numSize-1) return true ;
            else return false ;
        }
    };
    ```
