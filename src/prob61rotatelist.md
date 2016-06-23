# problem 61. Rotate List

[题目链接](https://leetcode.com/problems/rotate-list/)

## 方法

相当于循环移位。

个人觉得先获取长度是必需的，因为先要进行模运算，这是循环移位操作所必须的。

接下来就是正常的处理了。还是用父节点来测试，这样好操作next指针。

## 代码

```C++
class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if(head == nullptr){ return nullptr ;}
        size_t listLen = 1 ;
        ListNode *ptr = head ;
        while(ptr->next != nullptr)
        {
            ++listLen;
            ptr = ptr->next;
        }
        k = k % listLen;
        if( k == 0){ return head ;}
        ptr->next = head ; // connect rear
        unsigned nrMoveSteps = listLen - k - 1;
        ListNode *splitPosLeft = head ;
        while(nrMoveSteps--)
        {
            splitPosLeft = splitPosLeft->next;
        }
        head = splitPosLeft->next;
        splitPosLeft->next = nullptr; 
        return head;
    }
};
```