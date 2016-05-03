###problem 145. Binary Tree Postorder Traversal

[link](https://leetcode.com/problems/binary-tree-postorder-traversal/)

## 方法

不使用递归方法，就记得有一个关键，但是怎么都想不起来了。又想着给每个节点加个标志位了....

看了[维基百科](https://en.wikipedia.org/wiki/Tree_traversal#Post-order_2)，知道了答案。

首先，后序遍历下，要访问该节点，必然是在从右孩子回来的回溯阶段。

且一个重要的事实是——**如果右孩子不为空，那个访问右孩子后必然访问该节点**。

由此，我们有了一个简单的方法来区分当前回溯阶段是从左边回溯还是右边。

定义一个变量`lastVisitedNode` , 当我们访问一个节点后，就更新该值为刚刚访问的节点。

在回溯时，查看要回溯节点的右孩子——

1. 如果为空，说明刚刚是从左孩子回来，但此时需要直接访问该节点；

2. 如果不为空，且该右孩子就是`lastVisitedNode` , 说明刚刚从右节点回溯回来。此时直接访问该节点；

3. 如果不为空，且该右孩子不是`lastVisitedNode` , 说明从左孩子回来。将下一个遍历目标设为的右孩子。

## 代码

```C++
class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        TreeNode *pos = root ,
                 *lastVisitedNode = nullptr ;
        stack<TreeNode*> s ;
        vector<int> traversalRst ;
        while(!s.empty() || pos != nullptr)
        {
            if(pos != nullptr)
            {
                // step : visit left child
                s.push(pos) ;
                pos = pos->left ;
            }
            else
            {
                // step : backtrace 
                // point : backtrace from left child or right child ?
                // using right child and lastVisitedNode to distinguish
                TreeNode *backtraceNode = s.top() ;
                if(backtraceNode->right == nullptr)
                {
                    // backtrace from left and  [leaves]
                    traversalRst.push_back(backtraceNode->val) ;
                    lastVisitedNode = backtraceNode ;
                    s.pop() ;
                    // leave pos = nullptr , continue to backtrace
                }
                else if(backtraceNode->right == lastVisitedNode)
                {
                    // backtrace from right
                    traversalRst.push_back(backtraceNode->val) ;
                    lastVisitedNode = backtraceNode ;
                    s.pop() ;
                    // same with condition leaves ;
                }
                else
                {
                    // backtrace from left  and [not leaves]
                    pos = backtraceNode->right ;
                }
            }
        }
        return traversalRst ;
    }
};
```


## 后记

代码有冗余，但是更符合上面的分析