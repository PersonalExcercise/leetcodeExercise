###problem 108. Convert Sorted Array to Binary Search Tree

[link](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/)


## 方法

关于二叉查找树，记住一个特性：

**中序遍历二叉查找树，将得到一个递增序列**

根据这个特性，已经题目中“平衡”这一关键，能够想到按照中序遍历的方法来建树，且在平衡数的情况下，左右两边子树节点数相同，则根节点应该是序列的中间元素！

由此递归遍历即可！

刚开始有所思路，不过还是看了题解确定的...不算太难，不过还算巧妙吧。倒是提醒应该关注变换的可逆性——二叉查找树到递增序列，递增序列到二叉查找树；

想起通过最大堆能够排序得到递增序列，那直接递增序列可否得到一个最大堆？这个问题问得没有意义——因为最大堆的构建就是基于数组的，不管这个数组是否有序。


这个题目有个兄弟题目，就是现在递增序列不是数组存的，而是链表！也就是说，不能随机访问了——其实问题不大... 直接按照中序遍历的顺序赋值即可！即先遍历（其实是构建）左孩子，然后赋值当前节点，再遍历（构建）右孩子，递归调用时传递一个引用（或者直观上说，一个全局变量）即可。而数组版本时，我们可以直接拿到当前位置的节点值，因此可以立即赋值当前结点，然后再构建左右子树。想想二者差别不大...

但是，这是看了题解想了一会儿才想明白的...

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
    TreeNode* sortedArrayToBST(vector<int>& nums) {
        return buildBST(nums.cbegin() , nums.cend()) ;
    }
private:
    TreeNode* buildBST(const vector<int>::const_iterator &startIter , const vector<int>::const_iterator &endIter )
    {
        if(startIter >= endIter) return nullptr ;
        auto rootIter = startIter + (endIter - startIter) / 2 ;
        TreeNode *newNode = new TreeNode(*rootIter) ;
        newNode->left = buildBST(startIter , rootIter) ;
        newNode->right = buildBST(rootIter+1 , endIter) ;
        return newNode ;
    }
};
```