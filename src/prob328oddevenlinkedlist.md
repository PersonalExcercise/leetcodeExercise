# problem 328. Odd Even Linked List

[题目链接](https://leetcode.com/problems/odd-even-linked-list/)

## 方法

大水题...

## 代码

```C++
class Solution {
public:
    ListNode* oddEvenList(ListNode* head) {
        if(head == nullptr || head->next == nullptr){ return head; }
        ListNode *oddHead = head,
                 *oddRear = head,
                 *evenHead = head->next,
                 *evenRear = evenHead,
                 *ptr = evenHead->next;
        while(ptr != nullptr)
        {
            oddRear->next = ptr;
            oddRear = oddRear->next;
            ptr = ptr->next;
            if(ptr != nullptr)
            {
                evenRear->next = ptr;
                evenRear = evenRear->next;
                ptr = ptr->next;
            }
        }
        oddRear->next = evenHead;
        evenRear->next = nullptr;
        return oddHead;
    }
};
```