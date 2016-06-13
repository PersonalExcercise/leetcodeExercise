# problem 114. Flatten Binary Tree to Linked List

[题目链接](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/)

## 方法

要把一棵二叉树变为先序遍历结果的链表，而且是由右子树展开。

首先，很直观的想法就是先序遍历，同时记录先序遍历中上一个非空节点，这样只需要访问当前节点时，使上一个节点的右子树指向当前节点即可。但是需要注意的是，常规先序遍历先遍历左子树，所以把前一个节点（父节点）的右孩子设为当前节点后，父节点的右孩子就没有了（还没有被访问呢！）。所以一个很简单的想法就是**遍历子节点前交换左右孩子的指针**。这样交换后，先遍历右子树（即未交换时的左子树，满足先序遍历），然后下个过程将设置该节点的右子树值，而该右子树已经遍历过了，所以设置后没有什么问题！

以下是递归版本的代码：

```C++
void doFlatten(TreeNode *curNode, TreeNode * &parentNode)
{
    using std::swap;
    if(curNode == nullptr) { return ;}
    swap(curNode->left, curNode->right);
    if(parentNode !=nullptr) { parentNode->right = curNode; }
    parentNode = curNode;
    doFlatten(curNode->right, parentNode);
    doFlatten(curNode->left, parentNode);
    curNode->left = nullptr;
}
```

现在一想，在递归版本，根本没有必要交换左右子树，直接用一个临时变量存储当前节点，在遍历完成后再分别设置右孩子为该临时值，左孩子为空即可。更加直观简单了...不过用非递归的话，似乎就没有那么方便了，交换似乎是必须的？

递归版本的代码10ms运行完成。为非递归版本，能够8ms跑完（见代码部分）。

上述已经算是比较圆满解决了，但是看题解发现一种有点巧妙的想法！

如果我们通过先序遍历，必须记录先序遍历下上一个非空节点，同时为了避免覆盖右子树，还需要交换（或者只需要一个临时指针）。如果我们反序遍历顺序：

先序遍历是： 根 -> 左 -> 右 ， 在访问根节点时将上个节点的右孩子设为当前根的值；
如果我们遍历顺序变为： 右 -> 左 -> 根， 那么我们得到的结果与先序遍历的结果是相反的！这样我们就反过来了，不是保存上一个访问的节点，而是保存先序遍历下一个将遇到的节点（此种遍历下上一个访问的节点）。

嗯，这么一想也跟先序是一样的，只是有些惊奇罢了。想想一点也不高级...不过也学到了，就是 先右子树，再左子树，最后根节点，得到预先序遍历相反的序列。


## 代码

非递归版本。感觉比递归更加简洁：

```C++
class Solution {
public:
    void flatten(TreeNode* root) {
        stack<TreeNode *> s;
        TreeNode *ptr = root ;
        TreeNode *parentNode = nullptr;
        while(ptr != nullptr || !s.empty())
        {
            if(ptr != nullptr)
            {
                swap(ptr->left, ptr->right);
                if(parentNode != nullptr){ parentNode->right = ptr; }
                s.push(ptr);
                parentNode = ptr;
                ptr = ptr->right;
            }
            else
            {
                // backtracing
                ptr = s.top();
                s.pop();
                TreeNode *tmp = ptr->left;
                ptr->left = nullptr;
                ptr = tmp;
            }
        }
    }
};
```

## 问题

不能`delete(free)`这个TreeNode节点！之前做递归时，我不想在递归中加入判断上一个节点是否为空的情况，就给加了一个dummy根节点，最后再释放掉，结果就报RE错误了！试了半天，发现把delete一行删除就好使了... 换成malloc+free也同样报错。在释放前把左右指针设为空也不好使... 实在不知道是怎么回事.难道还没有生成析构函数——难道析构是private的？不能吧，这样编译都过不了啊... orz，不明白。



