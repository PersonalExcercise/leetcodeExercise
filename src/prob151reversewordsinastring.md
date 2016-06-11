# problem 151. Reverse Words in a String

[题目链接](https://leetcode.com/problems/reverse-words-in-a-string/)

## 方法

题目要求O(1)空间，不知怎么，立即想到了《编程之美》上“将一个数循环移位k位”的题目。如此可以满足时间为O(n),且空间复杂度为O(1).

具体步骤

1. 将字符串中每个单词单独反转

2. 整个字符串反转

由此就得到了反转字符串，其中每个单词都是正序，但是单词至今是一个反序过程。这是因为每个单词都反转了两次，所谓负负得正，所以单词正序，而单词之间只反转了一次，所以保证了反序。

上述了解过背景的话还是很简单的。

不过题目对原始字符串有额外的说明：

1. 单词用空格隔开

2. 首尾可能有单词

3. 单词间可能包含多个空格

要求最终的结果不仅反序，而且是trimed且单词间仅有一个空格。

怎么办？我想着干脆用双指针归一化算了。

一个指针指向归一化起始，一个指针为遍历指针。

1. 初始时遍历指针、归一化指针都指向字符串首

2. 随后，遍历指针循环（来跳过空格）递增直到遇到第一个非空格字符，为单词首；接着循环直到结尾（前一个循环其实也需要限制非结尾这一条件）或者或者遇到第一个空格，为单词尾后位置。

3. 将找到的单词逐个字符从前到后拷贝。（开始想把字符拷贝与反转结合起来，后来发现在O(1)下不可能）

4. 反转拷贝后的单词

5. 归一化指针产生一个空格，并指向下一个位置。

6. 回2，开始下次循环, 直到遍历指针指向末尾

7. 去除最后一个空格(这里有两种情况，一种是原始字符串完全是归一化的，那么归一化指针指向尾后位置，前一个位置无空格；一种情况是归一化指向空格之后的位置，前一个位置是空格；两种情况可以统一处理，用一个while循环即可。不过上面产生空格就需要判断了——不能在其指向尾后位置时还产生空格。详细见代码吧)

## 代码

```C++
class Solution {
public:
    void reverseWords(string &s) {
        const char Delimiter = ' ';
        string::iterator targetIter = s.begin() ,
                         iter = s.begin();
        while(iter < s.end())
        {
            // find start position of word
            while(iter != s.end() && *iter == Delimiter){ ++iter ;}
            auto wordStartIter = iter;
            // find end position of word
            while(iter != s.end() && *iter != Delimiter){ ++iter ;}
            auto wordEndIter = iter;
            // move
            moveWordInPlace(wordStartIter, wordEndIter, targetIter);
            auto targetEndIter = targetIter + (wordEndIter - wordStartIter);
            // reverse
            reverseInPlace(targetIter, targetEndIter);
            // add space
            if(targetEndIter < s.end())
            {
                *targetEndIter = Delimiter; 
                targetIter = targetEndIter + 1;
            }
            else
            {
                targetIter = s.end(); // next will break ;
            }
        }
        // after break , the targetIter is the `s.end()` or `point to the place where next word will be filled`
        // for condition 1 , no pace before targetIter
        // for condition 2 , there are 1 space .
        // we can handle it by using whill loop
        --targetIter;
        while(targetIter >= s.begin() && *targetIter == Delimiter){ --targetIter; }
        reverseInPlace(s.begin(),targetIter+1); // targetIter is the end of the last character , but range shoule be the next position
        s.erase(targetIter+1,s.end());
    }
private:
    void moveWordInPlace(string::const_iterator srcStartIter, string::const_iterator srcEndIter,
                         string::iterator tgtStartIter)
    {
        while(srcStartIter != srcEndIter)
        {
            *tgtStartIter++ = *srcStartIter ; // equals to : *(tgtStartIter++) = *srcStartIter
            ++srcStartIter;
        }
    }
    void reverseInPlace(string::iterator startIter, string::iterator endIter)
    {
        using std::swap;
        while(startIter < endIter)
        {
            swap(*startIter++, *--endIter);
        }
    }
};

```

## 后记

花了28ms，竟然只打败了3.12%的用户... 看了DISCUSS，发现他们竟然用了`istringstream`!

当时我就懵了... 我怎么没有想到呢，这个来处理连续多空格、首尾空格应该很方便（不过我不确定其处理首尾空格的具体结果，待测试）。不过一想——这样你就得额外空间了啊（至少需要一个够着istringstream的空间，里面存着一个字符串buf）。不算是很符合题意吧，当然其实题意里只是说C语言使用者可以尝试O(1)的空间...

然而之后我又看到有java 3ms 就过的，同样原地反转... 而且我看分布，Java整体时间的确快与C++啊...

这是为什么呢..
