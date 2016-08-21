# problem 21. Merge Two Sorted Lists

[题目链接](https://leetcode.com/problems/merge-two-sorted-lists/)

## 方法

基础题。

不过看了题解的递归版本，挺有意思的。递归永远给人一种不可参透的感觉。这种思想对我而言太难了。

## 代码

```C++
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode * dummyHead = new ListNode(0);
        ListNode *ptr1 = l1,
                 *ptr2 = l2,
                 *mergeHead = dummyHead;
        while(ptr1 != nullptr && ptr2 != nullptr)
        {
            if(ptr1->val <= ptr2->val)
            {
                mergeHead->next = ptr1;
                ptr1 = ptr1->next;
            }
            else
            {
                mergeHead->next = ptr2;
                ptr2 = ptr2->next;
            }
            mergeHead = mergeHead->next;
        }
        while(ptr1 != nullptr)
        {
            mergeHead->next = ptr1;
            ptr1 = ptr1->next;
            mergeHead = mergeHead->next;
        }
        while(ptr2 != nullptr)
        {
            mergeHead->next = ptr2;
            ptr2 = ptr2->next;
            mergeHead = mergeHead->next;
        }
        mergeHead  = dummyHead->next;
        delete dummyHead;
        return mergeHead;
    }
};

```