# problem 337. House Robber III

[题目链接](https://leetcode.com/problems/house-robber-iii/)

## 方法

嗯，最后一道房屋偷盗者。

现在的限制是，房屋是二叉树排列，一条边上的两个房屋不能同时被盗。这条限制告诉我们，孩子节点与父亲节点间是相互限制的。

所以，我们采用后序遍历即可。这次，再也不好使用状态序列了，直接使用两个变量——偷了此节点的最大值、不偷此节点的最大值来存储状态。然后依然保持约束就ok了。

## 代码

```C++
class Solution {
public:
    int rob(TreeNode* root) {
        int steelMoney, notSteelMoney;
        robRecursively(root, steelMoney, notSteelMoney);
        return max(steelMoney, notSteelMoney);
    }
private:
    void robRecursively(TreeNode *root, int &steelMoney, int &notSteelMoney)
    {
        if(root == nullptr)
        {
            steelMoney = 0;
            notSteelMoney = 0;
            return ;
        }
        int leftChildSteelMoney, leftChildNotSteelMoney,
            rightChildSteelMoney, rightChildNotSteelMoney;
        robRecursively(root->left, leftChildSteelMoney, leftChildNotSteelMoney);
        robRecursively(root->right, rightChildSteelMoney, rightChildNotSteelMoney);
        // steel current
        steelMoney = root->val + leftChildNotSteelMoney + rightChildNotSteelMoney;
        // not steel current
        notSteelMoney = max(leftChildSteelMoney, leftChildNotSteelMoney) + 
                        max(rightChildSteelMoney, rightChildNotSteelMoney);
    }
};
```