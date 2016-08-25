# problem 19. Remove Nth Node From End of List

[题目链接](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

## 方法

链表操作，没有问题！

因为n是倒数的，所以先跑n个来设置一个尾部探测指针。

## 代码

```C++
class Solution {
public:
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        ListNode *dummyHead = new ListNode(0);
        dummyHead->next = head ;
        ListNode *rearDetector = dummyHead;
        while(n--)
        {
            rearDetector = rearDetector->next; // get n ahead
        }
        ListNode *posBefore = dummyHead;
        while(rearDetector->next != nullptr)
        {
            rearDetector = rearDetector->next;
            posBefore = posBefore->next;
        }
        posBefore->next = posBefore->next->next; // remove pos
        head = dummyHead->next;
        delete dummyHead;
        return head;
    }
};
```