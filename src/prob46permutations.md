# problem 46. Permutations

[题目链接](https://leetcode.com/problems/permutations/)

## 方法

看了下题解，有两种方法：

一种是看做一个递归的过程：对n个数的置换集合，可以看做在前n-1的所有置换序列中，对每个置换序列的每个位置插入n，最后得到的结果就是n个数构成的置换集合。

举个实例：

```C++
    1,2,3
    init. {}
    1. {1}
    2. {1,2}, {2,1}
    3. { {1,2,3}, {1,3,2}, {3,1,2} }, { {2,1,3}, {2,3,1}, {3,2,1} }
```

看了过程还是很好理解的，但是插入操作对于vector太致命了。

第二种，就是典型的深搜了（枚举）。

```C++
void DFS(result, currentState, leftNums)
{
    if(leftNums.size() == 0)
    {
        result.push(currentState);
        return;
    }
    for(size_t i = 0; i < leftNums.size(); ++i)
    {
        int headVal = leftNums.front();
        leftNums.pop();
        currentState.push_back(headVal);
        DFS(result, currentState, leftNums);
        currentState.pop_back();
        leftNums.push(headVal)
    }
}
```

注意，上面的`leftNums`使用了`queue`，这样会比较方便（但是得到的置换结果不是按字典序递增的——要想递增，得每层递归前先排序）。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> permute(vector<int>& nums) {
        vector<vector<int>> result;
        vector<int> currentState;
        queue<int> leftNums(deque<int>(nums.begin(), nums.end()));
        permuteRecursively(result, currentState, leftNums);
        return result;
    }
private:
    void permuteRecursively(vector<vector<int>> &result, vector<int> &currentState, queue<int> &leftNums)
    {
        int nrLeftNum = leftNums.size();
        if(nrLeftNum == 0)
        {
            result.push_back(currentState);
            return;
        }
        for(int i = 0; i < nrLeftNum; ++i)
        {
            int headVal = leftNums.front();
            leftNums.pop();
            currentState.push_back(headVal);
            permuteRecursively(result, currentState, leftNums);
            currentState.pop_back(); // remove the val last added
            leftNums.push(headVal); // put the previous head to the tail. After the Iteration, the leftNums keeps invariant
        }
    }
};
```