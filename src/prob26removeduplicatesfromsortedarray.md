###problem 26. Remove Duplicates from Sorted Array

[link](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)

## 方法

使用两个指针来做。一个前向指针，每次循环都往前。一个unique指针，指向的位置之前都是unique的。

当两个指针值相同时，除了前向指针固定的移动外，不做任何操作；否则，就将前向指针的值赋值为unique指针，且unique指针前移。

与单指针版的快排分割程序异曲同工。

## 代码

```C++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if(nums.empty()) return 0 ;
        vector<int>::iterator uniq_ite = nums.begin() ,
                              forward_ite = nums.begin() ;
        while(forward_ite != nums.end())
        {
            if(*forward_ite != *uniq_ite) *(++uniq_ite) = *forward_ite ;
            ++forward_ite ;
        }
        int uniq_size = uniq_ite - nums.begin() + 1 ;
        nums.resize(uniq_size) ;
        return uniq_size ;
    }
};
```

## 问题

可以使用STL

而且STL能够保证一致性——即无论输入是否是空，逻辑都是相同的。

```C++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        vector<int>::iterator end_unique = unique(nums.begin() , nums.end()) ;
        int unique_size = end_unique - nums.begin() ;
        nums.resize(unique_size) ;
        
        return unique_size ;
    }
};
```

这么一想，代码还是写得不好啊。