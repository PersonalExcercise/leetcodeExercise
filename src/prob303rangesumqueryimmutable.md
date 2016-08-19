# problem 303. Range Sum Query - Immutable

[题目链接](https://leetcode.com/problems/range-sum-query-immutable/)

## 方法

因为题目说会查询很多次，所以做个缓存就好了。缓存做法也很简单，直接做0~k的和的缓存，这样求 `[m,n]` 时直接用 `[0,n] - [0, m-1]` 即可。为了方便`m=0`的情况，在缓存数组中增加一个为0的空白项。这样可以少一个if判断，非常好。

## 代码

```C++
class NumArray {
public:
    NumArray(vector<int> &nums) {
        sz = nums.size();
        cacheSums.resize(sz+1, 0);
        for(int i = 1; i <= sz; ++i)
        {
            cacheSums[i] = cacheSums[i-1] + nums[i-1]; // sum([0,i]) -> cacheSums[i+1]
        }
    }

    int sumRange(int i, int j) {
        if(j >= sz || i < 0){ return -1; }
        return cacheSums[j+1] - cacheSums[i];
    }
private:
    vector<int> cacheSums;
    int sz;
};

```