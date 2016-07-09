# problem 86. Partition List

[题目链接](https://leetcode.com/problems/partition-list/)

## 方法

划分问题，小于X的放到一边，大于等于X的放到一边。同样，链表问题都有两种方法，一种是加一个dummy root节点，这样真的会方便！且可以减少边界条件。但是就是多了那么一点点内存申请。另一种还是直接用指针指。然而会多很多状态去判断和控制，容易出错。

以前一直用dummy的方法，现在越来越习惯用指针指向了。

这道题，不用dummy，头结点就只能先设为空，这样在加入后续节点时就需要首先判断！其次，在最后将大于等于序列连到小于序列尾部时，也需要判断小于序列是否是空的！这个边界条件一定要想到。

最后，大于等于序列的末尾一定要置为null！非常关键，否则就会有环（如果大于等于序列不为空的情况下！）。

总之，需要判断的条件有很多。

## 代码

不带dummy的版本

```C++
class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        if(nullptr == head){ return nullptr; }
        ListNode *lessListHead = nullptr,
                 *lessListRear = nullptr,
                 *notLessListHead = nullptr,
                 *notLessListRear = nullptr,
                 *ptr = head;
        while(ptr != nullptr)
        {
            if(ptr->val < x)
            {
                // less list
                if(nullptr == lessListRear){ lessListHead = lessListRear = ptr; }
                else{ lessListRear->next = ptr; lessListRear = lessListRear->next; }
            }
            else
            {
                if(nullptr == notLessListRear){ notLessListHead = notLessListRear = ptr; }
                else{ notLessListRear->next = ptr; notLessListRear = ptr; }
            }
            ptr = ptr->next;
             
        }
        // connect not less list to less list rear
        if(lessListHead == nullptr){ lessListHead = notLessListHead; }
        else { lessListRear->next = notLessListHead; }
        // set not less list rear->next = null
        if(nullptr != notLessListRear){ notLessListRear->next = nullptr; }
        return lessListHead;
    }
};

```

使用dummy root的版本：

```C++
class Solution {
public:
    ListNode* partition(ListNode* head, int x) {
        if(nullptr == head){ return nullptr; }
        shared_ptr<ListNode> dummyLessHead(new ListNode(0)) ,
                             dummyNotLessHead(new ListNode(1));
        ListNode *ptr = head,
                 *lessRear = dummyLessHead.get(),
                 *notLessRear = dummyNotLessHead.get();
        while(ptr != nullptr)
        {
            if(ptr->val < x){ lessRear->next = ptr; lessRear = ptr; }
            else{ notLessRear->next = ptr; notLessRear = notLessRear->next; }
            ptr = ptr->next;
        }
        lessRear->next = dummyNotLessHead->next;
        notLessRear->next = nullptr;
        return dummyLessHead->next;
    }
};
```

## 后记

由上可以看到，使用dummy节点看起来代码真的简洁了很多，而且因为在循环中少了分支判断，效果应该会提升一些（大数据量）。然而这并不意味着我们使用dummy root的方式就能够减少边界条件的判断。使用dummy节点，只是因为边界条件下上面的代码仍然是可用的。这并不代表边界条件我们就不用再考虑了。

最后也是提醒自己吧，边界条件现在越来越不重视，总是习惯错了几个case之后才补全。这其实是很大的问题——思考问题不够全面。应该是代码写得稍显急躁了。