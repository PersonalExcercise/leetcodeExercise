# problem 38. Count and Say

[题目链接](https://leetcode.com/problems/count-and-say/)

## 方法

题目的意思就是，`111`读作`3个1`，写下来就是`31` , `21`这种就是`1个2，1个1`, 写作`1211`, 再举个例子， `11211`, 读作`2个1，1个2，2个1`，写作`211221`. 很直观很简单。

要想把条件判断写简单，那么还是应该在当前位置，判断下一个位置是否是连续的。与之前的某个题是一样的。

## 代码

```C++
class Solution {
public:
    string countAndSay(int n) {
        if(n < 1){ return ""; }
        string sayStr = "1";
        while(--n)
        {
            string nextStr = "";
            int cnt = 0;
            size_t pos = 0,
                   len = sayStr.length();
            while(pos < len)
            {
                ++cnt; // counting
                if(pos + 1 == len || sayStr[pos+1] != sayStr[pos])
                {
                   // saying
                   nextStr += to_string(cnt) + sayStr[pos];
                   cnt = 0;
                }
                ++pos;
            }
            sayStr = nextStr;
        }
        return sayStr;
    }
};
```

## 后记

开始`saying`部分字符串相加是这么写的：

```C++
nextStr += to_string(cnt) + to_string(1, sayStr[pos]);
```

竟然耗时7ms（上面代码耗时4ms），我想说.. 这个真的没什么意义...

还有，我后来把条件判断给翻了过来——

```C++
 if(pos + 1 == len || sayStr[pos+1] != sayStr[pos])
```

即把第二条件放在第一个位置了，我当时想也许第二个命中率更高，效率应该跟好——然而现在我突然想起来，这样一来不就可能越界了吗！！！ 然后没有错误，突然发现，对啊，字符数组的确是多一个字符的啊，最后一个字符是`\0` ! 所以说后面一个判断是毫无意义的咯。