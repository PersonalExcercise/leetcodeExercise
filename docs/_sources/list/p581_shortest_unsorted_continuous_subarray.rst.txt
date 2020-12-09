
===========================================
581. Shortest Unsorted Continuous Subarray
===========================================

最短未排序的子数组长度。 `link <https://leetcode-cn.com/problems/shortest-unsorted-continuous-subarray/>`_

关键点
===========================================

1. 选择排序法：通过选择排序，试图找每个元素在排序后的位置；
    如果它要被交换，那么这时记录它的位置l，和要被交换的元素位置r；
    所有l的最小值、所有r的最大值，就是这个最短区间！

2. 直接排序比较法： 比较直观的方法

3. 栈方法： 从1方法可知，只需记录违背顺序时、要交换时位置信息即可。
    这可以通过栈在 O(n) 时间获得。

    从左往右遍历，维护递增栈；如果发现要入栈元素不满足递增，那就是违背顺序，被弹出元素的位置，就是l的值；

    再从右往左遍历，维护1个递减栈，处理类似，得到r的值。

    问题： 是否可以遍历一次就可以呢？ 简单想了下，觉得应该是不行的——栈方法只能保证遍历顺序下，要入栈的元素可以得到正确的位置，但是被弹栈的元素的正确位置得不到，也就
    无法在一次遍历中，拿到l、r两个边界；

    事实证明，的确也不行——一次遍历时记录l, r，代码提交结果显示结果错误。需要遍历2次；

4. 拐点法：从1、3可推知，从左往右遍历，将违背顺序的元素中，也即每个下降拐点处，
    所有拐点的低点的最小值在正确顺序的位置，就是l；
    所有拐点的高点的最大值，在正确顺序的位置，就是r；

    所以先一遍，求得拐点的最大值、最小值；
    然后再直接遍历数组，求得该最大值、最小值在原数组的位置（也即违背顺序的位置），也就是r、l的值。

    只需要 O(n)时间， O（1）空间，最是能体现题目的真谛吧。


代码
===========================================

.. code-block:: C++

    int selectionImpl(const std::vector<int>& nums);
    int stackImpl(const std::vector<int>& nums);
    int specializationImpl(const std::vector<int>& nums);

    class Solution {
    public:
        int findUnsortedSubarray(vector<int>& nums) {
            // return selectionImpl(nums);
            return stackImpl(nums);
            // return specializationImpl(nums);
        }
    };

    // will TLE
    int selectionImpl(const std::vector<int>& nums) {
        int sz = static_cast<int>(nums.size());
        int l = sz;
        int r = -1;

        for (int i = 0; i < sz; ++i) {
            for (int j = i + 1; j < sz; ++j) {
                if (nums.at(i) > nums.at(j)) {
                    l = std::min(l, i);
                    r = std::max(r, j);
                }
            }
        }
        return r - l < 0 ?
            0 :
            r - l + 1;
    }

    // 执行用时：132 ms, 在所有 C++ 提交中击败了8.70% 的用户
    int stackImpl(const std::vector<int>& nums) {
        int sz = static_cast<int>(nums.size());
        if (sz < 2) {
            return 0;
        }

        int l = sz;
        std::stack<int> ascStack{};
        for (int i = 0; i < sz; ++i) {
            auto v = nums.at(i);
            while (!ascStack.empty() && nums.at(ascStack.top()) > v) {
                l = std::min(l, ascStack.top());
                ascStack.pop();
            }
            ascStack.push(i);
        }

        int r = -1;
        std::stack<int> descStack{};
        for (int i = sz - 1; i >= 0; --i) {
            auto v = nums.at(i);
            while (!descStack.empty() && nums.at(descStack.top()) < v) {
                r = std::max(r, descStack.top());
                descStack.pop();
            }
            descStack.push(i);
        }

        return r - l < 0 ?
            0 :
            r - l + 1;
    }


    // 72 ms, 在所有 C++ 提交中击败了67.56%
    int specializationImpl(const std::vector<int>& nums) {
        int sz = static_cast<int>(nums.size());
        
        int descMinVal = std::numeric_limits<int>::max();
        int ascMaxVal = std::numeric_limits<int>::min();
        for (int i = 0; i < sz - 1; ++i) {
            if (nums.at(i) > nums.at(i + 1)) {
                descMinVal = std::min(descMinVal, nums.at(i + 1));
                ascMaxVal = std::max(ascMaxVal, nums.at(i));
            }
        }
        if (descMinVal == std::numeric_limits<int>::max()) {
            return 0;
        }

        int l = 0;
        while (descMinVal >= nums.at(l)) {
            ++l;
        }

        int r = sz - 1;
        while (ascMaxVal <= nums.at(r)) {
            --r;
        }
        
        return r - l + 1;
    }
