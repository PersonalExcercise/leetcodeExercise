# problem 234. Palindrome Linked List

[题目链接](https://leetcode.com/problems/palindrome-linked-list/)

## 方法

找到一半，再反转一半，再依次比较。思想非常直观，能够想到。

稍微纠结一些的地方是如何找后一半的指针。之前想的是遍历一遍，找到count，再确定下半部分的head。这需要遍历一遍半。然后看到DISCUSS上直接用next->next来找到后半的头指针。

之前也看到过这样的方法，但是还是有些疑惑。

```C++
rearDetect = head;
halfHead = head;
1. 
while(rearDetect && rearDetect->next)
{
    halfHead = halfHead->next;
    rearDetect = rearDetect->next->next;
}

2. 
while(rearDetect->next && rearDetect->next->next)
{
    halfHead = halfHead->next;
    rearDetect = rearDetect->next->next;
}

```

经过画图，上述两种方法：

在节点个数为奇数时，第一种将停留在最后一个节点处；第二种也停留在最后一个节点处；此时，两种情况下halfHaed都指向 floor(N / 2) + 1 的节点处（从1计数），奇数下这个节点是中间节点。

在节点个数是偶数时，第一种停留在空节点位置，而第二种停留在倒数第二个位置。此时第一种情况下halfHead指向N / 2 + 1  , 而第二种指向N / 2。

考虑这个问题，奇数时我们应该从中间节点的下一个节点，即floor(N/2)+2开始反转并比较（中间节点不比较）；偶数时应该从 N/2+1 开始比较。第一种需要判断奇偶才能确定右部分的头节点，而第二种只需要总是取halfHead的下一个节点就OK了。此时，halfHead也是右半部分的dummy head。

所以，这道题还是第二种更适合。

## 代码

```C++
class Solution {
public:
    bool isPalindrome(ListNode* head) {
        // learned from https://discuss.leetcode.com/topic/18304/share-my-c-solution-o-n-time-and-o-1-memory
        if(head == nullptr || head->next == nullptr){ return true; }
        
        // find right half head ptr
        ListNode *halfDummyHead = head,
                 *rearDetect = head;
        while(rearDetect->next && rearDetect->next->next)
        {
            halfDummyHead = halfDummyHead->next;
            rearDetect = rearDetect->next->next;
        }
        // halfDummyHead->next is the realy head of right half linked list
        reverseLinkedList(halfDummyHead);
        ListNode *rightPtr = halfDummyHead->next,
                 *leftPtr = head;
        while(rightPtr != nullptr)
        {
            if(leftPtr->val != rightPtr->val){ return false;}
            rightPtr = rightPtr->next;
            leftPtr = leftPtr->next;
        }
        return true;
    }
private:
    void reverseLinkedList(ListNode *dummyHead)
    {
        ListNode *ptr = dummyHead->next;
        dummyHead->next = nullptr;
        while(ptr)
        {
            ListNode *tmp = ptr->next;
            ptr->next = dummyHead->next;
            dummyHead->next = ptr;
            ptr = tmp;
        }
    }
};
```

## 后记

发现有代码是变找右部的首节点，边把前面的部分给反转了... 这样速度又可以提升了啊！！

其次，我们反转节点后更改了输入！有必要再反转回来（当然，我并没有做）。
