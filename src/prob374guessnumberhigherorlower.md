# problem 374. Guess Number Higher or Lower

[题目链接](https://leetcode.com/problems/guess-number-higher-or-lower/)

## 方法

哈哈哈哈，大水题。

## 代码

```C++
int guess(int num);

class Solution {
public:
    int guessNumber(int n) {
        if( n < 1){ return -1; }
        int low = 1, 
            high = n;
        while(true)
        {
            int guessNum = low + ( high - low ) / 2;
            int guessResponse = guess(guessNum);
            if(0 == guessResponse){ return guessNum; }
            else if(-1 == guessResponse)
            {
                // guess number bigger
                high = guessNum - 1;
            }
            else{ low = guessNum + 1; } // guess number smaller
        }
    }
};
```