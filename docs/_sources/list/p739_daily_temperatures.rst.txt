
===========================================
739. Daily Temperatures
===========================================

`<https://leetcode-cn.com/problems/daily-temperatures/>`_


关键点
-------------------------------------

基本方法：
**********
    
按照题意，直观处理即可。

直接TLE；

基于栈的方法：
******************

可以用栈来做——我自己大概是怎么也想不到吧，反正是很巧妙。记住吧！

处理方式：

1. 栈为空时，将当前元素和所在下标直接入栈 `(val, pos)`，移动到下一个元素 pos = pos + 1
2. 栈不空，比较当前元素与栈顶
    a. 如果栈顶小，则栈顶元素遇到了比它更大的元素，即栈顶找到了预期位置；则弹栈 (val, pos)，并记录结果： ``waitDays[pos] = cur_pos - pos``
    b. 否则，栈顶以及栈内所有的元素，都没有找到更大的元素；将当前元素和下标入栈 `(val, pos)`; 移动到下一个元素 pos = pos + 1
3. 若没有下一个元素，则说明栈内元素都没有更大的元素，即 ``waitDays[pos] = 0``


由此可知：

1. 栈内保存在当前位置之前，从前往后，还没有找到比它更大元素的元素。
2. 进一步地，可知栈内元素，从栈底到栈顶，元素大小不增

代码
-------------------------------------

.. code-block:: C++
   :linenos:

    class Solution {
        public:
        vector<int> dailyTemperatures(vector<int>& T) {
            using ValIdxPair = std::pair<int, std::size_t>;
            
            std::stack<ValIdxPair> s{};
            auto dayNum = T.size();
            std::vector<int> waitDays(dayNum, 0);
            std::size_t testPos{0U};

            while (testPos < dayNum) {
                auto curT = T.at(testPos);
                if (s.empty()) {
                    s.emplace(curT, testPos);
                    ++testPos;
                    continue;
                }
                // not empty. need test stack top and current Temperature
                if (s.top().first < curT) {
                    // find a big T for the stack top. should pop
                    auto stack_element_idx = s.top().second;
                    auto offset = testPos - stack_element_idx;
                    waitDays.at(stack_element_idx) = offset;
                    s.pop();
                } else {
                    // still not found.
                    s.emplace(curT, testPos);
                    ++testPos;
                }
            }
            // for stack left elements, they all can't find bigger temperatures, so they are all zero
            // no need to process.
            return waitDays;
        }
    };
