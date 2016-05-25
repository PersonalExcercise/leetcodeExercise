###problem 109. Convert Sorted List to Binary Search Tree

[link](https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/)


## 方法

可以直接见兄弟题目：[convert sorted array to BST ](src/prob108convertsortedarray2bst.md) 

关键就是完全遵循中序遍历的顺序来建树。为了知道树的大小，我们需要首先知道节点数，这就要求我们先数一遍链表。

数完链表后，我们按照中序顺序建树，先左，再赋值当前节点，再建立右子树。需要一个全局变量（或者引用）来记录当前待赋值的指针位置。

## 代码

```C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    TreeNode* sortedListToBST(ListNode* head) {
        ListNode *ptr = head ;
        size_t nodeNum = 0 ;
        while(ptr != nullptr)
        {
            ptr = ptr->next ;
            ++nodeNum ;
        }
        ptr = head ;
        return buildBST(0, nodeNum, ptr) ;
    }
private:
    TreeNode* buildBST(size_t startPos , size_t endPos , ListNode *&ptr)
    {
        if(startPos >= endPos) return nullptr ;
        TreeNode *newNode = new TreeNode(0) ; // here `0` is just a placeholder
        size_t midPos = startPos + (endPos - startPos)/2 ;
        newNode->left = buildBST(startPos, midPos, ptr) ;
        newNode->val = ptr->val ; // assign the right value for current position ! 
        ptr = ptr->next ; // move to next value , this will refer to right sub-tree
        newNode->right = buildBST(midPos + 1, endPos, ptr) ;
        return newNode ;
    }
    
    
};
```