# problem 324. Wiggle Sort II

[题目链接](https://leetcode.com/problems/wiggle-sort-ii/)

## 方法

从这道题开始，连续两天刷题没有进度。这是被这道题弄伤了...

不简单吧，或者说我现在也没有搞清楚。

确定的一点是：

如果先从小往大排好——那么应该把数分为两部分，且如果为奇数，那么左部分是多的那一份！然后，反向放入到结果序列中，即先放左部分最后一个数，接着放右部分最后一个数，再放左部分倒数第二个，放右部分倒数第二个，直到右部分都放完。这时看左部分第一个是否放入了（奇数时多了），如果没有就放入到最后。这样放的结果才能满足wiggle sort的结果。

如果从大往小排序，那么左边部分大，右边小，且同样如果是奇数个元素，小的那部分要多一个元素。然后再正向放即可。然后这样似乎就有一个对应关系，即 0->1 , 1->3, 2->5 , .. 于是就有了virtual index这样一个概念——[O(n)+O(1) after median --- Virtual Indexing](https://leetcode.com/discuss/77133/o-n-o-1-after-median-virtual-indexing) .

如果是O（N），需要用到找中间值的函数，需要用到三色排序（[3路排序](https://en.wikipedia.org/wiki/Dutch_national_flag_problem)）.

## 代码

贴一个自己写的基于排序的方法吧。基于虚拟索引的之间见链接即可。

```C++
class Solution {
public:
    void wiggleSort(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        size_t sz = nums.size();
        vector<int> result(sz);
        int leftHalfLen = (sz + 1) / 2 ,
            rightHalfLen = sz - leftHalfLen;
        int backPos = sz - 1;
        int resultPos = 0;
        while(backPos >= leftHalfLen)
        {
            result[resultPos++] = nums[backPos-rightHalfLen];
            result[resultPos++] = nums[backPos];
            --backPos;
        }
        if(resultPos < sz)
        {
            result[resultPos] = nums[0];
        }
        swap(nums, result);
    }
};
```
## 后记

C++中函数`nth_element`可以O（N）时间内得到第n大的元素。其第一个参数是begin、第二个参数是n+begin的iterator（找完后第n个元素的位置迭代器），第三个参数是end。