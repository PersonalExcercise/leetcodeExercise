# problem 217. Contains Duplicate

[题目链接](https://leetcode.com/problems/contains-duplicate/)

## 方法

大水题——对于C++这种内置有HashTable结构的语言来说。

## 代码

```C++
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        unordered_set<int> seenSet;
        for(int num : nums)
        {
            if(seenSet.count(num) > 0){ return true; }
            else{ seenSet.insert(num); }
        }
        return false;
    }
};
```
