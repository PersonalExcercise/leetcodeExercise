# problem 25. Reverse Nodes in k-Group

[题目链接](https://leetcode.com/problems/reverse-nodes-in-k-group/)

## 方法

嗯，说难其实不难，在纸上认真画下就好了。

感觉很不熟练啊，怎么办。

## 代码

```C++
class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        if(head == nullptr || k <= 1){ return head;}
        ListNode *dummyHead = new ListNode(0),
                 *rear = dummyHead;
        rear->next = head;
        while(rear->next)
        {
            ListNode *newHead = reverseKList(rear, k);
            if(newHead != nullptr)
            {
                rear = newHead;
            }
            else
            {
                // left-out nodes
                // reverse back
                reverseKList(rear, k);
                break;
            }
        }
        head = dummyHead->next;
        delete dummyHead;
        return head;
    }
private:
    // return the next dummyHead
    // if the list length is less than k,
    // return nullptr
    ListNode* reverseKList(ListNode *dummyHead, int k)
    {
        ListNode *firstNode = dummyHead->next,
                 *ptr = firstNode;
        while(ptr != nullptr && k--)
        {
            ListNode *tmpNext = ptr->next;
            ptr->next = dummyHead->next;
            dummyHead->next = ptr;
            ptr = tmpNext;
        }
        firstNode->next = ptr;
        return (k > 0 ? nullptr : firstNode);
        
    }
};
```