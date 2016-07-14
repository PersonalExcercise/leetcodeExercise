# problem 162. Find Peak Element

[题目链接](https://leetcode.com/problems/find-peak-element/)

## 方法

固定`O(lg n)`时间找到局部最大值。还有什么办法，当然是二分了。然而却不知道该怎么做。

ARE YOU OK， 这个也可以用二分吗...

看了DICUSS，大概理解一下：

首先，因为题目中`nums[i] != nums[i+1] , nums[-1] = nums[sz] = -inf`，所以必然有peak值，乱序下必然有，有序下端点处就是。所以呢，牛逼的人就把找局部最大想象成找全局最大了。

如果 nums[mid] > nums[mid+1] , 那么最大值就在右边，且mid有可能就是；

否则(即nums[mid] < nums[mid+1])，最大值在左边，且mid有可能是。

如果你把它看做找全局最大，那么这是比较好理解的，就是在尖峰两端游走嘛。然而这毕竟是找局部最大啊...

最后，这还是是二分的变体，又不是比较mid的值与mid+1的值的关系。二分搜索真的是神啊。

还有很wise的线性搜索：

```C++
for(int i = 1; i < nums.size(); ++i)
{
    if(nums[i] < nums[i-1]){ return i-1; }
}
return nums.size() - 1;
```

的确很好。不用比较两边的值，顺序的情况下，只需要比较右边就好了。这真的还是蛮神奇的。

## 代码

```C++
class Solution {
public:
    int findPeakElement(vector<int>& nums) {
        int sz = nums.size();
        for(int i = 1; i < sz; ++i)
        {
            if(nums[i] < nums[i-1]){ return i - 1;}
        }
        return sz - 1; // for empty set , return -1 . also acceptable , bacause no definition
    }
};
```