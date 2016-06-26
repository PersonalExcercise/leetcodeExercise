# problem 3. Longest Substring Without Repeating Characters

[题目链接](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

## 方法

这道题，思路还是比较容易想的。双指针，一个指示开始，一直指示结束，同时用一个hashTable表示字符是否出现过。

我感觉自己都比较吃惊，自己竟然自动想到了hashTable不仅应该存储是否存在，还应该存储上上一次出现的位置。这样，一遇到重复，可以立即把开始指针设为该重复字符上次出现的位置之后的位置，因为这样新的子串必然包含当前字符，因而要不重复，必然从上一个重复位置之后的位置开始。

不过之前犯了一个错误！忘了在更新开始指针时，把hashTable中跳过的那些字符给删去！因为当你设置新的头指针时，那些之前的字符对于新的字符串来说都是没有出现过的，应该把它从hashTable中删去！

然后删去后我发现效率不是很高。然后我又想到，完全可以加一个判断啊！只有hashTable中存储的位置大于等于开始指针的位置，才说明此字符在该新的字符串中出现过，如果是以前的字符，那么其位置必然小于开始指针！

最后，还从题目中明白了 `subsequence`与`substring`的区别，前者只要顺序一致就是子序列，后者则必须是截取的一部分。

## 代码

```C++
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        size_t maxLen = 0 ;
        size_t startPos = 0 ;
        size_t len = s.length(); 
        unordered_map<char, size_t> charLastOccurPos;
        for(size_t pos = 0; pos < len ; ++pos)
        {
            char &c = s[pos]; 
            if(charLastOccurPos.count(c) != 0 && charLastOccurPos[c] >= startPos)
            {
                maxLen = max(maxLen, pos - startPos);
                size_t lastOccurPos = charLastOccurPos[c];
                startPos = lastOccurPos + 1 ; // skip the range which end with c
            }
            charLastOccurPos[c] = pos ; // we should always update the pos !
        }
        maxLen = max(maxLen, len - startPos);
        return maxLen;
    }
};
```

## 后记

上述是使用hashTable、加入判断而非删除键值的代码。然后时间上却毫无改变，都是64ms！

然后我把其中hashTable的count函数换为find函数，时间竟然变成了80ms ... 

然后我又给换成了map，时间变成了100ms, 当时我的内心是崩溃的，说好的小数据时红黑树的map高于hash的unorderd_map呢？都是骗人的...

最后，我用了vector，直接256大小，用char值直接索引. 16ms ，世界清静了。说来说去，还是直接索引最快。

最后的最后，不死心的我改变了unordered_map的hash函数，下面的样子：

```C++
 struct CharHash
    {
        int operator()(char x) const
        {
            return x;
        }
    };
...
unordered_map<char, size_t, CharHash> charLastOccurPos(256);
```
时间变为了56ms，提升有限... 即使hash函数直接返回char值，其效率与直接索引相比，在此任务上，差距仍然是显著的！