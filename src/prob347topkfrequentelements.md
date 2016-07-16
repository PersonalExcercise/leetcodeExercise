# problem 347. Top K Frequent Elements

[题目链接](https://leetcode.com/problems/top-k-frequent-elements/)

## 方法

昨天百度面试遇到这个么个题：

百度每天得到的query有上亿个，我们如果在只有几百MB内存的机器上找到出现TOP K次的query？

昨天有点紧张，思维犹如一潭死水，关键还是准备不周。求TOP K，我也仅仅是知道可以用一个堆来做，然而具体是什么堆也没有记得很清楚。所以昨天就很不确定了，又是外排，又是堆排序，又是MapReduce，反正所有想到的都说了，但是没有整理出一个条理清楚的方案。

今天赶紧来看了这个题。和面试题完全一样，只不过这个就是内存处理，那个还是内存受限。

首先，面试的题更加接近于： 从一个数据流中找到出现TOP K的元素，这个在redis中是有实现的，具体算法是： [Streaming Algorithms: Frequent Items](https://people.eecs.berkeley.edu/~satishr/cs270/sp11/rough-notes/Streaming-two.pdf). 不算精确算法，有误差。

如果精确，可以在昨天的思路的基础上总结一下:

第一轮MapReduce给所有query计数，这个是没有问题的。MapReduce给单词计数是最典型的应用。内存也可以很小，因为shuffle可以外排吧。这样相同的query必然到同一台reduce，且是相邻的，O(1)空间就可以计数完成，并得到 <query, count>这样一个结果。

第二轮MapReduce，用一个reduce，做TOP K的最小堆： 具体来说，保持一个最小堆，根据count排序。一旦堆的大小大于K，那么移除堆顶元素。那么最终堆里剩下的元素，就是把比这K个小的所有元素都丢掉的剩下的，即TOP K了，且可以从小达到排列。

这样的回答，肯定能让面试官满意吧！

## 代码

```C++
class Solution {
public:
    vector<int> topKFrequent(vector<int>& nums, int k) {
        using mapIter = unordered_map<int, size_t>::iterator;
        unordered_map<int,size_t> freqCount; // num -> frequency
        for(int num : nums){ ++freqCount[num]; }
        priority_queue<mapIter, vector<mapIter>, function<bool(mapIter, mapIter)>> topkHeap(
            [](mapIter lhs, mapIter rhs)
            {
                return lhs->second > rhs->second; // build an min-heap!
            },
            vector<mapIter>()
        ); // frequency -> num
        for(mapIter iter = freqCount.begin(); iter != freqCount.end(); ++iter)
        {
            topkHeap.push(iter);
            if(topkHeap.size() > k){ topkHeap.pop(); } // remove the min value currently
        }
        // now heap hold the elements that elements less than them are all removed.
        vector<int> result(k);
        for(int i = k-1; i >= 0; --i)
        {
            mapIter iter = topkHeap.top();
            result[i] = iter->first;
            topkHeap.pop();
        }
        return result;
    }
};
```