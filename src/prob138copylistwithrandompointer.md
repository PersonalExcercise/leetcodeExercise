# problem 138. Copy List with Random Pointer

[题目链接](https://leetcode.com/problems/copy-list-with-random-pointer/)

## 方法

首先要看清楚题，random指针是可以为null的！这是出现错误的第一个原因。

接着，就可以同[clone graph](prob133clonegraph.md)一样，使用HashTable做一个旧指针到新指针的映射。这需要O(n)的额外空间，遍历两遍。

幸好因为第一个原因错误了，所以我才去看了题解。真是学习了。我们可以利用这个next指针来找到克隆后对应的random指针啊！就像当初利用next指针完成层序遍历一样！

具体做法是，我们每次克隆一个节点后，把该节点放在原始节点的后面，相当于插入嘛。这样我们就可以立即获得克隆的random指针了。非常简单，非常聪明的方法!

## 代码

```C++
class Solution {
public:
    RandomListNode *copyRandomList(RandomListNode *head) {
       if(head ==  nullptr){ return nullptr; }
       // 1. make a copy following original node(so we can use ptr of next !)
       RandomListNode *ptr = head;
       while(ptr != nullptr)
       {
           RandomListNode *copyNode = new RandomListNode(ptr->label);
           copyNode->next = ptr->next;
           ptr->next = copyNode;
           ptr = copyNode->next;
       }
       // 2. build random
       ptr = head;
       while(ptr != nullptr)
       {
           RandomListNode *copyNode = ptr->next,
                          *originRandomNode = ptr->random,
                          *copyRandomNode = originRandomNode ? originRandomNode->next : nullptr;
           copyNode->random = copyRandomNode;
           ptr = copyNode->next;
       }
       // 3. restore the original list and extract the copy node
       RandomListNode *copyHead = head->next,
                      *copyPreRear = copyHead;
       ptr = head;
       while(ptr->next->next != nullptr)
       {
           ptr->next = ptr->next->next;
           ptr = ptr->next;
           copyPreRear->next = ptr->next;
           copyPreRear = copyPreRear->next;
       }
       ptr->next = nullptr; // when exit, ptr->next hasn't been correct
       return copyHead;
    }
};
```

## 后记

写代码时最后一个条件判断出错了！即

```C++
while(ptr->next->next != nullptr)
```

写的是`while(ptr != nullptr && ptr->next->next != nullptr)`, 实际上第一个判断毫无意义。因为ptr初始时必然不空，那么后续就只有第二个条件有用了！

这样也导致了最后一个位置的原始指针的next没有设置为空，所以循环借宿后需要后处理！

这也是一次错误的原因。