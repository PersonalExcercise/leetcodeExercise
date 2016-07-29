# problem 4. Median of Two Sorted Arrays

[题目链接](https://leetcode.com/problems/median-of-two-sorted-arrays/)

## 方法

直观地，在Merge的基础上找中位数即可。先根据长度的奇偶来判断我们需要找哪个数，奇数只需要找一个，偶数我们可以先找到第一个数，然后再找下一个数即可。因为用Merge来做，思路非常简单，不过边界条件同样繁琐，必须在每个索引改变的地方判断是否某个数组已经到了边界（当然其实这时候是更好处理的）。

上述想法根本不合题意，所以可以直接PASS的，然而因为对二分方法的恐惧，还是先把上述功能完成了。

随后，再次看了题解的算法。还是心里有股奇怪的念头，就是不愿意去接受。

随后自己再根据以前看的，在纸上琢磨了两个多小时，感觉还是有BUG。吃完饭回来看了[寻找两个已序数组中的第k大元素](http://www.cnblogs.com/XjChenny/p/3161592.html)，递归方法，非常简洁易懂。虽然一直希望能够递归的东西都知道尝试搞懂迭代该如何写，但是还是放弃了。

如此就好吧。现在我想，也许理解一个东西还是是一个循序渐进的过程，现在在这里死磕，完全是不科学的。第一是明白有些东西真的不是都会的，第二是，也许过段时间再回来看，以前不会的，可能一下子又如此清晰了。

不死磕，但又不能怂。 这本身就是一个难题啊。

## 代码

```C++
class Solution {
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        size_t totalSize = nums1.size() + nums2.size();
        if(totalSize == 0){ return 0.; }
        if(totalSize %2 == 0)
        {
            return ( findMedianRecursively(nums1.begin(), nums1.end(), nums2.begin(), nums2.end(), totalSize/2) + 
                     findMedianRecursively(nums1.begin(), nums1.end(), nums2.begin(), nums2.end(), totalSize/2 + 1)) / 2.;
        }
        else
        {
            return findMedianRecursively(nums1.begin(), nums1.end(), nums2.begin(), nums2.end(), totalSize/2 + 1);
        }
    }
private:
    int findMedianRecursively(vector<int>::iterator first1, vector<int>::iterator last1,
                              vector<int>::iterator first2, vector<int>::iterator last2,
                              int k)
    {
        if(first1 == last1){ return *(first2 + k - 1); }
        else if(first2 == last2){ return *(first1 + k - 1); }
        vector<int>::iterator mid1 = first1 + (last1 - 1 - first1) / 2;
        vector<int>::iterator mid2 = first2 + (last2 - 1 - first2) / 2;
        if(*mid1 < *mid2) // let *mid1 is bigger
        {
            swap(first1, first2);
            swap(last1, last2);
            swap(mid1, mid2);
        }
        int checkLen = (mid1 - first1) + (mid2 - first2) + 1;
        if( k <= checkLen)
        {
            // mid1 -> last1 should be abandon , mid1 become the last1
            return findMedianRecursively(first1, mid1, first2, last2, k);
        }
        else
        {
            // first2 -> mid2 should be abandon
            return findMedianRecursively(first1, last1, mid2 + 1, last2, k - (mid2 - first2) - 1);
        }
        
    }
};
```