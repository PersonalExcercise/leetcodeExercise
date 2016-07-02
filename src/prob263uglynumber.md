# problem 263. Ugly Number

[题目链接](https://leetcode.com/problems/ugly-number/)

## 方法

丑数，就是素因子只有2,3,5的数。特别的，1也是丑数。

不知道为什么叫这个名字... 搜了一下竟然全是题解，也是服——能不能有好奇心了...

嗯，想清楚还是很简单的，这可是个EASY题。既然是素因子只有2、3、5，那就不断除这几个数吧，只要最后结果为1，说明就是了。

## 代码

```C++
class Solution {
public:
    bool isUgly(int num) {
        if(num <= 0){ return false; }
        while(num % 2 == 0){ num /= 2; }
        while(num % 3 == 0){ num /= 3; }
        while(num % 5 == 0){ num /= 5; }
        if(num == 1){ return true; }
        return false;
    }
};
```

## 后记

刷了100道，终于发现了——StefanPochmann就是LeetCode大V啊...