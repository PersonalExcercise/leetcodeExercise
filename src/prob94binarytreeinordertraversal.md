# problem 94. Binary Tree Inorder Traversal

[link](https://leetcode.com/problems/binary-tree-inorder-traversal/)

## 方法

非常基本的、非常重要的、必须熟练掌握的技能！

非递归中序遍历二叉树，需要结合栈作为回溯，同时记住读取的时机。

中序遍历要求：

先左、再当前、再右边。

所以**读取一个节点的时机是从左边孩子节点回溯时**！

**压栈时机：**

当遍历指针不空，此时该节点还不能被读取，故压栈；

**读取时机**

当遍历指针为空时，说明需要回溯！

此时从栈中去栈顶元素，作为回溯的节点。

问题是——只有在从左边孩子回溯时，我们才访问该回溯节点。那么我们如何辨别当前从哪边回溯呢？

这就是中序遍历和后序遍历的关键了！在后序遍历时，我们使用了一个指针，永远指向上一次访问的节点。通过将上次访问的节点与当前回溯节点的右孩子节点比较。如果是右孩子，说明是从右边回溯，在后序遍历条件下我们就应该读取当前回溯节点。

那么中序遍历呢？其实中序遍历很简单，根本不用这样做——我们知道我们总是先从左孩子回溯，再从右孩子回溯。那么第一次回溯时必然是左孩子回溯的！我们**立即读取该回溯节点，然后将其从栈中弹出！**这点很重要。这使得其与后序遍历不一致，同时使得其变得简单。栈中弹出后，栈顶指向的就是此时回溯节点的父亲节点，当我们再回溯时，必然又是从其左孩子回溯的！由此，**通过立即读取和立即弹栈，我们保证只要是回溯，那么就必然是从左边孩子节点回溯！**

对比：

[非递归后序遍历](prob145BSTpostorder.md)

## 代码

```C++
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> result ;
        stack<TreeNode *> s ;
        TreeNode *ptr = root ;
        while(ptr != nullptr || !s.empty())
        {
            if( ptr != nullptr)
            {
                s.push(ptr) ;
                ptr = ptr->left;
            }
            else
            {
                // backtrace from stack
                ptr = s.top() ;
                // this node is the parent of left-child
                // just read it and pop it (no use for backtrace)!
                s.pop();
                result.push_back(ptr->val);
                ptr = ptr->right ;
            }
        }
        return result ;
    }
};
```

