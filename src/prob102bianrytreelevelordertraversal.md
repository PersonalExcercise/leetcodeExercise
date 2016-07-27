# problem 102. Binary Tree Level Order Traversal

[题目链接](https://leetcode.com/problems/binary-tree-level-order-traversal/)

## 方法

很简单，基础的层序遍历。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> levelOrder(TreeNode* root) {
        if(root == nullptr){ return {}; }
        vector<vector<int>> result;
        queue<TreeNode *> q;
        q.push(root);
        while(!q.empty())
        {
            size_t curLevelSize = q.size();
            vector<int> levelVal(curLevelSize);
            for(size_t i = 0; i < curLevelSize; ++i)
            {
                TreeNode *ptr = q.front();
                q.pop();
                levelVal[i] = ptr->val;
                if(ptr->left){ q.push(ptr->left); }
                if(ptr->right){ q.push(ptr->right); }
            }
            result.push_back(std::move(levelVal));
        }
        return result;
    }
};
```