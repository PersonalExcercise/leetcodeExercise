###problem 290. Word Pattern

[link](https://leetcode.com/problems/word-pattern/)

## 方法

一种直观的想法就是转换为第三方的模式~

这个没有问题，不过看了DISCUZZ上的HOT代码，才发现写得真是NICE啊，当然，不是很容易看懂啦... 最直观的写法是没有问题的....

想到另一种方法——即不使用转换到第三方的方法，而是直接从一个模式转换到另一个模式.

然而我却写错了.... 

之前的逻辑是：

```
make A2B_TRANSLATE_TABLE
IF　A not in A2B_TRANSLATE_TABLE
    Add(A,B)
ELSE
    ASSERT A2B_TRANSLATE_TABLE[A] == B
```

这里出现了错误！因为这里只保证了一个A对应一个B，但是**却没有保证一个B对应一个A** 。上面的逻辑，不能判断出一个B对应多个A的情况。解决办法就是再加一个TABLE（set也行），判断B到A是唯一的（如果用set，就判断没有A到B时，同时set中没有B）

上面的分析中出现了`单射`与`双射`的概念，数学真的无处不在。

## 代码

贴上第二种方法。

```C++
class Solution {
public:
    bool wordPattern(string pattern, string str) {
        istringstream iss(str) ;
        vector<string> pat2word(26) ;
        unordered_set<string> words_set ;
        string word ;
        for(size_t i = 0 ; i < pattern.size() ; ++i)
        {
            if(!iss.good()) return false ;
            iss >> word ;
            char c = pattern[i] ;
            int index = c - 'a' ;
            if(pat2word[index] == "")
            {
                if(words_set.count(word) != 0) return false ;
                pat2word[index] = word ;
                words_set.insert(word) ;
            }
            else if(pat2word[index] != word) return false ;
        }
        if(!iss.eof()) return false ;
        return true ;
    }
};

```

