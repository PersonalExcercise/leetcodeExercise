# problem 154. Find Minimum in Rotated Sorted Array II

[题目链接](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/)

## 方法

自己想得还是比较复杂——其实应该只有low、high、mid值都是相同时，才没有办法判断究竟最小值在哪边。不过看题解就非常简洁——只比较mid与high的大小，如果相等，就认为没法判断。

没法判断时的处理是很有讲究的！直接`--high`就好了！不过看另外一些题解，比较激进，同时还`++low`了——前提是low必然不是最小（因为他前面有这个是否是递增的判断。）

总的来说，题解的答案还是非常好的。写那么多判断，效果也不会有什么提高。而且我现在觉得的确没有必要做low与high的判断来确定是否就是递增序列——因为你不知道输入分布，这样的判断可能毫无意义。


最后——为什么不比较low与mid呢？我猜是这样的——当low与mid相等时（low与high差1），其low与mid值相等，按照上面的逻辑，就该++low了？还是--high？其实是不能确定的——因为你需要确定low与high的具体值。而比较mid与high则不会有问题，因为他们不可能指向同一个位置！这个理由还是比较充分的。

最后，这种代码，还是记住最好。放到代码库里吧。

## 代码

```C++
class Solution {
public:
    int findMin(vector<int>& nums) {
        if(nums.size() == 0){ return 0; } 
        int low = 0,
            high = nums.size() - 1;
        while(low < high)
        {
            int mid = low + (high - low) / 2 ;
            if(nums[mid] < nums[high])
            {
                // min is in the left
                high = mid;
            }
            else if(nums[mid] > nums[high])
            {
                // min is in the right
                low = mid + 1;
            }
            else { --high; } // can't get a conclusion
        }
        return nums[low];
    }
};
```