# problem 106. Construct Binary Tree from Inorder and Postorder Traversal

[题目链接](https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/)

## 方法

时隔[根据先序遍历结果和中序遍历结果构建二叉树](prob105constructbinarytreefrompreorderandinordertraversal.md)已经有10多天了，递归方法依然还很明白。不过迭代法已经有点遗忘了。

当时就觉得递归版没有什么压力，但是迭代版不是很清楚。今天一写，的确如此。递归版很快就完成了，同样根据后序遍历的规律，从最后一个节点找到根节点，然后用根节点的值从中序遍历中确定左右子孙节点的个数，递归建立即可。

然而迭代版却没有什么思路。犹豫间近一个小时，不得不又打开题解，看了一下：[My comprehension of O(n) solution from @hongzhi](https://discuss.leetcode.com/topic/4746/my-comprehension-of-o-n-solution-from-hongzhi).

那一刻，我突然明白了——把后序遍历跟中序遍历反转一下，不就跟先序遍历和中序遍历一样了吗！

看先序遍历： 先根，再左孩子，再右孩子。而后序遍历，先左孩子，再右孩子，再根。反转一下后序遍历的结果，不就是：先根，再右子树，再左子树！反转中序后的结果，不就是先右子树，再根，再左子树吗？

这不就完全是一样的了吗！！！

所以，这样就没有什么难度了。

自己似乎对这种遍历顺序间的关系，一直没有深刻的印象。这可不是一个好事情。需要确切地明白他们之间的关系。这样才能完成这样的题目，同时也简化这一类的题目——因为可以转换为同一个问题啊。

## 代码

递归版

```C++
class Solution {
public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
       int nrNode = postorder.size();
       if(0 == nrNode){ return nullptr; }
       stack<TreeNode*> s;
       int postPos = nrNode - 1,
           inPos = nrNode - 1;
       TreeNode *root = new TreeNode(postorder[postPos]);
       --postPos;
       TreeNode *parentNode = root;
       s.push(root);
       bool nextToHandleLeft = false;
       while(postPos >= 0)
       {
           if(!s.empty() && s.top()->val == inorder[inPos])
           {
               --inPos;
               parentNode = s.top();
               s.pop();
               nextToHandleLeft = true;
           }
           else
           {
               TreeNode *childNode = new TreeNode(postorder[postPos]);
               --postPos;
               if(nextToHandleLeft)
               {
                   parentNode->left = childNode;
                   nextToHandleLeft = false;
               }
               else{ parentNode->right = childNode; }
               s.push(childNode);
               parentNode = childNode;
           }
       }
       return root;
    }
};
```

迭代版

```C++
class Solution {
public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
       int nrNode = postorder.size();
       if(0 == nrNode){ return nullptr; }
       stack<TreeNode*> s;
       int postPos = nrNode - 1,
           inPos = nrNode - 1;
       TreeNode *root = new TreeNode(postorder[postPos]);
       --postPos;
       TreeNode *parentNode = root;
       s.push(root);
       bool nextToHandleLeft = false;
       while(postPos >= 0)
       {
           if(!s.empty() && s.top()->val == inorder[inPos])
           {
               --inPos;
               parentNode = s.top();
               s.pop();
               nextToHandleLeft = true;
           }
           else
           {
               TreeNode *childNode = new TreeNode(postorder[postPos]);
               --postPos;
               if(nextToHandleLeft)
               {
                   parentNode->left = childNode;
                   nextToHandleLeft = false;
               }
               else{ parentNode->right = childNode; }
               s.push(childNode);
               parentNode = childNode;
           }
       }
       return root;
    }
};
```

## 后记

记住，后序遍历反过来真的就是先序遍历啊！
