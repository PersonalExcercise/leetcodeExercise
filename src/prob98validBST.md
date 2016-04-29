###problem 98 Validate Binary Search Tree

[link](https://leetcode.com/problems/validate-binary-search-tree/)


## 方法

一颗二叉查找树BST（），只需按照中序遍历一遍，如果其key构成一个递增序列，那么就满足BST。

BST的定义：

1. 空

2. 或者左边孩子key小于父节点；右边孩子key大于父节点；且以左右孩子为根的子树同样满足此性质。

## 代码

```C++
class Solution {
public:
    bool isValidBST(TreeNode* root) {
        if(root == nullptr) return true ;
        stack<TreeNode*> s ;
        TreeNode *pos = root ;
        long long min_val = 0 ;
        // find min 
        while(pos->left != nullptr) pos = pos->left ;
        min_val = pos->val ;
        long long pre_val = min_val - 1 ;
        pos = root ;
        while(!s.empty() ||  pos != nullptr)
        {
            if(pos == nullptr)
            {
                TreeNode *cur_pos = s.top() ;
                s.pop() ;
                int cur_val = cur_pos->val ;
                if(pre_val >= cur_val) return false ;
                pre_val = cur_val ;
                pos = cur_pos->right ;
            }
            else 
            {
                s.push(pos) ;
                pos = pos->left ;
            }
        }
        return true ;
    }
};
```

## 后记


有坑。如果Leetcode没有错例显示，那么这道题估计要DEBUG好久。

有一个case恰好是 -2^31 , 即int下最小整数，而上面的代码中用`- 1`来保证第一次验证能够通过。如果`prev_val`为int类型，-1就会下溢，变为2^31 -1，这时第一次验证就通不过了！

所以需要使用long long来存储.

当然，这个解决得很trick了。真正的解决还是要记录是否是第一个值，如果是直接跳过，否则才检查是否满足BST。

这里为了效率，就只这样了。