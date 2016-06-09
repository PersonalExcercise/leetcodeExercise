# problem 117. Populating Next Right Pointers in Each Node II

[link](https://leetcode.com/problems/populating-next-right-pointers-in-each-node-ii/)

## 方法

有了[Populating next right pointers in each node I](prob116populatingnextrightpointersineachnode.md)的铺垫，这道题就显得没有任何思维上的限制了。

在上道题（完全二叉树）条件上，左孩子的右边必然是右孩子，右孩子的右边必然是下一个节点的左孩子，下一层的首节点必然是当前层首节点的左孩子。

当不是完全二叉树后，只需要把上面的假设全部换为一个find函数即可。find函数也非常直观：对左孩子的下一个节点，首先测试其右孩子是否为空，不为空则指向右孩子，为空时就和找右孩子的下一个节点完全一样。找右孩子的下一个节点，从当前节点的下一个节点依次的找，找到第一个左孩子或者右孩子非空的节点（找到非空的孩子指针就返回该指针）即可。接着依次处理该层下一个节点即可（这里刻意做一些速度提升——因为前面为其左孩子和右孩子连线时已经找到了下一个有非空孩子的节点，可以将上面的节点保留下来，能够避免一些重复判断。不过这点消耗应该是不大的，因为就是两个队孩子节点的非空判断）。找下层第一个节点，从该层第一个节点开始，找到第一个左孩子或右孩子非空的节点，该节点的非空左孩子或右孩子就是下层的第一个节点。

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
        TreeLinkNode *levelFirstNode = root;
        while(levelFirstNode != nullptr)
        {
            TreeLinkNode *ptr = levelFirstNode;
            while(ptr != nullptr)
            {
                if(ptr->left != nullptr)
                {
                    if(ptr->right != nullptr)
                    {
                        ptr->left->next = ptr->right;
                    }
                    else
                    {
                        ptr->left->next = findNextConnected(ptr->next);
                    }
                }
                if(ptr->right != nullptr)
                {
                    ptr->right->next = findNextConnected(ptr->next);
                }
                ptr = ptr->next; // duplicated
            }
            levelFirstNode = findDownLevelFirstNode(levelFirstNode);
        }
    }
private :
    TreeLinkNode *findNextConnected(TreeLinkNode *ptr)
    {
        while(ptr != nullptr)
        {
            if(ptr->left != nullptr){ return ptr->left ;}
            else if(ptr->right != nullptr) { return ptr->right; }
            else { ptr = ptr->next; }
        }
        return nullptr;
    }
    
    TreeLinkNode *findDownLevelFirstNode(TreeLinkNode *ptr)
    {
        while(ptr != nullptr)
        {
            if(ptr->left != nullptr){ return ptr->left; }
            else if(ptr->right != nullptr){ return ptr->right; }
            else ptr = ptr->next;
        }
        return nullptr;
    }
};
```