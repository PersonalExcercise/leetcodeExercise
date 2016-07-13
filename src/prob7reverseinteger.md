# problem 7. Reverse Integer

[题目链接](https://leetcode.com/problems/reverse-integer/)

## 方法

一些特殊情况确确实实需要考虑！

1. 如果结尾由0，如100，它的反转数？ 这提升我们如果用字符串来做的话，需要注意。

2. 越界怎么办！如果用字符串，只能用stoll来转换到long long，再判断其与`INT_MAX` 或者 `INT_MIN`间的大小来确定是否越界。

看了DICUSS [My accepted 15 lines of code for Java](https://discuss.leetcode.com/topic/6104/my-accepted-15-lines-of-code-for-java)，里面使用每次将增大的数除以10，比较与原数是否相等来判断是否越界！这是非常巧妙的！

此外，此DICUSS下的评论这是dou.

## 代码

```C++
class Solution {
public:
    int reverse(int x) {
        // learned from 
        int result = 0;
        while(x)
        {
            int tmp = result * 10 + x % 10;
            if(tmp / 10 != result){ return 0; } // overflow
            x /= 10;
            result = tmp;
        }
        return result;
    }
};
```