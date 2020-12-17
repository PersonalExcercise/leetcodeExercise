
===========================================
560. Subarray Sum Equals K
===========================================

计算给定数组里，满足连续子数组和为K的子数组个数。


关键点
===========================================

最差的方法，可以在 :math:`O(n^2)` 内完成，这需要利用到历史和信息，从而避免重复计算。

进一步的，可以根据动态规划的思想，利用 hash 来记录历史信息，得到 :math:`O(n)` 的方法。

递推式需要利用前缀数组。

- 设数组为 a, 长度为 n
- 定义从 0 到 i 位置的连续子数组 a[0...i] 和为 `P[i]`.
- 满足如下定义 
    - 为了方便，定义 P[-1] = 0
    - :math:`P[i] = p[i - 1] + a[i]， i \in [0, n)`
- 进一步的，上述递推式可扩展为
    - :math:`P[i] = P[j - 1] + a[j...i], i \in [0, n), j \in [0, i]`

有了上面的递推式，我们只要对每一个 :math:`P[i], i \in [0, n)`, 令 `a[j...i] == k(即目标和)`，
看有多少个 `j` 满足条件即可。 
注意到这种定义下， `P[i]` 可以线性时间求出（基于 `P[i] = P[i - 1] + a[i]`），为定值，记为 `m` , 
而 `a[j...i] = k`, 那么其实就是等价的看，有多少个 `P[j - 1] == k - m`.

有多少个 `P[j - 1]` 的值，其实也就是看满足 :math:`P[x] == k -m , x \in [0, i)` 有多少个， 
这在 `P[i]` 之前已经算好了。

这时，因为是计数，我们拿 hash 缓存一下 `P[x] == V` 的计数，即 
:math:`hash[V] = \sum_{x=0}^{i - 1} P[x] == V`

特别的，初始时 `hash[0] = 1`, 因为初始条件 `P[-1] == 0`. 

代码
===========================================

.. code-block: c++

    int prefixArrayImpl(const std::vector<int>& nums, int k);

    class Solution {
    public:
        int subarraySum(vector<int>& nums, int k) {
            return prefixArrayImpl(nums, k);
        }
    };

    int prefixArrayImpl(const std::vector<int>& nums, int k) {
        // corresponding to nums index: -1, 0, 1, 2...
        std::vector<int> prefixArraySum(nums.size() + 1U, 0);
        std::unordered_map<int, int> prefixSumCount{
            {0, 1}
        };
        int totalCnt = 0;
        for (std::size_t i = 0U; i < nums.size(); ++i) {
            // for prefixArraySum index = (i - 1) + 1 = i
            int curPrefixSum = prefixArraySum.at(i) + nums.at(i);
            int targetPrefixSum = curPrefixSum - k;
            if (prefixSumCount.count(targetPrefixSum) > 0U) {
                totalCnt += prefixSumCount.at(targetPrefixSum);
            }
            // update prefix *
            ++prefixSumCount[curPrefixSum];
            prefixArraySum.at(i + 1U) = curPrefixSum; 
        }
        return totalCnt;
    }