# problem 33. Search in Rotated Sorted Array

[题目链接](https://leetcode.com/problems/search-in-rotated-sorted-array/)


## 方法

嗯，这道题不难，我差不多做了10天... 大概很早之前就做了，想想不就是二分的思想吗，而且想起来还算简单——

左部分递增、右部分递增，知道左部分最小值，知道右部分最大值，且左部分最小值大于右部分最大值。根据mid指向的位置的数值与左部分最小、右部分最大值来，以及mid指向值与目标值的关系来确定具体的区间就好了。

总的来说，二分问题，更加复杂的二分。

然而一涉及到二分就是比较蛋疼，总是要考虑各种退出条件，特别是与标准二分的写法对比起来实在让人迷惑。

现在看来，应该这样来写一个容易写对，但是效率不那么高的手写类二分算法：

1. high指向最后一个元素，而不是尾后

2. 退出条件是low小于high

3. 不激进，保证low与high移动时不错过可能的值（不要像标准写法那样可能让high直接跑到目标值前面，然后让low去指向然后退出）

4. 考虑数组为空，数组为1个数的情况

总之，遇到这种题，就多试试就好。考虑下推出时的条件，想一下case。面试遇到感觉会GG。

## 代码

```C++
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int sz = nums.size();
        if(0 == sz){ return -1; }
        int low = 0,
            high = sz - 1;
        while(low < high )
        {
            int mid = low + ( high - low ) / 2; // `/ 2` <==> `>>1`
            int midVal = nums[mid];
            if(midVal == target){ return mid; }
            else if(midVal > target)
            {
                // mid in which part ?
                if(midVal >= nums[low])
                {
                    // mid in left part , and the target pos should be located in left inceasing part or right inceasing part
                    if(nums[low] <= target)
                    {
                        high = mid;
                    }
                    else if(nums[high] >= target)
                    {
                        low = mid + 1;
                    }
                    else{ return -1; }
                }
                else
                {
                    // mid is in the right part
                    high = mid;
                }
            }
            else
            {
                if(midVal >= nums[low])
                {
                    low = mid + 1;
                }
                else
                {
                    if(nums[high] >= target)
                    {
                        low = mid + 1;
                    }
                    else if(nums[low] <= target)
                    {
                        high = mid - 1;
                    }
                    else { return -1; }
                }
            }
        }
        return nums[low] == target ? low : -1;
    }
};
```