# problem 11. Container With Most Water

[题目链接](https://leetcode.com/problems/container-with-most-water/)

## 方法

第一感觉是跟柱形图围成的最大面积的题很像，但是也想不到方法啊。

看了题解，双指针。

1. 初始两个指针，一个指向头部，一个指向尾部；初始用来存储最大面积的变量为0

2. 计算当前两个指针位置的值构成的桶的装水面积（宽度* 高度，高度就是两个隔板中的最小值）

3. 按规则移动隔板： 如果左边隔板低，那么将左边指针右移一个位置；如果右边隔板低，那么将右边指针左移一个位置。相等则任意移动一个。如果左边指针小于右边，跳到1；否则结束。（可以有更高效的实现，即移动时不是移动一个位置，而是移动到下一个比当前值大的位置。）

关于WHY（证明或解释），题解上大概有3种，以下列举：

1. 木桶理论

    这个叫木桶理论有点牵强...解释起来似乎也不太有信服力(正向解释)。

    由木桶理论，装水的多少是由最短的板决定的。在这种情况下，如果移动大的一方，那么其高度只能小于等于当前小的值；而移动后宽度也小了，所以这样只会导致装的水变少——所以我们得移动小的一方。

2. 反证法

    完了，忘记了...

3. 直接证明

    [Yet another way to see what happens in the O(n) algorithm](https://discuss.leetcode.com/topic/3462/yet-another-way-to-see-what-happens-in-the-o-n-algorithm)

    对l，r指针

    1. 如果l小于r, 那么区域`[l, r - k]` where `k >= 1 && r - k > l` 都不必再找了，必然不会是最大值；因为对此区域，因为l小，所以构成的桶的最大高度最多时`l`, 且其宽度小于当前宽度，故其装水量必然小于当前装水量；因此这个区域可以跳过。而跳过该区域的方法就是直接右移l指针；

    2. 如果l大于r，那么区域`[l+k, r]` where `k >= 1 && l + k < r`不必再测试；道理与上面相同——因为此区域最大高度最多是`r`, 而高度又小于当前区域，故装水量必然低于当前区域。因此通过左移`r`来进行下次合理寻找。

嗯，还是第三种最简单、且有说(shuo)服力。把第三种记住吧；第一种可以作为最直观的理解；第二种嘛？诶，逻辑能力真的不行。看过忘了，推不出来...

## 代码

带跳过的版本，然而速度并没有什么区别。理轮上可以减少一些乘法计算。

```C++
class Solution {
public:
    int maxArea(vector<int>& height) {
        int left = 0,
            right = height.size() - 1;
        int maxAreaVal = 0;
        while(left < right)
        {
            int currentArea = (right - left) * min(height[right], height[left]);
            maxAreaVal = max(maxAreaVal, currentArea);
            if(height[left] < height[right])
            {
                ++left;
                while(left < right && height[left] < height[left-1]){ ++left; }
            }
            else
            {
                --right;
                while(left < right && height[right] < height[right+1]){ --right; }
            }
        }
        return maxAreaVal;
    }
};
```

## 后记

想要把存储最大面积的变量取名为`maxArea`, 然而突然发现函数就是这个名！于是放弃了。突然有个疑问——假设就这么取有问题吗？

在机器上做了测试——没有问题。理论上来说，函数maxArea作用域的层级高于里面的变量，所以这就相当于是内层作用域覆盖了外层作用域的变量了（函数名也是变量啊）。

如果在全局作用域下，可就不能声明为与此函数相同的名字了。

不过，为了无歧义，咱们还是没有必要这么做，是吧。