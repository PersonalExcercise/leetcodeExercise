# problem 6. ZigZag Conversion

[题目链接](https://leetcode.com/problems/zigzag-conversion/)

## 方法

嗯，想不到题解也是直观解法！按照直观理解写两个循环即可。

不过，理解是直接把相应字符放到行里了，而我更加原始地生成每列（最开始还想完全写Z字呢）。

## 代码

贴个自己的代码吧，空间会浪费一些（每两行浪费两个）。

```C++
class Solution {
public:
    string convert(string s, int numRows) {
        vector<string> matrix(numRows);
        int idx = 0,
            nrChar = s.size();
        while(idx < nrChar)
        {
            for(int k = 0; k < numRows && idx < nrChar; ++k)
            {
                matrix[k].push_back(s[idx++]);
            }
            for(int k = numRows - 2; k > 0 && idx < nrChar; --k)
            {
                matrix[k].push_back(s[idx++]);
            }
        }
        for(int k = 1; k < numRows; ++k)
        {
            matrix[0].append(matrix[k]);
        }
        return matrix[0];
    }
};
```