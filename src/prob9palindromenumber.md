# problem 9. Palindrome Number

[题目链接](https://leetcode.com/problems/palindrome-number/)

## 方法

原来题目里的`spoilers`是剧透的意思啊！完蛋，以后再也不看了。

看了剧透，知道一下几个问题：

1. 考虑负数，负数都不是回文数

2. 可以用字符串的方法

3. 可以用反转整数，再比较的方法，但是要考虑越界

4. 还有更通用的方法吗？

1、2、3都是没有问题的，有了提示写起来自然少遇到了很多坑，不过这也少了自己发现的乐趣。

还有更通用的方法吗？

没有想出来，看到题解后，明白了！

回文，都可以只做一半！

在[判断链表中的数字是否是回文](prob234palindromlinkedlist.md)中，我们就只需要反转后半部分，然后与前半部分比较即可。此外，还需要考虑回文的长度是奇数还是偶数的情况，这时往往需要特殊考虑，一般判断回文时，奇数情况可以和偶数一起考虑。因为奇数时，中心的元素会被划分到前半部分或者后半部分，这时只需要判断共有的部分（同偶数时的情况相同）是否相同就好了。

这道题中还是比较巧妙的。我们不断将数字除以10，并记录反转数字的大小，直到数字大于或者等于反转数字为止！考虑是回文数的情况，这是OK的，如果是回文，那么对偶数个数字的回文数，就是相等，对奇数的，就是反转部分比前半部分大一位，反转部分除以10就好了。考虑不是回文的情况，会不会有问题呢？发现如果数字是x000的情况时，上述的算法是行不通的！因为反转数字最后是x，而前半部分成为0，然后反转数字除以10，恰好就等于0了！！判断出错了！所以，需要特别对待！这不是回文判断方法的问题，是这种处理方式的问题。

## 代码

```C++
class Solution {
public:
    bool isPalindrome(int x) {
        // negative number is not palindrome 
        if(x < 0){ return false; }
        else if( x != 0 && x % 10 == 0){ return false; } // flowing code can't handle the case where num end with 0
        int halfReversedNum = 0;
        while(x > halfReversedNum)
        {
            halfReversedNum = halfReversedNum * 10 + x % 10;
            x /= 10;
        }
        return x == halfReversedNum || x == halfReversedNum / 10;
    }
};
```