
===========================================
543. Diameter of Binary Tree
===========================================

二叉树的直径。

关键点
===========================================

很简单，弄清楚定义即可： 
- 直径不一定通过root；
- 直径为左子树最大长度 + 右子树最大长度

代码
===========================================

.. code-block: C++

    /**
    * Definition for a binary tree node.
    * struct TreeNode {
    *     int val;
    *     TreeNode *left;
    *     TreeNode *right;
    *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
    * };
    */

    int recursiveImpl(const TreeNode* root);

    class Solution {
    public:
        int diameterOfBinaryTree(TreeNode* root) {
            return recursiveImpl(root);
        }
    };

    int _recursive(const TreeNode* root, int& globalMax);

    int recursiveImpl(const TreeNode* root) {
        int globalMax = 0;
        _recursive(root, globalMax);
        return globalMax;
    }

    // return max length of left or right length + 1 (self)
    int _recursive(const TreeNode* root, int& m) {
        if (!root) {
            return 0;
        }
        int leftMaxLen = _recursive(root->left, m);
        int rightMaxLen = _recursive(root->right, m);
        auto diameter = leftMaxLen + rightMaxLen;
        m = max(m, diameter);
        return max(leftMaxLen, rightMaxLen) + 1;
    }