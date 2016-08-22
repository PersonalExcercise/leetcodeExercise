# problem 144. Binary Tree Preorder Traversal

[题目链接](https://leetcode.com/problems/binary-tree-preorder-traversal/)

## 方法

标准的方法，按照维基百科上的写法完成。先压右子树，再压左子树即可。

## 代码

```C++
class Solution {
public:
    vector<int> preorderTraversal(TreeNode* root) {
        vector<int> result;
        stack<TreeNode *> s;
        if(root){ s.push(root); }
        while(!s.empty())
        {
            TreeNode *node = s.top();
            s.pop();
            // visit
            result.push_back(node->val); 
            // right first so that it will be visited after left
            if(node->right){ s.push(node->right); }
            // left
            if(node->left){ s.push(node->left); }
        }
        return result;
    }
};
```