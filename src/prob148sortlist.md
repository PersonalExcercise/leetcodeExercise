# problem 148. Sort List

[题目链接](https://leetcode.com/problems/sort-list/)

## 方法

要在`O(nlgn)`完成排序，对象又是单向链表，应该是优先考虑归并排序（其实感觉快排也是可以的）。

按照LeetCode的说法，常数空间就是指非递归，迭代。所以如果采用归并，那就得用非递归版。

纠结了一会儿，觉得关键得用一个空的头部节点，这样才能方便交换。迭代版就是递归版的逆过程，从每个大小为1的块开始归并的排，注意把merge后的结果与尚未排序的结果连接起来。

逻辑见代码吧，感觉写得挺concise，easy-to-understand , 只是效率不算很高。有时间再好好学习下。

## 代码

```C++
class Solution {
public:
    ListNode* sortList(ListNode* head) {
        if(head == nullptr) { return nullptr; }
        ListNode *dummyHead = new ListNode(0);
        dummyHead->next = head ;
        unsigned stepSize = 1 ;
        while(true)
        {
            ListNode *emptyH1 = dummyHead ; // `empty` means the head is not for visit .
            ListNode *emptyH2 = moveKSteps(dummyHead, stepSize);
            if(emptyH2 == nullptr) { break; } // merged ok
            while(emptyH1->next)
            {
                emptyH1 = merge(emptyH1, emptyH2, stepSize);
                emptyH2 = moveKSteps(emptyH1, stepSize);
                if(emptyH2 == nullptr){ break; } // at rear part , there may be no h2 ! must check !
            }
            stepSize *= 2;
        }
        head = dummyHead->next ;
        dummyHead->next = nullptr ;
        delete dummyHead;
        return head ;
    }
private :
    ListNode *moveKSteps(ListNode *ptr, unsigned nrStep)
    {
        while(ptr != nullptr && nrStep--)
        {
            ptr = ptr->next ;
        }
        return ptr ;
    }
    ListNode* merge(ListNode *emptyH1, ListNode *emptyH2, unsigned stepSize)
    {
        unsigned h1LeftStep = stepSize ,
                 h2LeftStep = stepSize ;
        ListNode *mergeListRear = emptyH1;
        ListNode *ptr1 = emptyH1->next ,
                 *ptr2 = emptyH2->next ;
        while(ptr1 && h1LeftStep && ptr2 && h2LeftStep)
        {
            if(ptr1->val < ptr2->val)
            {
                mergeListRear->next = ptr1 ;
                ptr1 = ptr1->next ;
                --h1LeftStep;
            }
            else
            {
                mergeListRear->next = ptr2;
                ptr2 = ptr2->next ;
                --h2LeftStep;
            }
            mergeListRear = mergeListRear->next ;
        }
        while(ptr1 && h1LeftStep)
        {
            mergeListRear->next = ptr1 ;
            ptr1 = ptr1->next;
            mergeListRear = mergeListRear->next ;
            --h1LeftStep;
        }
        while(ptr2 && h2LeftStep)
        {
            mergeListRear->next = ptr2 ;
            ptr2 = ptr2->next;
            mergeListRear = mergeListRear->next;
            --h2LeftStep;
        }
        // emptyH1 still is the merged list (empty) head
        // and mergeListRear points the rear of merged list 
        // we should connect it to the next part , just assign it's next as ptr2
        mergeListRear->next = ptr2 ;
        // and Now , mergeListRear is the empty start of next part
        return mergeListRear;
    }
    
};
```