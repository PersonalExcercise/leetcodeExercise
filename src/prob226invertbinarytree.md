# problem 226. Invert Binary Tree

[题目链接](https://leetcode.com/problems/invert-binary-tree/)

## 方法

>> Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so fuck off.

手动dog...

## 代码

```C++
class Solution {
public:
    TreeNode* invertTree(TreeNode* root) {
        stack<TreeNode*> s;
        TreeNode *ptr = root;
        while(ptr != nullptr || !s.empty())
        {
            if(ptr != nullptr)
            {
                swap(ptr->left, ptr->right);
                s.push(ptr);
                ptr = ptr->right;
            }
            else
            {
                ptr = s.top()->left;
                s.pop();
            }
        }
        return root;
    }
};
```


