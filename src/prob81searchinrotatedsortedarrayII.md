# problem 81. Search in Rotated Sorted Array II

[题目链接](https://leetcode.com/problems/search-in-rotated-sorted-array-ii/)

## 方法

在[search in rotated sorted array](prob33searchinrotatedsortedarray.md)的基础上，加入了有重复这一条件。

问题变得更加复杂了，因为当我们遇到mid对应的值，与low、high对应的值都相等时，我们无法判断现在的mid处于旋转排序数组的哪部分。必然有至少大于一半全是相同的值，剩下小于半个区间长度的值不是相等的。

在《剑指offer》上，作者给出的解法是直接线性搜索。这样带来了O(n)的复杂度。然后，我就这么写了...

然后看了DISCUSS，发现人家都没有这么写... 是判断low指向的值与mid指向的值的关系，如果不相等，则可以确定区间，如果相等，则理论上可以通过判断与high指向值的关系来判断是否真的不能确定区间，但是题解里直接就递增low值了。这样时间复杂度还是O(n)的，不过整体框架维持了二分搜索的样子。看起来似乎还是要高级些。不过二者之间效率应该差别不大，毕竟都是O(n).

## 代码

low版...

```C++
class Solution {
public:
    bool search(vector<int>& nums, int target) {
        int sz = nums.size();
        if(0 == sz){ return false; }
        int low = 0,
            high = sz -1;
        while(low < high)
        {
            int mid = low + (high  - low) / 2;
            int midVal = nums[mid],
                lowVal = nums[low],
                highVal = nums[high];
            // first we determined where is mid val
            if(lowVal < highVal)
            {
                // increasing range
                if(midVal < target){ low = mid + 1; }
                else if(midVal > target){ high = mid; }
                else{ return true; }
            }
            else if(lowVal == midVal && midVal == highVal)
            {
                // can't know whre is the mid val
                for(int i = low; i <= high; ++i)
                {
                    if(nums[i] == target){ return true;}
                }
                return false;
            }
            else if(midVal >= lowVal)
            {
                // left part
                if(midVal < target)
                {
                    low = mid + 1;
                }
                else if(midVal > target)
                {
                    if(lowVal <= target)
                    {
                        // in left range
                        high = mid;
                    }
                    else if(highVal >= target)
                    {
                        low = mid + 1; // ! because highVal >= target , so midVal can't be final position
                    }
                    else{ return false; }
                }
                else{ return true; }
            }
            else if(midVal <= highVal)
            {
                // right part
                if(midVal < target)
                {
                    if(highVal >= target)
                    {
                        low = mid + 1;
                    }
                    else if(lowVal <= target)
                    {
                        high = mid - 1;
                    }
                    else{ return false; } // empty
                }
                else if(midVal > target)
                {
                    high = mid - 1;
                }
                else{ return true; }
            }
            else { cerr << "impossible for rotated sorted array."; throw runtime_error("invalid array."); }
        }
        return nums[low] == target;
    }
};
```