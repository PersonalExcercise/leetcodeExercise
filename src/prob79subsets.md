# problem 78. Subsets

[题目链接](https://leetcode.com/problems/subsets/)

## 方法

想到一个非常low的DFS回溯版。还是看DISCUSS吧：[C++ Recursive/Iterative/Bit-Manipulation Solutions with Explanations](https://leetcode.com/discuss/46668/recursive-iterative-manipulation-solutions-explanations)

1. DFS+回溯

    每次DFS调用传入的状态，其实就是一个子集。

    以前一直没有留意啊.. 还想着设置步长呢..

2. 迭代版

    1. 首先放一个空子集

    2. 对集合中的每个数，copy当前结果集中的每个子集，然后向每个子集中加入当前的数字，得到新的子集。放入结果中。

3. 位操作版

    n个数的集合，共有2^n个子集。令这些子集的ID为 0 ~ 2^n -1 ; 这些ID的n位二进制表示中，每个位i取0表示将集合中第i个数放入到该子集中，相应地取0表示第i个数不放入当前集合。

    非常巧妙的对应。

## 代码

只做了位操作版。

```C++
class Solution {
public:
    vector<vector<int>> subsets(vector<int>& nums) {
        size_t nrNum = nums.size();
        size_t nrSubset = 1 << nrNum; // = 2^nrNum
        vector<vector<int>> result(nrSubset);
        for(size_t i = 0; i < nrSubset; ++i)
        {
            for(size_t bitPos = 0; bitPos < nrNum; ++bitPos)
            {
                bool shouldPush = (i >> bitPos) & 1 ;
                if(shouldPush){ result[i].push_back(nums[bitPos]);}
            }
        }
        return result;
    }
};
```