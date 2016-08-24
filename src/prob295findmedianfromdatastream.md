# problem 295. Find Median from Data Stream

[题目链接](https://leetcode.com/problems/find-median-from-data-stream/)

## 方法

最直接的想法，当然是二分插入到数组中；坏处是，每次都需要移动——导致其插入的时间复杂度为O(n);

然后看题解有用BST来做的，我记得之前就有道题是用BST来做（找右边比它小的个数？完蛋，忘了），BST里需要记录两边的个数（这个没有实现，感觉有必要实现以下！）。

最后就是高票的最大堆、最小堆实现：最大堆放小的那一半、最小堆放大的那一半。关键就是怎么才能将小的那一半放入到最大堆汇中？

题解中使用了如下方法：

新添一个数：

1. 放入到最大堆中；

2. 将最大堆的堆顶元素（最大值）放入到最小堆；

3. 如果最大堆size小于最小堆，则把最小堆堆顶（最小值）放到最大堆。

如此就能够做到完美的二分。操作复杂度是2O(lg n) = O(lgn) , 看其他题解，似乎还可以优化上述过程——减少入堆出堆的次数。这个我没有细看了。

最后再是计算中位数的操作：

由上，如果最大堆size大于最小堆，则中位数就是最大堆堆顶；如果相等，则中位数是最大堆与最小堆堆顶的平均。

太巧妙了，想不出来。

## 代码

```C++
class MedianFinder {
public:

    // Adds a number into the data structure.
    void addNum(int num) {
        maxHeap.push(num);
        minHeap.push(maxHeap.top());
        maxHeap.pop();
        if(maxHeap.size() < minHeap.size())
        {
            maxHeap.push(minHeap.top());
            minHeap.pop();
        }
    }

    // Returns the median of current data stream
    double findMedian() {
        if(maxHeap.size() == minHeap.size()){ return (maxHeap.top() + minHeap.top()) / 2.0; }
        else{ return maxHeap.top(); }
    }
    
private:
    priority_queue<int> maxHeap; // storing the smaller part
    priority_queue<int, vector<int>, greater<int>> minHeap; // the bigger part
};
```

## 后记

在定义最大堆时再次遇到了问题：

最开始这么写的：

```C++
priority_queue<int> minHeap(greater<int>(), vector<int>());
```

后来发现，模板参数类型还是需要指定的！因为构造函数的参数类型就是与模板参数类型一致的（使用的模板参数类型），不指定模板参数类型，就相当于传入了错误的参数！

改成下面这样，还是报错：

```C++
priority_queue<int, vector<int>, greater<int>> minHeap(greater<int>(), vector<int>());
```

网上搜了一下，在爆栈上看了到答案： 上述其实声明的是一个函数，这个函数返回类型是 `priority_queue<int, vector<int>, greater<int>>` , 参数是 `greater<int>()` (被解释为函数了！参数为空，返回`greater<int>`的对象) 和 ` vector<int>()` (同样被解释为函数了！).天呐，简直要疯了... 还能这样啊。

这就是C++的 `Most Vexing Parse`问题，总的来说，语法分析歧义啊！

更加详细的分析，见[Most Vexing Parse of C++](http://memeda.github.io/%E6%8A%80%E6%9C%AF/2016/08/22/CPP%E8%AF%AD%E6%B3%95%E5%88%86%E6%9E%90%E6%AD%A7%E4%B9%89.html)