# problem 16. 3Sum Closest

[题目链接](https://leetcode.com/problems/3sum-closest/)

## 方法

与三数和问题一样的处理，没有太多的不同。

能想到稍微的优化是，因为对固定一个数，找另外两个数的双指针探索过程中，diff应该是先降后升的（当然可能只有上升或者只有下降部分），所以发现上升了就可以直接跳过后面的探索了。

不知道能否用二分优化？随口一说，看题解中似乎有相应的主题，不过不是太想花时间想...

## 代码

```C++
class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        int nrNum = nums.size();
        if(nrNum < 3){ return numeric_limits<int>::lowest(); } // may be no need
        int closestSum = 0;
        unsigned minDiff = numeric_limits<unsigned>::max();
        sort(nums.begin(), nums.end());
        for(int i = 0; i < nrNum - 2; ++i)
        {
            unsigned currentMinDiff = numeric_limits<unsigned>::max();
            int left = i + 1,
                right = nrNum - 1;
            while(left < right)
            {
                int threeSum = nums[i] + nums[left] + nums[right];
                unsigned diff = abs(threeSum - target);
                if(currentMinDiff > diff )
                { 
                    currentMinDiff = diff; 
                    if(minDiff > currentMinDiff)
                    {
                        minDiff = currentMinDiff;
                        closestSum = threeSum;
                    }
                }
                else if(currentMinDiff < diff){ break; } // diff increasing, no need try continues
                // move
                if(threeSum < target){ ++left; }
                else{ --right; }
                
            }
        }
        return closestSum;
    }
};
```