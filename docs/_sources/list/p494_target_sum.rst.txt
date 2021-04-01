
===========================================
[神题] 494. Target Sum 
===========================================

`<https://leetcode-cn.com/problems/target-sum/>`_

一个数字集合，里面只有非负数；现在要给每个数字加正号或者负号，然后加起来。
问有多少种方法和为 给定的值 S.


关键点
===========================================

首先我们要知道，肯定存在目标和达不到的情况：

1. 如果 :math:`|S|` 比集合内所有数加起来还大，那肯定不行
2. 某些特殊和一定取不到： 例如对集合 :math:`{1, 1, 1}, S = 2`, 那是怎么加减都不行的。 

    这其实暗示我们，S 和 数组应该有某种关系。

第 0 层，那就是枚举递归。 :math:`O(2^n)`

第 1 层，动态规划。建模为背包问题。背包问题，就是挨个看能不能装，求最大的价值。这里就是挨个看，正号有多少种，负号有多少中。
第一维当然是第 K 个物品，第二维，是加、减可能的和。需要分析下和的上下限。和可能是负数，这是编码稍微复杂的点。

第 2 层，这个可就有意思了。因为只有加、减号，那么其实可以把数分成两个集合，左、右集合。
左右集合都直接加和，然后目标和为 左边集合的和 - 右边集合的和。这是完全等价的。
这能干什么？ 能揭示 S 和 集合的关系！

.. math:
    
    let set = left \cap right
    sum_set = sum(v for v in set)
    sum_left = sum(v for v in left)
    sum_right = sum(v for v in right)

    sum_left - sum_right = S        (1)
    sum_left + sum_right = sum_set  (2)

    (1) + (2) =>
    2 * sum_left = S + sum_set

显然， sum_left 是一个整数，那么就要求 :math:`S + sum_set` 必须得是偶数。看看前面的的  :math:`{1, 1, 1}, S = 2` ， 不满足
该条件，果然不行！

有了这个转换，问题变成了： 从集合里挑出一些元素构成 :math:`left`, 使得其和为 :math:`(S + sum_set) / 2`.

这个就是更标准的背包问题了。

代码
===========================================

有点偷懒，只实现了第二层的方法。 而且还遇到了问题。主要是初始化的时候，遇到了为 0 的边界case：

对 0 元素，选、不选对应都到 1 个和（0），所以要用 `+=`, 如果直接赋值为 1 ，就错了。

建模： :math:`dp[i][j]` 表示处理第 i 个元素的时候，和为 j 的方法数。可以与 :math:`dp[i-1][x]` 递推上。

.. code: C++

    #include <numeric>

    int transform_solver(const std::vector<int>& nums, int target_sum);

    class Solution {
    public:
        int findTargetSumWays(vector<int>& nums, int S) {
            return transform_solver(nums, S);
        }
    };

    int transform_solver(const std::vector<int>& nums, int target_sum) {
        // -> transform to
        //      因为只有 + - 的选择，可已把加法都放在一起，减法也放在一起，提出减号，
        //      就变成了 
        //         target_sum = (a + b + c + ...) - (d + e + f + ...) => 公式2
        //      又 
        //         (a + b + c + ...) + (d + e + f + ...) = sum_val  => 公式1
        //      所以其实把又 + - 的问题，变为只有加的问题：
        //      (a + b + c + ...) = (target_sum + sum_val) / 2  （公式1 + 公式2 即得）
        //      也就变成，从数组中选择一个子集合， 和为 (target_sum + sum_val) / 2 的方法数
        //      这个解起来就容易一些了，复杂度也降低了
        //  限定：
        //      显然，要有解，必须：
        //          target_sum + sum_val >= 0 (因为数字全为非负，则 a + b + c 必然大于等于0)
        //          target_sum + sum_val 是偶数， 不然 / 2 除不尽 
        //              （可以举个例子， 数组是 1, 1, 1; 目标和 2， 3 + 2 是奇数, 这时原问题也是无解的）

        // the nums can't be empty by the given problem constraints
        int sum_val = std::accumulate(nums.cbegin(), nums.cend(), 0);
        // Edge condition.
        if (sum_val < target_sum) {
            return 0;
        }
        int test_sum = sum_val + target_sum;
        if (test_sum < 0 || test_sum % 2 != 0) {
            return 0;
        }
        int transform_sum = test_sum / 2;
        std::vector<std::vector<int>> dp(nums.size(), std::vector<int>(transform_sum + 1, 0));
        // ===== init 0 row
        // - not select
        dp[0][0] = 1;
        // - select, need to check whether could select
        if (nums[0] <= transform_sum) {
            // dp[0][nums[0]] = 1; // !! ERROR! 
            // if nums[0] == 0, it is same with not-select!
            // and we should sum the posibility
            // consider case: nums = [0, 1]; dp[0][0] should be 2, instead of 1!
            dp[0][nums[0]] += 1;
        }
        // ===== for loop
        for (unsigned i = 1; i < nums.size(); ++i) {
            auto val = nums[i];
            for (int j = 0; j <= transform_sum; ++j) {
                // not select
                dp[i][j] = dp[i - 1][j];
                // select
                if (val <= j) {
                    dp[i][j] += dp[i - 1][j - val];
                }
            }
        }

        return dp.back().back();
    }