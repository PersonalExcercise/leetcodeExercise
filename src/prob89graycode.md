# problem 89. Gray Code

[link](https://leetcode.com/problems/gray-code/)

## 方法

[GrayCode](https://en.wikipedia.org/wiki/Gray_code)，[格雷码](https://zh.wikipedia.org/wiki/%E6%A0%BC%E9%9B%B7%E7%A0%81).

之前看题都没有看明白...

`two successive values differ in only one bit`的意思是两个连续的值只有一位不同。比如**用格雷码表示的**1和2、2和3、3和4其格雷码均只差一位。

然后题目给出了示例：

```XML
00 - 0
01 - 1
11 - 3
10 - 2
```

后面的题目说上述给出的格雷码不是唯一的，经过查维基百科得知，上述的格雷码称为**镜像格雷码(Binary-Reflected Gray Code, BRGC)**。

由其名，可知其得到可以通过如下递归方法：

1. 一直(n-1)位的格雷码，`n >= 1`
2. 则n位的格雷码通过如下方法得到：镜像(n-1)位的格雷码得到（镜像就是指反序复制原格雷码），再给原始格雷码添加`0`高位，为镜像格雷码添加`1`高位，然后添加高位后的原格雷码和镜像格雷码组合起来，得到n位的格雷码。


## 代码

```C++
class Solution {
public:
    vector<int> grayCode(int n) {
        if(n < 1) return {0} ;
        vector<int> rst;
        grayCodeGen(n,rst);
        return rst ;
    }
private:
    void grayCodeGen(int n , vector<int> &rst)
    {
        if(n < 1) return  ;
        if(n == 1) 
        { 
            rst = {0,1} ;
            return ;
        }
        grayCodeGen(n-1,rst);
        // rst has been update to generate the (n-1) gray code
        rst.insert(rst.end(), rst.rbegin(), rst.rend()); // Mirror
        int currentHighBit = 1 << (n-1);
        for(int i = rst.size()/2 ; i < rst.size() ; ++i)
        {
            rst[i] |= currentHighBit; 
        }
    }
};
```

