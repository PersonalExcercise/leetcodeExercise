# problem 160. Intersection of Two Linked Lists

[题目链接](https://leetcode.com/problems/intersection-of-two-linked-lists/)

## 方法

MD智障啊。真是不服不行。

编程之美上有一个基础的问题，值判断是否相交；然后后续有个问题就是如果需要找第一个相交节点该怎么办？当时我随便一想，觉得应该没有办法，只有用计数了吧。

然后，竟然还有这么巧妙的办法，只需要用两个指针分别走一遍A、走一遍B，当到达第一个相交节点时，他们走的路程必然是相同的，即$len(link A) + len(link B) - len(linkA \cap linkB)$；特别的，如果二者不相交，那么就是都走到尾部，即走了$len(linkA) + len(linkB)$. 来自[My accepted simple and shortest C++ code with comments explaining the algorithm. Any comments or improvements?](https://leetcode.com/discuss/17278/accepted-shortest-explaining-algorithm-comments-improvements)

然后又看到方法，就是分别计数两个链表的长度。然后求出长的链表多出的个数。这样先把长的链表多出的节点先走完（对齐）。然后两个链表一起走，这样只要两个指针相同，那就是第一个相交节点；如果不相交，二者均指向空。与上面相比，走的节点数都是相同的，但是这个理解起来更加直观。 来自[Concise 48ms C++ solution with description and comment on trees](https://leetcode.com/discuss/41125/concise-48ms-solution-with-description-and-comment-on-trees)

智障智障。代码也没有什么好写的，他们写的都特别好...真是变了个变量名。列出第一种方法代码吧。

## 代码

```C++
class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        ListNode *ptrA = headA ,
                 *ptrB = headB ;
        while(ptrA != ptrB)
        {
            ptrA = ( ( ptrA != nullptr ) ? ptrA->next : headB ) ;
            ptrB = ( ( ptrB != nullptr ) ? ptrB->next : headA ) ;
        }
        return ptrA ;
    }
};
```

## 后记

对于第二种方法，DISSCUSS上说是48ms，不过我写了几乎一样的代码，同样只能跑出52ms的速度。与上述代码结果一致。如前面所述，两种方法遍历的节点其实完全一样，区别就是第一种if判断较第二种要稍多。开始我以为是if判断太多使得第二种速度更快，但是自己测了下发现速度相同。不知道是什么原因。可能是LeetCode多加了测试用例？