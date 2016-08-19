# problem 378. Kth Smallest Element in a Sorted Matrix

[题目链接](https://leetcode.com/problems/kth-smallest-element-in-a-sorted-matrix/)

## 方法

一开始直观的想法是多路归并，觉得不太优化。看了题解，发先排着前面的还真是多路归并。只不过他不是这么说的罢了。

用一个最小堆，保存每个数组中当前最小的元素，然后不断出堆并加入出堆元素的下一个元素。这样出去k-1个后，堆顶元素就是待求的元素了。时间复杂度是 O(klogk).

不过似乎还有更好的时间复杂度O(k) ? 见 [O(n) from paper. Yes, O(#rows). ](https://discuss.leetcode.com/topic/53126/o-n-from-paper-yes-o-rows).没有细看...

## 代码

O(k logk)

```C++
struct MatrixIndexInCol
    {
        int row;
        int col;
        
        MatrixIndexInCol(const vector<vector<int>> &matrix, int col)
            : pm(&matrix), col(col), row(0)
        {}
        bool point2Next()
        {
            ++row;
            return row < pm->size();
        }
        int operator()() const { return (*pm)[row][col]; }
        bool operator<(const MatrixIndexInCol &rhs) const
        {
            return this->operator()() < rhs();
        }
        bool operator>(const MatrixIndexInCol &rhs) const
        {
            return rhs.operator<(*this);
        }
        private:
            const vector<vector<int>> *pm;
        
    };
class Solution {
public:
    int kthSmallest(vector<vector<int>>& matrix, int k) {
        size_t edgeLen = matrix.size();
        assert(edgeLen > 0);
        priority_queue<MatrixIndexInCol, std::vector<MatrixIndexInCol>, greater<MatrixIndexInCol>> minHeap;
        for(size_t i = 0; i < edgeLen; ++i){ minHeap.push(MatrixIndexInCol(matrix, i)); }
        while(k > 1)
        {
            MatrixIndexInCol minValIndex = minHeap.top();
            minHeap.pop();
            if(minValIndex.point2Next()){ minHeap.push(minValIndex); }
            --k;
        }
        return minHeap.top()();
    }
};

```

## 后记

再次遇到需要自己定义比较函数的情况。这次又找了半小时BUG——终于明白，如果一个类里有非static的const成员或者引用，那么内的默认拷贝赋值时被删除的！而容器(vector)的`push_back`恰恰用的就是拷贝赋值！

LeetCode上只能显示一行编译错误，遇到STL报错，根本没法找到原因。

此外还有一个问题—— greater<T>还是会使用T的`>`，而不是我以为的`<`，想想也是有道理的——你都用greater了，那还只定义`<`，是不是不太直观啊。但是，那不是我自己得在T里根据`<`写`>`了，那不是繁琐了吗？我不知道有没有更加好的解决方案——就像Java中的接口适配器一样，只重写需要重写的部分，其他用默认操作就好了？