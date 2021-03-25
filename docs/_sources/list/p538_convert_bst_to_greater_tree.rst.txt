
===========================================
538. Convert BST to Greater Tree
===========================================

`<https://leetcode-cn.com/problems/convert-bst-to-greater-tree/>`_

将 BST 树 转为 更大的元素的和 的树。即树结构不变，每个树节点的值，
改为比它大的所有元素的和加上自己的值。

关键点
===========================================

关键就是怎们拿到比当前大的元素的和，而且最好还可以递归 + 缓存，这样一次遍历就可以全部计算出来。

这显然需要考虑 BST 的性质。

BST 定义：

1. 左子树，只包含比根节点小的节点
2. 右子树，只包含比根节点大的节点
3. 左、右子树，分别也满足上述要求

显然，按照中序遍历（先右子树，再根，再左子树），得到的结果就是1个完全有序的、降序序列。
在降序序列上计算 Greater Tree, 岂不是简单。

有了这个基础，就可以写代码了。

代码
===========================================

定义一个用于缓存当前比该元素大的所有元素的和的变量。


.. code-block:: C++

    /**
        即 k = k + sum(i for i > k), 关键是拿到 [i for i > k]
        可以从获取 BST 排序值的角度考虑，只要能拿到 BST 的顺序排列结果（降序），那么和可以递归算到。
        而 BST 的降序排列，非常简单，按照右边、当前、左边顺序递归访问即可。而右边访问完时，就是当前节点所有排它前面的值。
        这这个地方做处理刚好。 
        P0 P1 ROOT P2 P3
        1             P3 + 0 => $1
        2          p2 + $1 => $2
        3     ROOT + $2 => $3
        ...
    */
    class Solution {
    public:
        TreeNode* convertBST(TreeNode* root) {
            int current_gt_sum_val = 0;
            recursively_convert_bst(root, current_gt_sum_val);
            return root;
        }

        void recursively_convert_bst(TreeNode* root, int& current_gt_sum_val) {
            if (!root) {
                return;
            }
            recursively_convert_bst(root->right, current_gt_sum_val);
            root->val += current_gt_sum_val;
            current_gt_sum_val = root->val;
            recursively_convert_bst(root->left, current_gt_sum_val);
        }
    };
