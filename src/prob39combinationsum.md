# problem 39. Combination Sum

[link](https://leetcode.com/problems/combination-sum/)

## 方法

首先，需要使用递归，使用一个容器去存储当前已经选择的数，同时，在递归时，选择一个数后，就将目标值减去选择的数，作为下次递归的目标数。递归需要传递的参数（保持的状态）有 ： 已选择的数集合，候选集，目标值，结果集，递归开始的下标。

题目的一个要求是同一个数可以多次选择，但选择的组合之间不能重复。上面的参数`递归开始的下标`就是完成这个功能的。我们每次递归时，将递归的开始下标设为当前选择的数的下标，这样在递归中就可以重复测试当前数，满足同一个数多次选择的条件。而且其可以保证得到所有可能的不重复组合（如果输入的数都是不相同的，那么得到的组合结果也是彼此不同的，而题目的要求`set`保证了该点）。这点也是非常重要的。

为了加快选择的效率，**非常有必要对候选集进行排序**！这样在测试选择时，只要当前将要选择的数已经大于目标值了，那么后面的数都不再需要测试了。一次排序，受益终生。

最后，该题的标签是`回溯`，想想，哪里用到了回溯呢？我觉得还是递归在这里起到了保存之前状态的作用吧。同时，我们每次选择一个数，然后将其加入到`已选择数集合`，接着开始当前选择下的递归，当递归返回时，我们把选择的数从`已选择数集合`中删除，那么同轮迭代时，下次选择的数就与上次的状态是一致的了。如此，完成了状态的回溯。


## 代码

```C++
class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
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
        for(auto iter = candidates.cbegin() + startPos; iter != candidates.cend() && *iter <= target; ++iter)
        {
            // try to add current number to currentSelectedNums
            currentSelectedNums.push_back(*iter);
            selectNum(currentSelectedNums, candidates, target - *iter, result, iter-candidates.cbegin());
            // try next num
            currentSelectedNums.pop_back();
        }
        
    }
};
```