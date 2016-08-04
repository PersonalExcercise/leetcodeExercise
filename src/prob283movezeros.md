# problem 283. Move Zeroes

[题目链接](https://leetcode.com/problems/move-zeroes/)

## 方法

双指针本身没有什么差别，一个指针用来移动，一个指针保证前面部分是非零元素。

但是在[283. Move Zeroes](https://leetcode.com/articles/move-zeroes/)中，优化了循环次数。

我做的时候，是直接将非零指针的值赋值为非零值就完了。移动完之后再把后续的元素给填充成0。

但是，最后一个填充操作是没有必要的！我们完全可以在将非零指针填充为非零值后，将移动指针指向的位置置为0！

更进一步地，我们其实可以直接swap操作，交换非零指针和移动指针位置的值即可！前面赋值还好理解，交换怎么可以呢？这是因为——要么非零指针与移动指针是同一个；要么非零指针到移动指针这个左闭右开的区间内全部是0! 嗯，没有问题的，可以画一下！


## 代码

```C++
class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        auto movingIter = nums.begin(),
             nonZeroIter = nums.begin();
        for(; movingIter != nums.end(); ++movingIter)
        {
            if(*movingIter != 0)
            {
                swap(*nonZeroIter++, *movingIter);
            }
        }
    }
};
```