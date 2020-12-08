
===========================================
617. Merge Two Binary Trees
===========================================

合并2个二叉树。

关键点
===========================================

递归来写的话，实在简单。

非递归来做，如果用层序遍历，也还好，但是得操作指针，感觉自己还是有些生疏了，不过也没有必要在这里来做。


另外一个需要注意的点就是，是否总是需要新建 node ？ 自己写的是，但是看题解是没有必要的。

代码
===========================================

.. code-block:: C++

    class Solution {
    public:
        TreeNode* mergeTrees(TreeNode* t1, TreeNode* t2) {
            if (!t1 && !t2) {
                return nullptr;
            }
            TreeNode* newNode = new TreeNode{};
            if (t1 && t2) {
                newNode->val = t1->val + t2->val;
                newNode->left = mergeTrees(t1->left, t2->left);
                newNode->right = mergeTrees(t1->right, t2->right);
            } else if (t1) {
                newNode->val = t1->val;
                newNode->left = t1->left;
                newNode->right = t1->right;
            } else {
                newNode->val = t2->val;
                newNode->left = t2->left;
                newNode->right = t2->right;
            }
            return newNode;
        }
    };
