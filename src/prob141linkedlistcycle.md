# problem 141. Linked List Cycle

[题目链接](https://leetcode.com/problems/linked-list-cycle/)

## 方法

判圈问题——经典问题。

一般都是采用[floyd cycle-finding algorithm](https://en.wikipedia.org/wiki/Cycle_detection)算法，即设置两个指针，一个跑得快，一个跑得慢。如果跑得快的遇到结尾，那么说明没有圈；如果最终两个指针在某个时刻相同，则说明有圈。

至于如果有环的话为什么会相遇？应该很简单，一个环形跑道上，两个人速度不一样，那么必然会相遇的。而且，其开始相差的距离，除以他们的速度差，设结果为时间t——如果能够整除，则结果t就是相遇所需要的时间；如果不能整除，那么说明快的将会在ceil(t)时超过慢的。经过一个实际的图示（设长度为4的环，一个速度为1，一个速度为3，两人初始相距为3），发现在整数时刻总是无法相遇！由于我们总是在整数时刻判断，而且二者初始的相距不能确定（随环的不同而不同），所以**我们只能将速度差设为1**（似乎没有看到确切的说明！）。

最后总结一下，我们需要把两个指针速度差设为1（一般就是一个为1，一个为2），然后从起点开始遍历。如果无环，那么O(n)时间结束；如果有环，假设二者进入到圈时相差距离为K，那么追逐时间就是`K / 1 = K` , 因此时间时O(n + K) , 因为 `K < n`, 所以时间复杂度还是O(n).（这段追逐时间的解释来自[141. Linked List Cycle](https://leetcode.com/articles/linked-list-cycle/)） 

空间复杂度为O(1), 相比使用HashSet有优势。


## 代码

```C++
class Solution {
public:
    bool hasCycle(ListNode *head) {
        ListNode *fastPtr = head,
                 *slowPtr = head;
        while(true)
        {
            // move
            if(fastPtr != nullptr && fastPtr->next != nullptr)
            {
                fastPtr = fastPtr->next->next; // 2 step
            }
            else{ return false; } // has end , no cycle
            slowPtr = slowPtr->next;
            if(fastPtr == slowPtr){ return true; }  // two pointer meet 
        }
    }
};
```

## 后记

题解代码的while循环条件是`fast != slow`, 初始时就把fast设为next，不过需要额外判断head与null的关系。

我的代码运行时间是16ms，低于大多的12ms，我不知道是否是这个原因，于是改了下试试，发现时间变为20ms...估计还是LeetCode负载问题。看来一两个if判断，真的不可能有这么大的影响。以后不要再产生这种怀疑了。