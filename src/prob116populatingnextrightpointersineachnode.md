# problem 116. Populating Next Right Pointers in Each Node

[link](https://leetcode.com/problems/populating-next-right-pointers-in-each-node/)

## 方法

看到题，想了一下，得用层序遍历！

做法是：

1. 用两个vector，第一个vector用来依次存当前层的父节点，另一个vector用来依次存下一层的孩子节点。

2. 初始时将root节点放入第一个vector，然后只要第一个vector不空，则循环：

3. 对第一个vector中每个节点，把非空孩子节点依次放入第二个vector中；

4. 放完后，连接第二个vector中的节点，很简单地连接。

5. 最后交换vector1和vector2（为下次循环准备），开始下次循环。

然而，却要求用常量空间！也就是不能用上述方法...

然后我就懵了。于是我看了DISCUZZ，结果看了一眼代码，没看细致就觉得我懂了...

这是什么原因呢？自己给自己设限了吗？

我们可以**用next指针来辅助做层序遍历**啊！！

1. 每次取每层的第一个节点，用来开始本层的访问以及下层的进入。

2. 每层的访问，设一个访问指针，初始为每层第一个节点，只要访问指针非空，就把访问指针的左孩子的next连上该指针的右孩子；如果访问指针next非空，就把右孩子的next指针连上next节点的左孩子。然后将访问指针设为next指针。

3. 进入下一层：去下层第一个节点等于本层第一个节点的左孩子。此时下层的next指针链已经由上层构建好了！

4. 如果本层第一个节点为空，或者本层第一个节点无左孩子（此时无需构建下层，而本层已经构建完成），那么退出循环。

总结来说，就是用上层构建好下层，通过next指针来完成层序的访问。

想想还是很巧妙的。

可惜没有想出来啊... 感觉自己没有去尝试，只围绕这一个点思考... 这个题这么形象，理论上可以做到的啊.. 最近还是精神状态不太好啊(担心找工作的事呢)

## 代码

```C++
/**
 * Definition for binary tree with next pointer.
 * struct TreeLinkNode {
 *  int val;
 *  TreeLinkNode *left, *right, *next;
 *  TreeLinkNode(int x) : val(x), left(NULL), right(NULL), next(NULL) {}
 * };
 */
class Solution {
public:
    void connect(TreeLinkNode *root) {
        TreeLinkNode * firstNodeOfLevel = root ;
        while(firstNodeOfLevel && firstNodeOfLevel->left)
        {
            
            TreeLinkNode * traversalPtr = firstNodeOfLevel;
            while(traversalPtr)
            {
                // link left -> right
                traversalPtr->left->next = traversalPtr->right ;
                TreeLinkNode *next = traversalPtr->next ;
                if(next)
                {
                    // link right -> left_of_next
                    traversalPtr->right->next = next->left;
                }
                traversalPtr = next ;
            }
            firstNodeOfLevel = firstNodeOfLevel->left;
        }
    }
};
```
## 后记

不明白我的代码为什么这么慢呢... 看了下他们确切的实现，也是如此啊.. 

另外，使用此方法递归的实现：

1. 对每个节点构建下层连接：构建好左孩子到右孩子的连接；右孩子到next节点左孩子的连接。

2. 递归构建左孩子、右孩子的下层连接。

这种情况下，与深度优先遍历就很相似了。

所以说，这道题的TAG有深度优先遍历，也是没有问题的。只不过，深度优先可都是递归啊...就不是常量了。
