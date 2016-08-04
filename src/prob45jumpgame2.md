# problem 45. Jump Game II

[题目链接](https://leetcode.com/problems/jump-game-ii/)

## 方法

题解真是给力啊！

自己只想了一个从后往前DP的方法，O(n^2) 时间 + O(n)空间；不过DISCUSS里的答案复杂度是O(n) + O(1)

他们将这个问题转化为广度优先搜索（BFS）问题，或者更准确的说，是层序遍历问题。

用区间[start, end]表示在该区间的数组中的数构成一层树节点；

初始根节点为第0个元素，即[0,0]。

然后做层序遍历—— 我们设置下一层的起始节点下标时 当前的 end + 1 , 故只需找下一层的终结节点。 怎么求？ 用 max(i + nums[i]) , 即最远Jump的值。则下一层的区间就变为了 [end+1, maxJump]; 这就是在当前层的节点下确定的下一层节点——对应回问题，就是这一步我可以在[start, end]中跳，而下一步可以跳（跳到）的区间是[end+1, maxJump], 如果maxJump已经比最后一个索引还大了，说明这次一跳就可以到终点了。否则开始下一跳。每跳一次都 递增一下计数。

## 代码

```C++
class Solution {
public:
    int jump(vector<int>& nums) {
        int nrJump = 0;
        int currentStepStartPos = 0,
            currentStepEndPos = 0, // [start, end]
            lastPos = nums.size() - 1;
        while(currentStepEndPos < lastPos)
        {
            int nextStepEndPos = currentStepEndPos;
            for(int k = currentStepStartPos; k <= currentStepEndPos; ++k)
            {
                nextStepEndPos = max(nextStepEndPos, k + nums[k]);
            }
            currentStepStartPos = currentStepEndPos + 1;
            currentStepEndPos = nextStepEndPos;
            ++nrJump;
            if(currentStepStartPos > currentStepEndPos ){ return -1; } // can't reach
        }
        return nrJump;
    }
};
```