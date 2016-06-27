# problem 18. 4Sum

[题目链接](https://leetcode.com/problems/4sum/)

## 方法

这个，今天做了两个数的和为特定值，3个数的和为特定值，之前做了任意个数的和为特定值。

总结一下。

首先最普通的情况，使用深搜+回溯即可。做起来其实没有那么高端，就是：

```
def recursively(num, start, end, target, currentState, result)
    if(current.size() == K)
    {
        if target == 0 :
            result.append(currentState)
        return 
    }
    for i in range(start, end) :
        currentState.append(num[i])
        recursively(num, start+1, target-num[i], currentState, result)
        currentState.pop()
```


再说特殊情况：两个数情况，如果只需要返回两个数，那么就排序，然后两个首尾指针相向移动即可；如果需要返回下标，则不能排序。在解唯一的情况下，可以在遍历过程中，存储hashTable存储数->索引，只需扫一遍即可。再一般地，那就暴力找也可。2个数以上的似乎都是找数，而不是找下标。接着说3个数，O(N^2)时间复杂度的话，先排序，然后依次移动第一个指针，接着剩下两个数就用双指针找即可。如果4个数，就是这道题了，还是用3个数一样的方法，因为这样可以降低一次方的复杂度。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> fourSum(vector<int>& nums, int target) {
        vector<vector<int>> result;
        sort(nums.begin(), nums.end());
        int sz = nums.size();
        int pos1 = 0 ;
        while(pos1 < sz - 3)
        {
            int pos2 = pos1 + 1;
            while(pos2 < sz -2)
            {
                int leftVal = target - nums[pos1] - nums[pos2];
                // test some edge case for quickly stop
                if(nums[pos2+1] + nums[pos2+2] > leftVal){ ++pos2; continue; } // min greater
                if(nums[sz-2] + nums[sz-1] < leftVal){ ++pos2; continue; } // max less
                
                int pos3 = pos2 + 1;
                int pos4 = sz - 1;
                while(pos3 < pos4)
                {
                    int sumVal = nums[pos3] + nums[pos4]; 
                    if(sumVal == leftVal)
                    {
                        result.push_back({nums[pos1], nums[pos2], nums[pos3],
                                          nums[pos4]});
                        ++pos3;
                        --pos4;
                        // move when same
                        while(pos3 < pos4 && nums[pos3] == nums[pos3-1]){ ++pos3; }
                        while(pos3 < pos4 && nums[pos4] == nums[pos4+1]){ --pos4; }
                    }
                    else if(sumVal < leftVal){ ++pos3; }
                    else{ --pos4; }
                }
                ++pos2;
                while(pos2 < sz-2 && nums[pos2] == nums[pos2-1]){ ++pos2; }
            }
            ++pos1;
            while(pos1 < sz-3 && nums[pos1] == nums[pos1-1]){ ++pos1; }
        }
        return result;
    }
};
```

## 后记

用了剪枝，不过剪错了一次... 