# problem 31. Next Permutation

[题目链接](https://leetcode.com/problems/next-permutation/)

## 方法

顺着题解看了维基百科，才发现`Permutation`是一个被研究得很透彻的问题，就如同之前的格雷码一样。

英文的[维基百科](https://en.wikipedia.org/wiki/Permutation)，看着前面的罗素表有点吃力，不过幸好后面的获得一个随机的排列以及得到下一个按字典序排列的排列还是看明白了。

获得随机排列，可以从前往后处理，将当前的数随机与其后的数交换即可；一种带初始化的随机排列方法，不仅完成交换，还完成赋值。

获得字典序递增的排列，采用如下算法：

1. 从后往前，找到第一个满足 `num[k] < num[k+1]`的索引`k`. 如果不存在，则说明该排列时最大的字典序排列（即完全降序）。按照题意，只需反转该序列，返回即可（得到完全递增序列）。

    其实，我们找到的就是从后往前（逆向看）第一个递减对。-> 也就是说， 正向来看，k+1 到末尾是完全递减的。

2. 从后往前，找到第一个满足`num[k] < num[l]`的索引`l`

    其实是从后往前，找到第一个比k处元素大的值；由前面可知，k+1到末尾是个正向递减的，从后往前找第一个比num[k]大的，其实得到的就是比num[k]大的元素中最小的值。而且， l+1 到末尾的元素是比k处元素小的。

3. 交换 `k`与`l`处的元素

4. 将从`k+1`到末尾的元素全部反转(reverse)。

    交换再反转，首先是把最小的、比num[k]大的元素拿过来；把k处元素交换过去，不改变原来正向递减的顺序——现在反转，就变成递增序。两步合并起来，就得到了下一个字典序递增的排列。

非常巧妙，算法也非常简洁。

## 代码

```C++
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int sz = nums.size();
        int k = sz - 1 - 1; // before the last element
        while(k >= 0)
        {
            if(nums[k] < nums[k+1]){ break; }
            --k;
        }
        if(k < 0) // including edge : sz = 1, sz = 0
        {
            // increasing order
            reverse(nums.begin(), nums.end());
            return;
        }
        int l = sz - 1;
        while(l > k)
        {
            if(nums[k] < nums[l]){ break; }
            --l;
        }
        swap(nums[k], nums[l]);
        reverse(nums.begin() + k + 1, nums.end());
    }
};
```

