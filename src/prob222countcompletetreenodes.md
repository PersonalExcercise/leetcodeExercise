# problem 222. Count Complete Tree Nodes

[题目链接](https://leetcode.com/problems/count-complete-tree-nodes/)

## 方法

这道题，O（n）的想法显然是没有什么意义的。

但是自己也想不出什么更好的办法，看了题解，觉得实在厉害！

首先还是解释下完全二叉树吧。完全二叉树就是，除了最后一层外，其余全部是满的，而且最后一层也是从左往右连续的。

首先，我们求当前完全二叉树的高度，非常简单，O(lg n)。然后，我们再count一下右子树的高度！！这实在太巧妙了！如果右子树的高度恰好是树高-1，那么说明从右子树部分最后一层才开始缺节点，那么就是说左子树是一颗满二叉树。满二叉树节点数是 2^h -1 , 其中h为满二叉树高度（按单节点高度为1， 空节点高度为0计数），再加上根节点，就有 2^h个节点，其中h是树高减1，计数左子树与根节点后，我们递归处理右子树即可；如果右子树高度比树高-1还差1，那么就说明左面就已经缺了（也可能不缺），那么右子树就是树高-2的一棵完全二叉树！！因而我们又可以移动到左子树。

特别地，当遇到叶节点时，此时高度为1，右子树高度为0，此时输入第一种情况，即个数为 2^0 = 1 , 恰恰满足条件。故叶节点也满足上述流程。

最后，真是不服不行。

## 代码

```C++
class Solution {
public:
    int countNodes(TreeNode* root) {
        int height = getCompleteTreeHeight(root);
        int nodeCnt = 0;
        while(root)
        {
            int rightSubTreeHeight = getCompleteTreeHeight(root->right);
            if(rightSubTreeHeight + 1 == height)
            {
                // not-full at right and left is full-binary-tree
                // for full binary tree ( root->left ) , node count is 2^0 + 2^1 + ... + 2^(lh-1) = 2^(lh) - 1, where lh = height - 1 
                // and add the root node （+1） , the total node is 2^(lh) - 1 + 1 = 2^(hight-1) = 1 << (hight - 1)
                // ! What's more , this suit for single node. 
                nodeCnt += 1 << (height - 1) ;
                root = root->right;
            }
            else
            {
                // not-full from left subtree , but right subtree is a full tree with height `rh = height - 1 -1`
                nodeCnt += 1 << (height - 2);
                root = root->left;
            }
            --height;
        }
        return nodeCnt;
    }
private:
    // one node have height 1 , null tree has height 0
    int getCompleteTreeHeight(TreeNode *root)
    {
        int height = 0;
        while(root)
        {
            ++height;
            root = root->left;
        }
        return height;
    }
};
```