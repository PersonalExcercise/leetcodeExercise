# problem 40. Combination Sum II

[link](https://leetcode.com/problems/combination-sum-ii/)

## 方法

与[Combination Sum](prob39combinationsum.md) 相比，

1. 每个数仅能被使用一次

2. 候选集不再是`set`，而是`collections`，就是可以包含重复数字了

怎么办呢？针对第一个，非常简单，只需要把开始递归的开始下标设为当前位置的下一个位置即可。

重复？想象一下重复的组合时怎么来的：

```XML
input : [1,1,3,4,5]
```

如果对第一个1，我们在`[3,4,5]`中能够找到候选数字，那么对第二个1，肯定也能够找到相同的候选数字。虽然本质上第二个1与第一个1是不同的，然而从最后的组合结果看却是相同的。因而，之前的方法是不能避免重复这个问题的。解决方法是（看了下题解发现的...）开始下次选择前，跳过重复数字即可。即是，完成第一个1的选择后，跳过第二个1。（这时就要求候选集必须排序了！）



## 代码

```C++
class Solution {
public:
    vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
        vector<vector<int>> result ;
        vector<int> selectedNums;
        sort(candidates.begin(), candidates.end()); // for efficent quit in select
        selectNum(selectedNums, candidates, target, result);
        return result;
    }
private:
    void selectNum(vector<int> &currentSelectedNums, const vector<int> &candidates,
                   int target, vector<vector<int>> &result, 
                   size_t startPos=0)
    {
        if(target < 0) { return ;}
        else if(target == 0){ result.push_back(currentSelectedNums); return; }
        for(auto iter = candidates.cbegin() + startPos; iter < candidates.cend() && *iter <= target; ++iter)
        {
            // try to add current number to currentSelectedNums
            currentSelectedNums.push_back(*iter);
            selectNum(currentSelectedNums, candidates, target - *iter, result, iter-candidates.cbegin() + 1);
            // try next num
            currentSelectedNums.pop_back();
            // skip duplicates (the same number with previous may cause duplicates result .)
            while(iter + 1 < candidates.cend() && *(iter+1) == *iter) ++iter; 
        }
        
    }
};
```