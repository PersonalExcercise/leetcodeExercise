# problem 142. Linked List Cycle II

[题目链接](https://leetcode.com/problems/linked-list-cycle-ii/)

## 方法

在确认有圈后，如何找到圈的起点呢？

其实仔细分析下也比较简单的——经过[之前的分析](prob141linkedlistcycle.md)，我们可以确定, 追逐距离不超过一圈。所以，在二者相遇的时刻，我们有以下等式：

```C++
V·t  = S + K  // V 是速度，t是总时间；S是非环的长度，K是环中从起点到相遇点的距离；
2V·t = S + K + L // L是环的周长
```
2式减1式，易得（哈哈） ： `Vt = L` , 带入1式，有 `L = S + K` , 这个结果说明了什么？ 赶紧在图上看看，这不就是说非环的长度，等于从相遇点到起点的半环长度吗！ 

我们找到了一段以交点为终点的两段路，且两段路已知起点、距离又相同。那么——只要分别从两段路的起点开始走，速度保持相同（速度同样要为1），那么相遇时刻就是交点了！也即是环（圈）的起点。

## 代码

```C++
class Solution {
public:
    ListNode *detectCycle(ListNode *head) {
        ListNode *fastPtr = head,
                 *slowPtr = head;
        while(true)
        {
            if(fastPtr == nullptr || fastPtr->next == nullptr){ return nullptr; }
            fastPtr = fastPtr->next->next;
            slowPtr = slowPtr->next;
            if(fastPtr == slowPtr){ break; }
        }
        // move slow ptr to begin
        slowPtr = head;
        while(slowPtr != fastPtr)
        {
            // all move with speed 1
            slowPtr = slowPtr->next;
            fastPtr = fastPtr->next;
        }
        return slowPtr;
    }
};
```