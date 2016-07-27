# problem 82. Remove Duplicates from Sorted List II

[题目链接](https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/)

## 方法

链表问题，仔细即可。

感觉这道题还是弄一个dummyHead节点比较统一，少很多判断，于是采用了这种方法。

## 代码

```C++
class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        ListNode *dummyHead = new ListNode(0);
        dummyHead->next = head;
        ListNode *preNode = dummyHead;
        while(preNode->next)
        {
            ListNode *ptr = preNode,
                     *ptr2Delete = nullptr;
            while(ptr->next->next && ptr->next->val == ptr->next->next->val)
            {
                ptr = ptr->next;
                delete ptr2Delete;
                ptr2Delete = ptr; // delay to next Delete
            }
            if(preNode != ptr) // duplicated
            {
                ptr = ptr->next; 
                delete ptr2Delete;
                ptr2Delete = ptr;
                preNode->next = ptr->next;
                delete ptr2Delete; // delete ptr if duplicate, else delete nullptr, ok
            } // has duplicated, remove the last one.
            else { preNode = preNode->next; } // only when no duplicate can move 
        }
        head = dummyHead->next;
        delete dummyHead;
        return head;
    }
};
```