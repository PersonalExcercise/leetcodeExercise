# problem 80. Remove Duplicates from Sorted Array II

[link](https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/)

## 方法

算是很容易想到的题，然而写起来却很纠结...还得多练啊..

我的思路是，记录重复的次数，初始为0，如果相等一次，则首先+1，然后判断是否小于2，如果是，则继续移动双指针并赋值；如果否，则只需移动遍历指针即可。如果不等，则清零重复次数，移动双指针并赋值。

纠结的问题有：

1. 遍历指针从哪里开始？

    uniq指针不得不从第一个开始，那么遍历指针如果从第一个开始，那么上述过程就不对了。

    我们需要明确的就是，uniq指针在上述逻辑表示指向uniq结果的最后一个位置。所以，根据此定义，其实遍历指针必须从第2个位置开始（表示第一个位置以及是uniq的）！自己的纠结是逻辑不清导致的。

2. 输入限制

    上述逻辑不能处理输入为空的情况！

    这是因为此逻辑成立的条件就是数组非空！因为uniq表示uniq部分的最后一个位置，如果数组未空，那么根本不存在uniq部分。

以上的方法很多条件判断。

完成上述代码后，看了DISCUSS，[第一个HOT的答案](https://leetcode.com/discuss/42348/3-6-easy-lines-c-java-python-ruby)真是让人难以置信！原来可以如此简洁与简单！

我把代码贴过来吧：

```C++
int removeDuplicates(vector<int>& nums) {
    int i = 0;
    for (int n : nums)
        if (i < 2 || n > nums[i-2])
            nums[i++] = n;
    return i;
}
```
我将其改写为等价的如下代码：

```C++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        size_t sz = nums.size() ;
        if(sz < 3) { return sz ;}
        size_t rear_pos = 1 ; 
        for(size_t pos = 2; pos < sz ; ++pos)
        {
            if(nums[pos] != nums[rear_pos-1])
            {
                nums[++rear_pos] = nums[pos];
            }
        }
        return rear_pos + 1 ;
    }
};
```

核心就是——不需要要记录有多少重复的数字，只需判断已有结果的状态！如果当前遍历指针的值与当前uniq指针(uniq部分的尾位置)的前一个位置的值相等（代码中是大于关系，其实可以改为不等于），那么就必然有：结果中已经有两个数相同了。

这其实是**两种思维方式**：

我的想法，很常规，就是考虑复制指针的状态，看目前已经有多少个重复的了。

题解的想法，是考虑已有结果的状态！看结果中是否已经有两个相等了（因为有序，只需一个位置判断）。

## 代码

这里贴上自己想的方法，相对繁琐。

```C++
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if(nums.size() < 3) { return nums.size() ; }
        const int DUPLICATE_LIMIT = 2 ;
        vector<int>::iterator dup_uniq_iter = nums.begin() ;
        int duplicates_cnt = 0 ;
        for(auto iter = nums.begin() + 1; iter < nums.end() ; ++iter)
        {
            if(*iter == *dup_uniq_iter)
            {
                ++duplicates_cnt ;
                if(duplicates_cnt < DUPLICATE_LIMIT)
                {
                    *++dup_uniq_iter = *iter ;
                }
            }
            else
            {
                *++dup_uniq_iter = *iter ;
                duplicates_cnt = 0 ;
            }
        }
        size_t newSz = dup_uniq_iter - nums.begin() + 1 ;
        nums.resize(newSz);
        return newSz;
    }
};
```

## 后记

关于迭代次与下标的速度比较：

对第二种方法，我写的迭代器版本：

 ```C++
 class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        size_t sz = nums.size() ;
        if(sz < 3){ return sz ; } // always satisfied
        vector<int>::iterator rear_iter = nums.begin() + 1 ;
        for(auto iter = nums.begin()+2 ; iter != nums.end(); ++iter)
        {
            if(*iter != *(rear_iter-1))
            {
                *++rear_iter = *iter ;
            }
        }
        return rear_iter - nums.begin() + 1 ;
    }
};
 ```

 以上与下标版逻辑完全一致，然而迭代器版本跑了20ms，而下标版只需要16ms

 这之间的差距时如何形成的呢？

 注意`for`循环中的`nums.end()`调用！当我把它在循环前保存下来作为一个变量来代替时，即：

```C++
//for(auto iter = nums.begin()+2 ; iter != nums.end(); ++iter)
auto end_iter = nums.end() ;
for(auto iter = nums.begin()+2 ; iter != end_iter; ++iter)
```
迭代器的版本时间消耗也成为了16ms！

**由此可见容器的`end()`调用其实也是一定程度耗时的**（在此种情况下有些显著啊！！）

以后如果有超大量的循环，且容器是只读，那么存储尾后迭代器或许是有必要的。