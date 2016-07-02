# problem 103. Binary Tree Zigzag Level Order Traversal

[题目链接](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/)

## 方法

看了题解。嗯，看完还是很简单的——所谓Z型，也不用后处理反转，直接在存储时，如果判断是反序过程，则反序放入即可。

层序遍历，使用队列，首先将非空父节点压入。然后开始以下循环，知道队列为空；

1. 获取队列中元素个数。则本次遍历的结果数就是元素数。

2. 依次从队列出队，访问该节点的值，将节点的非空孩子节点入队。本层节点遍历完后，开始下次迭代。

关键就是，每次循环开始，队列中就是整个一层的节点！先记录本层的节点数，这样push也不耽误。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
        queue<TreeNode*> parentNodes;
        vector<vector<int>> result;
        if(root == nullptr){ return result; }
        parentNodes.push(root);
        bool backPush = false;
        while(!parentNodes.empty())
        {
            size_t nrParentNode = parentNodes.size();
            vector<int> levelResult(nrParentNode);
            for(size_t i = 0; i < nrParentNode; ++i)
            {
                TreeNode* &node = parentNodes.front();
                if(node->left){ parentNodes.push(node->left); }
                if(node->right){ parentNodes.push(node->right); }
                if(backPush){ levelResult[nrParentNode-i-1] = node->val; }
                else{ levelResult[i] = node->val; }
                parentNodes.pop();
            }
            result.push_back(levelResult);
            backPush = !backPush;
        }
        return result;
    }
};
```
## 后记

C++中，使用push来入队，使用front来读取出队元素，使用pop()来出队。此外，还有back来读取刚刚入队的元素。

另，API中把出队元素称为next element;

