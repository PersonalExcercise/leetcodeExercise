# problem 92. Reverse Linked List II

[题目链接](https://leetcode.com/problems/reverse-linked-list-ii/)

## 方法

链表操作，应该是比较基础的。做起来还是有点绕，在纸上画画就好。

反序链表的部分，除了常规的反序边表外，一个需要额外考虑的就是反序部分与前后的连接。如果我们不使用dummy头结点的方式，我们就得建一个指针来指向当前指针的前一个节点。因为要想把反序部分连接到原来的链表是，必须要前一个节点的。然后，反序链表之后，反序部分的下一个节点也是可以得到的，我们需要将其保存起来，然后让之前反序部分的头部、现在的尾部指向它，这样就完成了反序部分嵌入到原来的链表中。

这种题，不是智力题，保证一个不急躁的心情就没有问题。

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
class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int m, int n) {
        int count = 0;
        ListNode *ptr = head,
                 *prePtr = nullptr;
        while(++count)
        {
            if(count == m)
            {
                ListNode *newHead = reversePart(ptr, n-m+1);
                if(prePtr == nullptr){ head = newHead; }
                else{ prePtr->next = newHead; }
                break;
            }
            prePtr = ptr;
            ptr = ptr->next;
        }
        return head;
    }
private:
    ListNode* reversePart(ListNode *head, int count)
    {
        ListNode *newHead = nullptr,
                 *ptr = head;
        while(count--)
        {
            ListNode *tmpNext = ptr->next;
            ptr->next = newHead;
            newHead = ptr;
            ptr = tmpNext;
        }
        head->next = ptr; // connect left part
        return newHead;
    }
};
```
