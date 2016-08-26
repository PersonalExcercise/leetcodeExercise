# problem 23. Merge k Sorted Lists

[题目链接](https://leetcode.com/problems/merge-k-sorted-lists/)

## 方法

算是之前面试遇到过的问题。因此没什么难的。

用最小堆来保证快速拿到最小的值，并把下一个值加入到候选中。


## 代码

```C++
class Solution {
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        auto greaterFunc = [](ListNode* lhs, ListNode *rhs) -> bool
        {
            if(lhs->val > rhs->val){ return true; }
            else{ return false; }
        };
        priority_queue<ListNode*, vector<ListNode*>, decltype(greaterFunc)> minHeap(greaterFunc);
        for(auto head : lists){ if(head){ minHeap.push(head);} }
        ListNode *dummyHead = new ListNode(0),
                 *mergeRear = dummyHead;
        while(!minHeap.empty())
        {
            ListNode *minNode = minHeap.top();
            minHeap.pop();
            if(minNode->next != nullptr){ minHeap.push(minNode->next); }
            mergeRear->next = minNode;
            mergeRear = mergeRear->next;
        }
        mergeRear->next = nullptr;
        ListNode *head = dummyHead->next;
        delete dummyHead;
        return head;
    }
};
```