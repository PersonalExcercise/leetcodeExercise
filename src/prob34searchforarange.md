# problem 34. Search for a Range

[题目链接](https://leetcode.com/problems/search-for-a-range/)

## 方法

STL中相关方法写得实在太好了！！

以下直接贴出相关的代码了：

`lower_bound` : 找到已排序数组中第一个**大于等于**target的数的位置；没有则返回最后一个位置；

```C++
template <class ForwardIterator, class T>
  ForwardIterator lower_bound (ForwardIterator first, ForwardIterator last, const T& val)
{
  ForwardIterator it;
  iterator_traits<ForwardIterator>::difference_type count, step;
  count = distance(first,last);
  while (count>0)
  {
    it = first; step=count/2; advance (it,step);
    if (*it<val) {                 // or: if (comp(*it,val)), for version (2)
      first=++it;
      count-=step+1;
    }
    else count=step;
  }
  return first;
}
```

`upper_bound` : 找到已排序数组中第一个**大于**target的数的位置；没有则返回最后一个位置；

```C++
template <class ForwardIterator, class T>
  ForwardIterator upper_bound (ForwardIterator first, ForwardIterator last, const T& val)
{
  ForwardIterator it;
  iterator_traits<ForwardIterator>::difference_type count, step;
  count = std::distance(first,last);
  while (count>0)
  {
    it = first; step=count/2; std::advance (it,step);
    if (!(val<*it))                 // or: if (!comp(val,*it)), for version (2)
      { first=++it; count-=step+1;  }
    else count=step;
  }
  return first;
}
```

`equal_range` : 找到已排序数组中等于target的区间

```C++
template <class ForwardIterator, class T>
  pair<ForwardIterator,ForwardIterator>
    equal_range (ForwardIterator first, ForwardIterator last, const T& val)
{
  ForwardIterator it = std::lower_bound (first,last,val);
  return std::make_pair ( it, std::upper_bound(it,last,val) );
}
```

注意最后使用的尾递归。真是能省则省。

注意的是，lower_bound返回的是大于等于！有可能仅仅是大于，所以**需要判断**！如果是大于，则说明不存在等于的。

其次，uppper_bound返回的是大于的，所以，需要前移一个位置，才是等于的区间的最后一个位置。

最后，还是说说算法本身。以前一直写的二分，其实返回的都是第一个大于等于该数的位置，即`lower_bound`，但是这里还要求最后一个等于此数的位置，开始试了下更改判断条件，发现不怎么对。看了STL的实现，发现就是把以前 `nums[mid] < target`
改成了`nums[mid] <= target`的情况。其中的奥秘，真是说不太清楚。

对我而言，二分搜索，边界条件永远是那么玄妙。所以，记住是最好的。

## 代码

```C++
class Solution {
public:
    vector<int> searchRange(vector<int>& nums, int target) {
        int beg = lowerBoundSTLCopy(nums, target) ,
            end = upperBoundSTLCopy(nums, target) ;
        if( beg == nums.size())
        {
            return {-1, -1};
        }
        else if( nums[beg] > target )
        {
            return {-1, -1};
        }
        else
        {
            return {beg, end-1};
        }
    }
private:
    // >= 
    int lowerBoundSTLCopy(vector<int>& nums, int target)
    {
        int low = 0 , high = nums.size();
        while(low < high)
        {
            int mid = low + (high - low) / 2;
            if( nums[mid] < target ){ low = mid + 1; }
            else{ high = mid ; }
        }
        return low;
    }
    // > 
    int upperBoundSTLCopy(vector<int> &nums, int target)
    {
        int low = 0, high = nums.size();
        while(low < high)
        {
            int mid = low + (high - low) / 2;
            if( !(target < nums[mid]) ) // nums[mid] <= target 
            {
                low = mid + 1;
            }
            else{ high = mid; }
        }
        return low;
    }
};
```

## 后记

STL版的写得太好了！不过与常规的手写二分查找有些不一样（没有用low、mid、high，而是first与range，这是因为迭代器、是否支持随机访问的原因、效率的原因吧）。

自己根据STL写得手写版本，耗时14ms, STL 12ms .