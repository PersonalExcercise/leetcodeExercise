# problem 17. Letter Combinations of a Phone Number 

[题目链接](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

## 方法

典型的深搜+回溯问题。很好，已经对这种题很熟悉了。

## 代码

```C++
class Solution {
public:
    vector<string> letterCombinations(string digits) {
        // validate
        for(const auto &c : digits)
        {
            if(c <= '1' || c > '9'){ return {}; }
        }
        if(digits.empty()){ return {}; }
        string curstr;
        vector<string> result;
        combinationRecursively(curstr, result, digits);
        return result;
    }
private:
    void combinationRecursively(string &curstr, vector<string> &result, const string &digits, size_t curPos=0)
    {
        if(curPos == digits.size())
        {
            result.push_back(curstr);
            return;
        }
        string &candidates = d2cMap[digits[curPos] - '0'];
        for(const auto &c : candidates)
        {
            curstr.push_back(c);
            combinationRecursively(curstr, result, digits, curPos+1);
            curstr.pop_back();
        }
    }
    vector<string> d2cMap = {
        "", // 0
        "", // 1
        "abc", // 2
        "def", // 3
        "ghi", // 4
        "jkl", // 5
        "mno", // 6
        "pqrs", // 7
        "tuv", // 8
        "wxyz" // 9
    };
};
```

## 后记

可以对unordered_map做类内初始化。

但是类内初始化似乎只能用赋值运算符！即这是拷贝赋值？（以vector为例，只能使用 `vector<int> v = vector<int>(6,10)`来做类内初始化，而不能使用`vector<int> v(6,10)`；前一种虽然是在初始化阶段完成的，但是相当于调用的构造函数为 vector<T>( const vector<T> &) 拷贝初始化?）. 