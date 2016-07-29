# problem 49. Group Anagrams

[题目链接](https://leetcode.com/problems/anagrams/)

## 方法

嗯，比较简单。主要逻辑上，就是判断新的词语之前已经出现的词是不是异构词，如果是的话，就放入到相应的组中。

为了快速比较，可以使用HashMap，不过需要定义自己的Hash函数。注意，该hash函数完成的功能应该是将异构词都隐射到同一个整型上去。所以我们应该忽略字符串的位置信息。当我们两个异构词通过该Hash函数映射到同一个桶中时，HashTable需要做的事是比较这两个key是否是相同的。如果不同，那么就会认为这是出现了冲突，会做相应的处理。如果我们直接使用默认的Equal函数，那么异构词虽然被映射到一个桶中了，但是还是被认为是不同的key，也就不能达到我们的目的。所以我们不仅需要重写Hash函数，还需要重写Equal函数。

总结一下，Hash函数保证异构词能够映射到一个桶；Equal函数保证异构词能够被放进去。

## 代码

```C++
class Solution {
private:
    struct HashObj
    {
        // the hash function ignored the char location.
        size_t operator()(const string &key) const
        {
            size_t hashVal = 0;
            for(const char &c : key)
            {
                hashVal += c*c;
            }
            return hashVal; 
        }
    };
    struct EqualObj
    {
        EqualObj() : cnt(26) {}
        bool operator()(const string &lhs, const string &rhs) const
        {
            fill(cnt.begin(), cnt.end(), 0);
            for(const char &c : lhs){ ++cnt[c-'a']; }
            for(const char &c : rhs){ --cnt[c-'a']; }
            for(int &i : cnt){ if(i != 0){ return false; } }
            return true;
        }
        mutable vector<int> cnt;
    };
public:
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        vector<vector<string>> result;
        unordered_map<string, size_t , HashObj, EqualObj> contMap;
        for(const string &word : strs)
        {
            if(contMap.count(word) > 0)
            {
                size_t contId = contMap[word];
                result[contId].push_back(word);
            }
            else
            {
                result.push_back({ word });
                contMap[word] = result.size() - 1;
            }
        }
        return result;
    }
};
```

## 后记

通过计数的Equal函数速度比不过直接排序比较。这主要还是因为字符串比较短。

话说，用字符串比较打败了99%的用户...我猜关键是我的Map里放的不是vector，而是放的一个索引。这样就少了一个后处理的过程。

值得注意的是，之前我是存的vector的指针！！但是结果Runtime Error了！ 突然想到了这可能是因为vector内存扩展导致的原因，然而我竟然出现错误，认为是内部vector扩增导致的，因此将内部vector给reserve一下，发现还是不多。其实是外部的vector扩增，导致原来指向的内存位置已经被移动了。对vector的理解还是不够深入和灵活啊。

想想自己为什么理解Hash的原理更加深入呢？因为以前总会写Hash，而vector自己没有写过，因此在存指针时第一反应没有考虑这个问题！我觉得还需要加强啊。

总结一下，**不改保存动态扩增中的vector内部元素的地址**。