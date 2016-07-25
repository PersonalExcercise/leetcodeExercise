# problem 228. Summary Ranges

[题目链接](https://leetcode.com/problems/summary-ranges/)

## 方法

有两种方法，一种是在后一个位置判断前一个位置是否连续，这种情况下需要在循环开始、结束后做后处理。

另一种是在当前位置判断后一个位置与当前是不是连续。这种情况下需要判断后一个位置是否合法，但是因为这与不连续带来的结果是一致的，因此代码写起来会很一致。所以这是一种更好的写法。

## 代码

```C++
class Solution {
public:
    vector<string> summaryRanges(vector<int>& nums) {
        vector<string> result;
        size_t nrNum = nums.size();
        size_t start = 0,
               end = 0;
        while(end < nrNum)
        {
            if( end + 1 < nrNum && nums[end+1] - 1 == nums[end]) // can handler overflow ! because increasing  sorted !
            {
                ++end;
            }
            else
            {
                string range = to_string(nums[start]);
                if(end > start){ range += "->" + to_string(nums[end]); }
                result.push_back(range);
                start = end + 1;
                end = start;
            }
        }
        return result;
    }
};
```