# problem 129. Sum Root to Leaf Numbers

[题目链接](https://leetcode.com/problems/sum-root-to-leaf-numbers/)

## 方法

这个题与 [path sum](prob112pathsum.md)完全一样。同样，如果递归的做，怎么递归遍历都可以，因为父节点的状态都是可以保留的；如果非递归，又不想用额外的数据结构来存储父节点的信息，那么非递归后续遍历可以满足需求。

## 代码

非递归版本

```C++
class Solution {
public:
    int sumNumbers(TreeNode* root) {
        stack<TreeNode *> s;
        int totalSum = 0,
            curSum = 0;
        TreeNode *lastVisitedNode = nullptr;
        while(root != nullptr || !s.empty())
        {
            if(root != nullptr)
            {
                curSum = curSum * 10 + root->val;
                s.push(root);
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
                    if(isLeaf(parentNode)){ totalSum += curSum; }
                    curSum /= 10;
                    lastVisitedNode = parentNode;
                    s.pop();
                }
            }
        }
        return totalSum;
    }
private:
    bool isLeaf(TreeNode *ptr)
    {
        return ptr->left == nullptr && ptr->right == nullptr;
    }
};
```