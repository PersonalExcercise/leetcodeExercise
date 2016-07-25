# problem 313. Super Ugly Number

[题目链接](https://leetcode.com/problems/super-ugly-number/)

## 方法

超级丑数... 这名字太好听啦~~

丑数二中我们维护了一个2、3、5的指针，那么这道题我们只需要为每个素数维护一个指针就好了。

然后就想到了多路归并，所以可以用堆来优化。

## 代码

```C++
class Solution {
private:
    struct HeapNode
    {
        int uglyNum;
        int primeFactor;
        int ptrIndex;
        vector<int> &uglyList;
        HeapNode(vector<int> &uglyList, int primeFactor, int ptrIndex=0)
            : uglyNum(primeFactor * uglyList[ptrIndex]),
              primeFactor(primeFactor),
              ptrIndex(ptrIndex),
              uglyList(uglyList)
        {}
        void moveToNextPtr()
        {
            ++ptrIndex;
            uglyNum = uglyList[ptrIndex] * primeFactor;
        }
        int getUglyNum() const { return uglyNum; }
        bool operator<(const HeapNode &rhs) // because we are in class, so we'd better move `<` in class
        {
            return this->getUglyNum() < rhs.getUglyNum();
        }
    };
    struct HeapCompare
    {
        bool operator()(const shared_ptr<HeapNode> &lhs, const shared_ptr<HeapNode> &rhs)
        {
            return *rhs < *lhs; // Min Heap
        }
    };
public:
    int nthSuperUglyNumber(int n, vector<int>& primes) {
        vector<int> result{ 1 };
        priority_queue<shared_ptr<HeapNode>, vector<shared_ptr<HeapNode>>, HeapCompare> minHeap;
        for(int prime : primes)
        {
            minHeap.emplace(new HeapNode(result, prime));
        }
        while(result.size() < n)
        {
            shared_ptr<HeapNode> topPtr = minHeap.top();
            minHeap.pop();
            if(topPtr->getUglyNum() > result.back()){ result.push_back(topPtr->getUglyNum()); }
            topPtr->moveToNextPtr();
            minHeap.push(topPtr);
        }
        return result.back();
    }
};
```

## 后记

觉得代码写得很高大上，然后时间竟然花了600+ms，打败了4.9%的用户... 

好像舍弃堆，直接查找都很快的...

本来以为用shared_ptr已经算是优化了，还是不行啊... 我觉得用普通指针也许会快很多呢。

update： 改为普通指针后，变到 300ms ! 我想，如果把比较运算符写得跟简洁一些，会更快吧，不过这样似乎就没什么意思了啊.. 破坏了封装性。

话说，我改为普通指针后，必须将 `operator<` 声明为const的，否则就报错！然而为什么用shared_ptr就不需要呢？ 感觉还是没有学懂啊。