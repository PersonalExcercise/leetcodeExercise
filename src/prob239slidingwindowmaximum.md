# problem 239. Sliding Window Maximum

[题目链接](https://leetcode.com/problems/sliding-window-maximum/)

## 方法

本来以为是要用堆的，但是一想每次不是将最大元素移除，而是移除特定元素，但是堆似乎不支持此操作；或者用修改某个值的权重的操作？这样时间复杂度是O(n lgn)的，还是不满足需求！

看了题解，非常巧妙啊。一句话，用一个deque维持了一个窗口元素单调递减的序列；每次移动窗口，首先判断左边的最大元素是否已经滑出窗口了，如果是，那么就pop掉；然后，从back往前判断deque中的值（其实是索引，这里为了方便，就认为是元素值）与新加入元素的大小——如果即将加入的元素比deque最后一个元素小，那么原来维持的递减序列不变，直接加进来就好；如果新加的元素大，那么说明最后一个元素再也不可能成为最大值了，所以pop掉它，继续比较新的最后一个元素与即将新进的元素大小，直到最后一个元素大（等于也是可以的，没有问题）或者deque为空。

非常巧妙！


## 代码

```C++
class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        deque<int> indexOfMaxElementSeq;
        vector<int> result;
        int sz = nums.size();
        result.reserve(sz - k + 1); // `sz - k + 1` values
        for(int i = 0; i < sz; ++i)
        {
            // remove front index when it has been out of window
            if(!indexOfMaxElementSeq.empty() && indexOfMaxElementSeq.front() < i - k + 1 )
            {
                indexOfMaxElementSeq.pop_front();
            }
            // move new element to window, if the new element is bigger than previous elements of the current window,
            // we should pop it until the deque's back elements value is bigger than the new element or the deque is empty
            while(!indexOfMaxElementSeq.empty() && nums[indexOfMaxElementSeq.back()] <= nums[i])
            {
                indexOfMaxElementSeq.pop_back();
            }
            indexOfMaxElementSeq.push_back(i);
            // if the window has full (only skip at the begging when window has not been filled)
            if(i >= k - 1){ result.push_back(nums[indexOfMaxElementSeq.front()]); }
        }
        return result;
    }
};
```