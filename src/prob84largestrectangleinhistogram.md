###problem 84 Largest Rectangle in Histogram

[link](https://leetcode.com/problems/largest-rectangle-in-histogram/)

####思路

一种直观方法，就是对每个柱形，分别向两边找，使得找到最大的以该柱形高度为矩形高度的矩形。时间复杂度为O(n^2)。

另外就是栈方法。

首先建立一个栈，栈中放每个柱形的从左到右数的序号（用来计算宽度）。

入栈规则：

1. 栈空，则入栈；

2. 否则，比较 *将入栈元素* 与 *栈顶元素* ， 如果 *栈顶元素* 的高度 **大于** *将入栈元素* ， 则弹出栈，计算以此弹出元素对应的柱形的高度为矩形高度的面积（计算方法后面说明）。继续比较*将入栈元素*与*此时栈顶元素*。

经过上面的规则，可知： 

1. 栈中保证有栈底到栈顶元素对应的柱形高度**递增**。

2. 栈中任意元素E，其在栈中的下面元素记为L，上面元素记为H （可能没有），满足直方图中，从L到H范围内的柱形高度都高于E！

有了上面的说明，我们说明弹出栈底元素后相应的计算面积的方法：

1. 高度即为 弹出元素对应的柱形高度。

2. 宽度：左边界为此时栈顶元素对应的柱形序号（就是栈顶值），右边界就是当前*将入栈元素*的序号！

需要仔细体会啊！

此外，在遍历外直方图后，栈中还有剩余元素。对这些元素依次做弹栈处理，每次弹栈都计算面积！面积计算方法与上面相同，只是此时的*将入栈元素*的序号就是柱形的个数值。

####代码


首先尝试了暴力枚举法，超时：

    class Solution {
    public:
        int largestRectangleArea(vector<int>& heights) {
            /**
             * Brute force
             */
            int maxArea = 0 ;
            for(int i = 0 ; i < heights.size() ; ++i)
            {
                int height = heights[i] ;
                int width ;
                // left find 
                int left = i - 1 ;
                while(left >= 0 && heights[left] >= height) --left ;
                // right find 
                int right = i + 1 ;
                while(right < heights.size() && heights[right] >= height ) ++right ;
                width = right - left - 1 ;
                maxArea = max(maxArea , width * height) ;
            }
            return maxArea ;
        }
    };


接着写栈方法：

    class Solution {
    public:
        int largestRectangleArea(vector<int>& heights) {
            /**
             * stack method
             */ 
             stack<int> s ;
             int size = heights.size() ;
             if(0 == size) return 0 ;
             else s.push(0) ;
             
             int maxArea = 0 ;
             for(int i = 1 ; i < size ; ++i)
             {
                 while(!s.empty() && heights[s.top()] > heights[i])
                 {
                     // pop and calculate area
                     int idx = s.top() ;
                     s.pop() ;
                     int height = heights[idx] ;
                     int width ;
                     if(s.empty()) width = i ;
                     else width = i - 1 - s.top()  ;
                     maxArea = max(maxArea , width * height) ;
                 }
                 s.push(i) ;
             }
             // clear the left elements in stack
             while(!s.empty())
             {
                 int idx = s.top() ;
                 s.pop() ;
                 int height = heights[idx] ;
                 int width ;
                 if(s.empty()) width = size ;
                 else width = size - 1 - s.top() ;
                 maxArea = max(maxArea , width * height) ;
             }
             
             return maxArea ;
        }
    };

AC。