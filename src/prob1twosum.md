# problem 1. Two Sum

[题目链接](https://leetcode.com/problems/two-sum/)

## 方法

真是智障.

只想到3sum了，由于要返回索引，又看到HashTable，于是用`unordered_map`来预先存所有数的索引，再来用双指针找... 结果发现有重复值，又改用`unordered_multimap`，感觉已经是无所不用其及。

看了DISCUSS[Accepted C++ O(n) Solution](https://leetcode.com/discuss/10947/accepted-c-o-n-solution),其实只需要用map来存已经找过的数，用目标值减去当前值，看差值是否在已经找过的数中。如果在，那就是了。这样才是正解啊。上面的解法就是傻逼。

## 代码

```C++
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int,size_t> val2pos;
        for(int i = 0 ; i < nums.size(); ++i)
        {
            int anotherVal = target - nums[i];
            if(val2pos.count(anotherVal))
            {
                return {val2pos[anotherVal], i};
            }
            else
            {
                val2pos[nums[i]] = i ;
            }
        }
        return {};
    }
};
```

## 后记

记一下，三元运算符下不能直接返回vector字面值形式：

```C++
    return 1 ? {1,2} : {3,4}
```

会编译报错。没有找到原因...