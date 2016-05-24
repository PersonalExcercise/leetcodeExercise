###problem 57. Insert Interval

[link](https://leetcode.com/problems/insert-interval/)

## 方法


6666 ， 打败100%的用户~~ 16ms搞定...

方法上，就是很简单直观的找到新区间的位置。这里有几种情况，但是都非常直观，所以就不说了。但是这种类型的问题要写得完全没问题还真是不容易的！！调试了几次，一次提交就过了。整体还是非常NICE的。

我看他们的代码，似乎都是做了删除。而我的代码是另开的空间进行copy（用了初始化、copy函数），不知道是不知这个原因导致速度快了很多。

另外，找位置用的是依次查找。这个很明显可以用**二分查找**啊！！自己一开始就是在写二分查找，可是二分又是一个很难搞的东西——究竟该返回low值还是high值呢？逻辑上我真的有点分不清，测试了两种情况发现返回不一致。当时就在想要不要返回最小的作为近似位置，然后在在此基础上找到精确位置。一想着也太不精确了，最后被搞烦了，干脆用`O(n)`的顺序查找来做了。万万没想到，竟然速度这么快！！

看来这道题的Hard标签，主要是给其中复杂的条件判断的。不过细细弄下来，不算难。

一定要心态平和，才能搞定啊。

## 代码

```C++
/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
class Solution {
public:
    vector<Interval> insert(vector<Interval>& intervals, Interval newInterval) {
        size_t start_interval_idx = 0 , 
               end_interval_idx = 0 ;  // [start , end)
        int new_start_val = newInterval.start ,
            new_end_val = newInterval.end ;
        int start_val = newInterval.start ;
        for( ; start_interval_idx < intervals.size() ; ++start_interval_idx)
        {
            if(start_val <= intervals[start_interval_idx].start)
            {
                new_start_val = start_val ;
                break ;
            }
            else if(start_val <= intervals[start_interval_idx].end)
            {
                new_start_val = intervals[start_interval_idx].start ; 
                break ;
            }
        }
        int end_val = newInterval.end ;
        end_interval_idx = start_interval_idx ;
        for( ; end_interval_idx < intervals.size() ; ++end_interval_idx)
        {
            if(end_val < intervals[end_interval_idx].start)
            {
                new_end_val = end_val ;
                break ;
            }
            else if(end_val <= intervals[end_interval_idx].end)
            {
                new_end_val = intervals[end_interval_idx].end ;
                ++end_interval_idx ;
                break ;
            }
        }
        vector<Interval> rst(intervals.cbegin() , intervals.cbegin() + start_interval_idx) ;
        rst.push_back(Interval(new_start_val , new_end_val)) ;
        auto inserter = back_inserter(rst) ;
        copy(intervals.cbegin() + end_interval_idx , intervals.cend() , inserter) ;
        return rst ;
        
    }
};
```
