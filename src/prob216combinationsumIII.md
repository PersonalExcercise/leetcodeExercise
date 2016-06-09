# problem 216. Combination Sum III

[link](https://leetcode.com/problems/combination-sum-iii/)

## 方法

与[Combination Sum1](prob39combinationsum.md)和[Combination Sum2](prob40combinationsumII.md)相比，就是上述两个问题的综合，再稍有限制：

1. 候选集是`set` (1-9)

2. 每个数字只能用一次(组合中各数字是unique)

限制： 必须是k个数。

想想，还是很简单的。加上必要的判断和剪枝即可。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> combinationSum3(int k, int n) {
        vector<vector<int>> result ;
        vector<int> selectedNums;
        selectNum(k, selectedNums, n, result);
        return result;
    }
private:
    void selectNum(int k, 
                   vector<int> &currentSelectedNums, 
                   int target, 
                   vector<vector<int>> &result, 
                   size_t startPos=1)
    {
        if(currentSelectedNums.size() > k){ return ;}
        if(target < 0) { return ;}
        else if(target == 0)
        { 
            if(currentSelectedNums.size() == k) {result.push_back(currentSelectedNums);}
            return;
        }
        for(int i = startPos; i <= 9 && i <= target; ++i)
        {
            // try to add current number to currentSelectedNums
            currentSelectedNums.push_back(i);
            selectNum(k, currentSelectedNums, target - i, result, i+1);
            // try next num
            currentSelectedNums.pop_back();
        }
        
    }
};
```