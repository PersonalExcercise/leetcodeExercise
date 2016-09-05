# problem 235. Lowest Common Ancestor of a Binary Search Tree

[题目链接](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## 方法

对比普通二叉树找两个节点的最低公共父节点，BST因为其查找树的性质而显得更加简单。

二叉查找树满足左边节点小于(等于)父节点，右边节点大于(等于)父节点(关于等于，这里存在一个疑问。总的来说，BST并没有说一定没有重复节点；不过LeetCode上的BST应该是没有重复节点的，中文维基百科上定义的二叉查找树也不允许有重复值（因为BST可以用来做set，这是不允许重复值的）；不过英文维基百科上似乎没有这一条。因此，不能百分百肯定的。如果存在相等节点，那么左右子树任意一遍取等即可)。因此找两个节点的LCA，可以很简单地根据父亲节点的值与两个节点值的大小关系来确定。

如果 p1 < Node < p2 , 则显然Node是他们的公共父节点，细想一下，也必然是最低的（不然左右子树在上一次看来就在一棵子树上了）；如果 p1 , p2 < Node , 那么LCA在左边；如果p1, p2 > Node, 则LCA在右边；同感知器预测标签与真实值的判断一样，我们没有必要区分p1, p2 间究竟是谁大，只需要保证 (p1 - Node) * (Node - p2) > 0 即可保证其满足p1，p2分别是Node的两边；

等于的情况呢？如果等于，则保险起见，我们需要判断Node是否与传入的两个指针是否有一个相等，如果相等当然就是了，如果不相等，那么有一些情况需要考虑：

1. 如果两个指针指向的值都等于Node的值，那么我们需要做的就是判断node的左右两边那边的值等于node的值，那么下一次迭代的Node就是该节点；

2. 如果不都相等，那么比较不相等的值与node的值大小，小就是往左边走；大就是往右边走。

搞得有些复杂，都是因为定义不清导致的！

## 代码

```C++
 /**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if(!root || !p || !q){ return nullptr; }
        TreeNode *node = root;
        while(true)
        {
            int predictVal = (p->val - node->val) * (q->val - node->val);
            if( predictVal < 0 ){ return node; }
            else if( predictVal > 0)
            {
                if(p->val - node->val > 0){ node = node->right; }
                else{ node = node->left; }
            }
            else
            {
                if(node == p || node == q){ return node; }
                else
                {
                    // have duplicated nodes and node is not the lca
                    if(p->val == q->val)
                    {
                        if(node->right && node->right->val == node->val ){ node = node->right; }
                        else{ node = node->left; }
                    }
                    if(p->val < node->val || q->val < node->val){ node = node->left; }
                    else{ node = node->right; }
                }
            }
        }
    }
};
```
