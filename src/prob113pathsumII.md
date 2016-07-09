# problem 113. Path Sum II

[题目链接](https://leetcode.com/problems/path-sum-ii/)

## 方法

没什么说的，与[path sum](prob112pathsum.md)一样。

## 代码

```C++
class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int sum) {
        stack<TreeNode *> s;
        vector<int> state;
        vector<vector<int>> result;
        TreeNode *lastVisitedNode = nullptr;
        while(root != nullptr || !s.empty())
        {
            if(root != nullptr)
            {
                s.push(root);
                state.push_back(root->val);
                sum -= root->val;
                if(isLeaf(root) && sum == 0){ result.push_back(state); }
                root = root->left;
            }
            else
            {
                TreeNode *parentNode = s.top();
                if(parentNode->right && parentNode->right != lastVisitedNode)
                {
                    root = parentNode->right;
                }
                else
                {
                    lastVisitedNode = parentNode;
                    sum += parentNode->val;
                    s.pop();
                    state.pop_back();
                }
            }
        }
        return result;
    }
private:
    bool isLeaf(TreeNode *ptr)
    {
        return !ptr->left  && !ptr->right;
    }
};
```