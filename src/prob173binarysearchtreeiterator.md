# problem 173. Binary Search Tree Iterator

[题目链接](https://leetcode.com/problems/binary-search-tree-iterator/)

## 方法

这道题挺有意思的，在二叉查找树的基础上建立一个迭代器，要求`hasnext`和`next`操作要是平均`O(1)`的，且最大空间消耗是`O(h)`,h是树高。

其中`next`返回二叉查找树当前状态下最小的节点值。

这个一想，每次返回当前最小的，能够想到是排序。特别的，中序遍历二叉查找树，能够得到一个递增的序列。而中序遍历，每个节点访问一次，所以每个节点的平均访问时间就是O(1);而中序遍历，在遍历到树的最深处时(叶节点)返回，用栈保存，栈中的元素最多是是根节点到叶节点的整个路径（遍历根节点左子树的情况，到右子树时根节点已经出栈了），即O(h)。因此，这道题就是一个中序遍历。

唯一的不同就是 用迭代器返回，而不是返回一个排序后的数组。

这个也不难，因为我们知道中序遍历，使用栈方法，当当前访问的节点为空时，我们开始回溯，即从栈中拿出一个节点来。此时该节点就是当前为访问二叉查找树中最小的值——即`next`结果。

因此，我们在hasnext中做入栈操作，直到当前节点为空。然后在next中做取出节点并返回的操作。由于next中要取出节点，因为hasnext的判断，就是看栈是否为空。如果为空，则查找树已经遍历完了，否则还可以从栈中取值。

由此代码就好写了。

## 代码

```C++
class BSTIterator {
public:
    BSTIterator(TreeNode *root) {
        pos = root ;
    }

    /** @return whether we have a next smallest number */
    bool hasNext() {
        while(pos != nullptr || !s.empty())
        {
            if(pos != nullptr)
            {
                s.push(pos);
                pos = pos->left ;
            }
            else
            {
                return true ;
            }
        }
        return false;
    }

    /** @return the next smallest number */
    int next() {
        TreeNode *minNode = s.top();
        s.pop();
        pos = minNode->right ;
        return minNode->val;
    }
private :
    stack<TreeNode *> s;
    TreeNode *pos;
};
```

## 后记

时间上又不是最优的，只打败了10+%的用户... 是最普遍的速度。看了HOT，没有太大的差别。他们是在构造函数、next函数中做的遍历，在hasnext中只做判断栈是否为空的情况。

而我的代码，完全就是中序遍历给分拆了下。感觉也还是不错的。反正不管放在哪里，效率都是一样的。

还有看到直接中序遍历拿到所有结果的。只不过他把结果像某道题一样，用原来的指针给串了起来... 很有想法啊。也不是太容易吧，不过那样做可真是不太好。因为这需要在构造函数中完成，耗时太多。而且毁了BST。最后，迭代器嘛，要的就是一步一个啊...