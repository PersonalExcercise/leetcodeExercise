
===========================================
647. Palindromic Substrings
===========================================

找到一个字符串中，所有的回文子串个数。回文串间下标不同就认为不同。


关键点
===========================================

所谓回文，就是 :math:`s` 与 :math:`s` 的反转字符串相同。 回文可分为 奇数长度 和 偶数长度 两种，
奇数回文串是基于中心字符对称的；偶数回文串基于中心空白对称（或者说对称中心是 中间 的 2 个字符）。

方法1：中心扩展法
----------------------------------------

最朴素的做法当然是暴力选定区间 ＆＆ 判定区间内子串是不是回文。

考虑到回文的特性，更好的做法是中心扩展法：分别考虑奇数长度和偶数长度：

- 奇数长度，1个字符当然是回文串；然后左、右端点分别向外扩展并检查是否是回文； 1 个 for 循环即可判定到以此为中心的奇数回文串长度；
- 偶数长度，可将　当前位置的前一个位置 和 当前位置 作为中心，然后同样向外扩展并检查是否是回文。 

.. note::

    这个检查逻辑和上面的奇数长度是可以复用的，接口即定义为：

    .. code-block:: python 

        bool is_equal(left_center, right_center, radius)

        # 其中奇数长度下， left_center 和 right_center 是一样的； radius 就是要中心往外扩展长度，也被称为半径；
        # 半径为1时仅包含中心自己。


方法2：manacher 方法
----------------------------------------

从前面的叙述中，我们其实可以发现一个等价概念：

以 ``i`` 为中心位置的、包含的回文串个数，等于 ``i`` 为中心的最长回文串的长度（也需要奇偶分别考虑，但都一样）。

进一步的，题目要求整个串包含的回文子串的个数， 也就是求 以各个位置为中心的 奇、偶 最长回文串的长度的和。

而求 各个位置的奇偶最长回文串长度，可以用 manacher 在线性时间内完成；

关于 manacher 算法，可以见 `manacher-oi-wiki`_ .  

这个页面说得已经非常好了，代码也实在简洁。这里罗列下关键点：

1. manacher 算法的核心，是利用已有的最长回文串信息，来减少不必要的检查：

    1. 记录了整个字符串内，到达最右端的回文串的边界 r, 以及对应的左边界 l
    2. 在边界内的位置，其关于 `l ... r` 有一个对称点 `j`, 这个点的回文串长度信息已经求过了；所以可以用它来辅助！

        位置信息如下（一定记住这个图！）：

        `l...j....C....i...r` 

        `.........|.........` (对称关系)
        
        r 为到达最右边边界的回文串范围;
        `i` 关于 `C` 的对称点 `j`, 因为 `l ... r` 内是关于 `C` 对称的，
        所以 `i` 的回文信息 和 `j` 就有关！

    3. 前提是这个位置 `i` 在 `r` 内； 否则，就没有额外信息了，得回退到中心扩展法；
    4. 即使在 `r` 内， 也只能保证 `min(r - i, d[j])` 这个长度内的回文信息，超过这个长度，还是要用中心扩展法
    5. 即使如此，因为 `r` 的存在，中心扩展法最多迭代 ``n`` 次， 所以整个算法复杂度是 `O(n)`

2. manacher 一开始用辅助字符来填充原始串（n 个长度，填充 n +１　个辅助字符），从而将奇偶长度的考虑，化解为仅需要考虑新串的奇数情况。

    假设辅助字符为　`#`. 

    原串是 `ab`, 新串为 `#a#b#`；
    
    对新串第一个 `#` 的奇数回文串，就对应原串 `a` 的偶数回文串 （因为是开始位置，不存在）；
    对新串第二个 `a` 的奇数回文串，对应原串 `a` 的奇数回文串。
    对新串第三个 `#` 的奇数回文串，对应原串 `b` 为中心的偶数回文串（即以 `ab` 为中心）；
    对新串第四个 `b` 的奇数回文串，对应原串 `b` 为中新的奇数回文串。

    还注意到，**新串上的最长回文串长度，与原始串的长度关系为 `r_original = r_new / 2`**

    上面的情况，新串半径分别是 `1, 2, 1, 2, 1`, 则原始串半径为 `0, 1, 0, 1, 0`; 与真实情况一致。 

