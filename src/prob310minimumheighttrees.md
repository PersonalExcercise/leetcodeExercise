# problem 310. Minimum Height Trees

[题目链接](https://leetcode.com/problems/minimum-height-trees/)

## 方法

这个题写得很智障，真的就去求无向无环图里以每个节点为根节点的树的高度。虽然加上了缓存，但是速度还是不行。

看了题解，做法非常巧妙。

对一个无向无环图，以任意节点做根，都可以变为一个树。那么何时树的高度最小呢？使树高最小的节点有几个呢？

其实，当我们求得图上的最长路径，然后将最长路径上的中间节点作为根节点，那么此时构成的树时最矮的。而中间节点只能有1个或者2个。

——最长路径可能有多条，但是中间节点必然均在任意一条最长路径上。否则，两个中间节点必然有距离，那么连接中间节点，且包含各自最长路径一半的路径必然超过之前的最长路径。因此——要么只有一条最长路径，要么多条最长路径，但是共享同样的中间节点（此时中间节点应该只有一个）。

问题就变成了如何求最长路径了。看了题解，一种方法是以任意点为根节点，得到一棵树，然后求这棵树上距离根节点最远的叶子节点（必然也在最长路径上），然后再以此叶子节点为根，求出距离此根最远的叶子节点，也即是这个图上的最长路径了。有了最长路径，找中间点应该问题不大（其实在第二遍时可以直接存储最长路径，这样可以直接拿到中间节点）。这个通过一个遍历就可以搞定，不存在技术障碍，但自己估计也写不了太熟练。

此外，最高票是使用了与拓扑排序一样的思路！这个有点厉害！

用n表示当前集合剩余的节点数，初始化为节点的个数。

每次将边个数为1的节点移除（其实就是叶节点）；然后更新相应节点的边数量；更新n值。

直到n <= 2 为止。

这个算法，就是抽丝剥茧，每次从所有可能的路径中砍掉两头。这样，最后剩下的一定是最长路径的中间节点。此时要么只有一个节点，要么有两个。

想想，真是太完美了。

## 代码

完全就是copy的代码啊，题解写得太好了。

```C++
class Solution {
public:
    vector<int> findMinHeightTrees(int n, vector<pair<int, int>>& edges) {
        // almost copy from https://discuss.leetcode.com/topic/30572/share-some-thoughts/2
        if(n == 1){ return {0}; }
        vector<unordered_set<int>> adjTable(n);
        for(const auto &edge : edges)
        {
            int end1 = edge.first ,
                end2 = edge.second;
            adjTable[end1].insert(end2);
            adjTable[end2].insert(end1);
        }
        vector<int> leaves; // not suit for n = 1 ; because no leaf is added !( only if we change the leaf-condition )
        for(int i = 0; i < n; ++i) 
        {
            if(adjTable[i].size() == 1){ leaves.push_back(i); }
        }
        while(n > 2)
        {
            n -= leaves.size();
            vector<int> newLeaves;
            for(auto leaf : leaves)
            {
                int adjNode = *adjTable[leaf].begin();
                adjTable[adjNode].erase(leaf);
                if(adjTable[adjNode].size() == 1){ newLeaves.push_back(adjNode); }
            }
            leaves = newLeaves;
        }
        return leaves;
    }
};
```
