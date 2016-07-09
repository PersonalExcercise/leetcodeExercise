# problem 112. Path Sum

[题目链接](https://leetcode.com/problems/path-sum/)

## 方法

用递归方法很简单，什么遍历都可以。

非递归、不用额外数据结构的话，应该只能用后序遍历。哎，迭代后续遍历还是写不利索，长点心吧。

## 代码

后序遍历版

```C++
class Solution {
public:
    bool hasPathSum(TreeNode* root, int sum) {
        stack<TreeNode *> s;
        TreeNode *preVisitedNode = nullptr;
        while(root != nullptr || !s.empty())
        {
            if(root != nullptr)
            {
                if(isLeaf(root) && root->val == sum){ return true; }
                s.push(root);
                sum -= root->val;
                root = root->left;
            }
            else
            {
                TreeNode *parentNode = s.top();
                if(parentNode->right == nullptr || preVisitedNode == parentNode->right)
                {
                    // backtrace from right
                    sum += parentNode->val; 
                    s.pop();
                    preVisitedNode = parentNode;
                }
                else
                {
                    // backtrace from left 
                    root = parentNode->right;
                    preVisitedNode = parentNode->left;
                }
            }
        }
        return false; 
    }
private:
    bool isLeaf(TreeNode *node)
    {
        return node->left == nullptr && node->right == nullptr;
    }
};
```