# problem 42. Trapping Rain Water

[题目链接](https://leetcode.com/problems/trapping-rain-water/)

## 方法

想起了Google APAC Test里的题，那个更加复杂，一维的变成了二维的情况！

这里，我们还可以采取一些比较tricky的方法，但是那道题感觉是没法做tricky，就得搜索。所以我觉得自己以后做题还是先把暴力的方法搞定。先学会走才行啊！

这道题，因为跟直方图最大面积很像，所以就想到了栈方法，也是写了一个点！！才写对。我觉得非常沮丧，因为面试、笔试时根本没有时间来调试的。

先说栈方法吧，栈中维护一个递减的序列（小标），额外维护一个对应的宽度的栈（之前想省掉这个，结果各种出错；或许是可以不用的，但是我不想记tricky的东西了）。读取一个值，如果栈空或者栈顶值大，那么直接压栈。如果栈顶值小，那么不断弹栈，知道栈空或者栈顶大，这时这两种情况收集的雨水是不同的——如果是栈空，说明左边低，由于栈中递减，所以最后一个弹栈元素就是收集雨水的最后高度。如果栈不同，说明右边是最后高度。为了避免存储更多信息，每次弹栈，我们先把当前值减掉高度，即先对其到当前的高度——如果最终高度就是这个高度，那么我们不用管，如果是左边的高度，那么我们减去这个多余高度乘上宽度就好了！没有问题。这样相当于合并了这些范围，所以压入的宽度就是这次合并的宽度。


题解上有更好的时间O(n)，空间O(1)的方法，使用双指针，分别从两边对着走，分别维护左边目前最大值和右边目前最大值。每次循环先判断左边指针的高还是右边的高——低的一遍先动，这样保证动的这边一定是最低高度，然后先更新最大高度，接着求当前高度与最高高度的差距，这个差距必然是会被填上水的，所以面积加上这个高度（乘上1）。太巧妙了，有点不敢相信。暂时没有写代码。

## 代码

```C++
class Solution {
public:
    int trap(vector<int>& height) {
        stack<int> idxStack;
        stack<int> widthStack;
        int len = height.size();
        int trapWaterSize = 0;
        for(int i = 0; i < len; ++i)
        {
            if(idxStack.empty())
            {
                idxStack.push(i);
                widthStack.push(1);
            }
            else if( height[idxStack.top()] >= height[i])
            {
                idxStack.push(i);
                widthStack.push(1);
            }
            else
            {
                int width = 1;
                int area = 0;
                while(!idxStack.empty() && height[idxStack.top()] <= height[i])
                {
                    int currentHeight = height[idxStack.top()],
                        currentWidth = widthStack.top();
                    idxStack.pop();
                    widthStack.pop();
                    width += currentWidth;
                    area += (height[i] - currentHeight) * currentWidth;
                }
                if(idxStack.empty())
                {
                    area -= (width-1) * (height[i] - height[i - width + 1]);
                    width = 1;
                }
                idxStack.push(i);
                widthStack.push(width);
                trapWaterSize += area;
            }
        }
        return trapWaterSize;
    }
};

```