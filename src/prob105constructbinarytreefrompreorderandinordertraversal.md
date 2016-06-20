# problem 105. Construct Binary Tree from Preorder and Inorder Traversal

[题目链接](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)

## 方法

这道题应该是必须要会的吧！之前在编程之美中看到过，这次又遇到，递归的方法会了，但是迭代方法还不是很会。看了DISCUSS中的代码，大致明白了，尝试用更加清晰的代码描述出来。

首先说递归版：

同样从先序遍历递归方法看起：

```C++
visit(root);
visit(root->left);
visit(root->right);
```

以上就是对根节点的递归遍历，我们不递归展开，而是仅从这个结构中可以看出，对于根节点，其先序遍历的结果有如下结构：

```
[根节点值][根节点左边的孩子、孙子等节点][根节点右边的孩子、孙子节点]
```
所以，对根节点的遍历序列，第一个值必然是根的值，接着一个区块是左边子孙的值，最后一个区块是右边子孙的值。

我们拿到先序序列，立即可以构建根节点，但是却无法构建左孩子和右孩子！因为我们不知道左子孙区块和有子孙区块的边界！



## 代码