3. 半径大小与下标的关系：半径为1，对应的是自己，下标不变！一定记住 manacher 存的是每个位置的最长回文串的半径；


代码
===========================================

.. code-block:: C++

    int centerExpandImpl(const std::string& s);
    int manacherImpl(const std::string& s);

    class Solution {
    public:
        int countSubstrings(string s) {
            // return centerExpandImpl(s);
            return manacherImpl(s);
        }
    };

    //
    // impl1. center-expand 
    //

    int centerExpandImpl(const std::string& s) {
        int totalCnt = 0;
        int strSz = static_cast<int>(s.size());
        auto isEdgeEqual = [strSz, &s](int lCenter, int rCenter, int radius) -> bool {
            auto leftPos = lCenter - radius + 1;
            auto rightPos = rCenter + radius - 1;
            return leftPos >= 0 && rightPos < strSz && s.at(leftPos) == s.at(rightPos);
        };
        // Odd case
        for (int oddCenterIdx = 0U; oddCenterIdx < strSz; ++oddCenterIdx) {
            int radius = 1;
            while (isEdgeEqual(oddCenterIdx, oddCenterIdx, radius)) {
                ++totalCnt;
                ++radius;
            }
        }
        // even case
        for (int evenLCenterIdx = 0; evenLCenterIdx < strSz - 1; ++evenLCenterIdx) {
            int radius = 1;
            while (isEdgeEqual(evenLCenterIdx, evenLCenterIdx + 1, radius)) {
                ++totalCnt;
                ++radius;
            }
        }
        return totalCnt;
    }

    //
    // impl2. manacher impl
    //
    int manacherImpl(const std::string& s) {
        auto expandStrFn = [&s]() {
            std::string expandStr{};
            auto sz = s.size() * 2U + 1U;
            expandStr.reserve(sz);
            for (auto c : s) {
                expandStr.append("#").append(1U, c);
            }
            expandStr.append("#");
            return expandStr;
        };
        auto expandStr = expandStrFn();
        
        auto sz = static_cast<int>(expandStr.size());
        int maxPalinL = 0;
        int maxPalinR = -1;
        std::vector<int> maxRadius(sz, 1);

        auto isEdgeEqual = [&expandStr, sz](int center, int radius) {
            auto lEdge = center - radius + 1;
            auto rEdge = center + radius - 1;
            return lEdge >= 0 && rEdge < sz && expandStr.at(lEdge) == expandStr.at(rEdge);
        };

        for (int i = 0; i < sz; ++i) {
            // 
            // l..j..C..i...r
            auto knownPalinRadius = i > maxPalinR ? 
                1 : 
                std::min(maxPalinR - i + 1, maxRadius.at(maxPalinR - i + maxPalinL));
            auto testRadius = knownPalinRadius + 1;
            while (isEdgeEqual(i, testRadius)) {
                ++testRadius;
            }
            // testRadius is not a valid palindromic, `- 1` is valid.
            auto currentPalinRadius = testRadius - 1;
            maxRadius.at(i) = currentPalinRadius;
            if (i + currentPalinRadius - 1 > maxPalinR) {
                maxPalinR = i + currentPalinRadius - 1;
                maxPalinL = i - currentPalinRadius + 1;
            }
        }

        // align back, = expandStr's max-radius / 2
        std::vector<int> originalMaxRadius{};
        originalMaxRadius.reserve(sz);
        std::transform(maxRadius.cbegin(), maxRadius.cend(), std::back_inserter(originalMaxRadius), 
            [](int v) { return v / 2; });
        // int sumVal = std::accumulate(originalMaxRadius.cbegin(), originalMaxRadius.cend(), 0);
        int sumVal = std::reduce(originalMaxRadius.cbegin(), originalMaxRadius.cend());
        return sumVal;
    }


.. _`manacher-oi-wiki`: https://oi-wiki.org/string/manacher/