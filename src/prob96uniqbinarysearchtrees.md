# problem 96. Unique Binary Search Trees

[题目链接](https://leetcode.com/problems/unique-binary-search-trees/)

## 方法

智障，不会。

看了题解，[DP Solution in 6 lines with explanation. F(i, n) = G(i-1) * G(n-i)](https://discuss.leetcode.com/topic/8398/dp-solution-in-6-lines-with-explanation-f-i-n-g-i-1-g-n-i).

很简单啊，越发觉得智障。

对1到n这n个数，我们从大到小依次取一个数k作为根节点，那么根据BST性质，比它小的数（1~k-1）必然在左边子树，而比它大的数（k+1 ~ n）必然在右子树。瞬间，这就找到了递归——或者说（重叠）子问题。显然，左子树的个数与右子树的个数的乘积，就是k作为根节点的所有二叉搜索树的所有不同可能。

于是定义G[i]表示1~i这i个数的不同BST数量。

```C++
G[i] = G[0]*[i-1] + G[1]G[i-2] + ... + G[i-1]G[0]
G[0] = 1  # manual defined
```

上面成立的一个隐含意思是， 1~k这个k个数构成的不同BST数目与 2~k+1 、 3~k+2等同样k个数构成的BST数量是相同的。这应该是显然的，因为节点个数是相同的，且大小关系相同。

## 代码

```C++
class Solution {
public:
    int numTrees(int n) {
        // coding as 
        // https://discuss.leetcode.com/topic/8398/dp-solution-in-6-lines-with-explanation-f-i-n-g-i-1-g-n-i
        if(n < 0){ return 0; }
        else if(n == 0 || n == 1){ return 1;}
        vector<int> G(n+1, 1);
        for(int i = 2; i <= n; ++i)
        {
            int nrTree = 0;
            int doubledTopIndex = i / 2;
            for(int stateIdx  = 0; stateIdx < doubledTopIndex; ++stateIdx)
            {
                nrTree += G[stateIdx] * G[i-1-stateIdx];
            }
            nrTree *= 2; // double time
            if(i % 2 != 0 )
            {
                nrTree += G[doubledTopIndex] * G[doubledTopIndex];
            }
            G[i] = nrTree;
        }
        return G.back();
    }
};
```

## 后记

现在全靠看答案了... 找工作怎么办...