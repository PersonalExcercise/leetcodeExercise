# problem 24. Swap Nodes in Pairs

[题目链接](https://leetcode.com/problems/swap-nodes-in-pairs/)

## 方法

基础的链表操作，在纸上画一下应该就出来了。

## 代码

```C++
class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        ListNode *dummyHead = new ListNode(0),
                 *rear = dummyHead;
        dummyHead->next = head;
        while(rear->next)
        {
            ListNode *p1 = rear->next,
                     *p2 = p1->next;
            if(!p2){ break; }
            rear->next = p2;
            p1->next = p2->next;
            p2->next = p1;
            rear = p1;
        }
        head = dummyHead->next;
        delete dummyHead;
        return head;
    }
};
```