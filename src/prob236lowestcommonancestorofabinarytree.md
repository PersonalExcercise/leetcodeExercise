# problem 236. Lowest Common Ancestor of a Binary Tree

[题目链接](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/)

## 方法

纠结了一会儿，想到了一个笨方法：使用任何一种树的递归遍历方法，每个遍历过程返回该子树是否包含待查找的节点，只有当第一次发现某个节点的左右子树均包含待查找节点，或者左子树包含且本身节点包含、或者右子树包含且本身节点包含、或者本身节点包含且两个待查找节点相同，则找到了LCA。结束查找过程。

有点笨拙。看了题解的递归版，简直神了。

一上来就判断当前根节点是否是待查节点，如果是，直接返回当前根节点。

否则递归找左子树、右子树的节点；最后判断：如果左右子树都不空，则返回根节点；否则，如果左节点空，则返回右节点；如果右节点空，则返回左节点。

如下：

```Java
public class Solution {
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        if(root == null || root == p || root == q)  return root;
        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        if(left != null && right != null)   return root;
        return left != null ? left : right;
    }
}
```


这是人写出来的吗... 这么简洁... 我决定忽略.. 

这个代码没有问题，精妙之处就在于一上来就对根节点进行了处理！这样，如果根节点就是LCA，那么就直接返回了。不过呢，还是觉得有些晦涩不够直接。

现在越发不知道算法究竟该怎么写了... 越来越懵逼。

## 代码

```C++
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        bool isLCAFind = false;
        TreeNode *lcaNode = nullptr;
        findLCARecursively(root, p, q, isLCAFind, lcaNode);
        return lcaNode;
    }
private:
    bool findLCARecursively(TreeNode *root, TreeNode *p, TreeNode *q, bool &isLCAFind, TreeNode *&lcaNode)
    {
        if(isLCAFind){ return false; } // return value meaningless
        if(root == nullptr){ return false; }
        bool hasLeftFindOne = findLCARecursively(root->left, p, q, isLCAFind, lcaNode);
        bool hasRightFindOne = findLCARecursively(root->right, p, q, isLCAFind, lcaNode);
        bool isCurrentNode = ( p == root || q == root);
        if( (hasLeftFindOne && hasRightFindOne) ||
            (hasLeftFindOne && isCurrentNode) ||
            (hasRightFindOne && isCurrentNode) ||
            (isCurrentNode && p == q) // p == q
          )
        {
            isLCAFind = true;
            lcaNode = root;
            return true;
        }
        return hasLeftFindOne || hasRightFindOne || isCurrentNode;
    }
};
```