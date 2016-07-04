# problem 223. Rectangle Area

[题目链接](https://leetcode.com/problems/rectangle-area/)

## 方法

额，智障的我用if-else给写出来了。

看了题解感觉又被爆了。

```C++
相交区域的
w = min(右上角X1，右上角X2) - (左下角X1， 左下角X2)
h = min(右上角Y1，右上角Y2) - (左下角X1， 左下角X2)
```

orz...

不管怎么说，自己花了一个小时还是做出来了，还是时间上最快的... 反正看交点的时候，只需要看4个点就好了，去掉二维信息吧。之前一直纠结在二维上...

## 代码

只写了我自己的low代码...

```C++
class Solution {
public:
    int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
        int totalArea = (C-A) * (D-B) + (G-E) * (H-F);
        bool hasIntersection;
        int xLow , xHigh;
        hasIntersection = calcLinearIntersection(E, G, A, C, xLow, xHigh);
        if(!hasIntersection){ return totalArea; }
        int yLow, yHigh;
        hasIntersection = calcLinearIntersection(F, H, B, D, yLow, yHigh);
        if(!hasIntersection){ return totalArea; }
        int intersectionArea = (xHigh - xLow) * (yHigh - yLow);
        return totalArea - intersectionArea;
    }
private:
    bool calcLinearIntersection(int l1Low, int l1High, int l2Low, int l2High, int &low, int &high)
    {
        if(l2Low <= l1Low && l1Low < l2High && l2High <= l1High)
        {
            // . | .  |
            low = l1Low;
            high = l2High;
            return true;
        }
        else if(l2Low < l1Low && l1High < l2High)
        {
            // . |  | .
            low = l1Low;
            high = l1High;
            return true;
        }
        else if(l1Low < l2Low && l2High < l1High)
        {
            // |.  .|
            low = l2Low;
            high = l2High;
            return true;
        }
        else if(l1Low <= l2Low && l2Low < l1High && l1High <= l2High)
        {
            // |  . | .
            low = l2Low;
            high = l1High;
            return true;
        }
        else if(l2High <= l1Low || l1High <= l2Low)
        { 
            // . . | |   
            // | | . .
            return false; 
        }
        return false;
    }
};
```