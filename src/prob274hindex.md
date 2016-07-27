# problem 274. H-Index

[题目链接](https://leetcode.com/problems/h-index/)

## 方法

学到了学到了！！

竟然还有H-Index这个东西。很有意思啊。

H-Index表示有h篇论文的引用数大于等于h，首先，h的上限是论文数量与最大引用数中的极小值，其次，又能够考察大部分论文的引用状态，而不是只看最高或是最低，感觉实在是很科学啊~ 又要有量、又要又质！这个评价标准很给力！

然而如何实现呢？

自己想到的，根据引用数递增排个序，然后从后往前，最后一个位置h为1，往前依次h递增。如果当前的引用数大于h值，那么继续往前h递增；否则停止，此时h是违背状态，所以真实的h-index就是h-1； 其实就是从后往前数，引用前h的paper中最低引用数是否比h大。就是这个原则。嗯，这有点绕。

然而看了下题解，跟绕了。算是计数排序的思想？自己之前想过，但是关键没有想到——上限是论文数。

我们建一个长度为论文数＋１的数组，每个索引为ｘ的元素，表示引用数为ｘ的论文数，只是最后一个元素例外，表示引用大于等于论文数的论文数量。Ｏ（ｎ）扫一遍论文，建立好数组。然后令h为论文数，对应数组索引，并从后往前；用t表示大于等于该引用数的文章数，初始为0，每次加上当前索引处值。如果t值大于等于h，就说明有h篇文章引用数均大于等于h。

啊，绕得不行了...

## 代码

```C++
class Solution {
public:
    int hIndex(vector<int>& citations) {
        int nrPaper = citations.size();
        vector<int> allHWithCnt(nrPaper + 1);
        for(int citation : citations)
        {
            // if citation >= nrPapaer, just add on nrPaper
            if(citation > nrPaper){citation = nrPaper; }
            ++allHWithCnt[citation];
        }
        int nrPaperGECurCitation = 0;
        for(int i = nrPaper; i >= 0; --i)
        {
            nrPaperGECurCitation += allHWithCnt[i];
            if(nrPaperGECurCitation >= i){ return i; }
        }
        throw runtime_error("no way to run here. BUT LeetCode Compiler is SB.");
        return 0;
    }
};
```