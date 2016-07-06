# problem 133. Clone Graph

[题目链接](https://leetcode.com/problems/clone-graph/)

## 方法

直接返回传入的node——作弊失败，原来真的会检查返回的每个节点是否就是原节点。非常给力。

然后就自己做了。还是非常简单的。我们需要一个map来完成旧节点到新节点的映射，这样就能根据旧节点的邻居，连接新节点的新邻居。同时，也需要一个set来保存已经访问过的节点列表。

具体逻辑见代码，更加清晰。

## 代码

迭代版广搜，保证加入到队列中的节点必然已经有新节点创建。

```C++
class Solution {
public:
    UndirectedGraphNode *cloneGraph(UndirectedGraphNode *node) {
        if(nullptr == node){ return nullptr; }
        unordered_map<UndirectedGraphNode *, UndirectedGraphNode *> linkmap;
        unordered_set<UndirectedGraphNode *> hasCreatedSet;
        queue<UndirectedGraphNode*> q;
        UndirectedGraphNode *nodeCopy = new UndirectedGraphNode(node->label);
        linkmap[node] = nodeCopy;
        hasCreatedSet.insert(node);
        q.push(node);
        
        while(!q.empty())
        {
            UndirectedGraphNode *centerNode = q.front();
            q.pop();
            UndirectedGraphNode *centerCopyNode = linkmap[centerNode];
            for( UndirectedGraphNode * neighbor : centerNode->neighbors)
            {
                if(hasCreatedSet.count(neighbor) == 0)
                {
                    // ceate and link and add
                    UndirectedGraphNode *newNode = new UndirectedGraphNode(neighbor->label);
                    linkmap[neighbor] = newNode;
                    hasCreatedSet.insert(neighbor);
                    q.push(neighbor);
                }
                // link copy graph node
                centerCopyNode->neighbors.push_back(linkmap[neighbor]);
            }
        }
        return nodeCopy;
    }
};
```