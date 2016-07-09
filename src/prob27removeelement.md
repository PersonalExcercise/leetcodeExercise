# problem 27. Remove Element

[题目链接](https://leetcode.com/problems/remove-element/)

## 方法

看到提示用双指针就很简单了。一个指针始终指向不含此元素的字符串结尾，一个指针一直移动直到结尾。

## 代码

```C++
class Solution {
public:
    int removeElement(vector<int>& nums, int val) {
        vector<int>::iterator noTargetValEndIter = nums.begin(),
                              iter = nums.begin();
        while(iter != nums.end())
        {
            if(*iter != val){ *noTargetValEndIter++ = *iter;  }
            ++iter;
        }
        return nums.size() - ( nums.end() - noTargetValEndIter );
    }
};
```