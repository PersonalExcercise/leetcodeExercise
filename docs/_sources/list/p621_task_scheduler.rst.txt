
===========================================
621. Task Scheduler
===========================================

给定一批任务（名字是英文大写字母），要求在 CPU 上安排这些任务的执行顺序，保证 n 个时间片上，
不能执行同名的任务（没有合适任务安排，就用 `idle`表示, `idle` 不算任务）。

求执行完这些任务，最少需要多少个时间片。

例子： `tasks = ["A","A","A","B","B","B"], n = 2, Output: 8`

`task scheduler <https://leetcode-cn.com/problems/task-scheduler/>`_


关键点
===========================================

记住就好：

1. 贪心方法
2. 划分 `n + 1` 个桶，每次优先把 `剩余数量最多` 的任务给放进去, 由此，就可以得到最短需要的时间

    .. code-block::

        # tasks = ["A","A","A","B","B","B"]
        # n = 2, 就划分3个桶
        # | A | B | idle |
        # | A | B | idle |
        # | A | B | 
        # total = 8


3. 因为每次要取 `top (n + 1)` 多的任务，可以用 `优先队列` 来完成该需求 

代码
===========================================

.. code-block:: C++

    class Solution {
    public:
        int leastInterval(vector<char>& tasks, int n) {
            // count tasks
            std::vector<int> taskCount(26, 0);
            for (auto task : tasks) {
                ++taskCount.at(task - 'A');
            }
            
            auto cmp = [&taskCount](auto l, auto r) { return taskCount.at(l) < taskCount.at(r); };
            std::priority_queue<std::size_t, std::vector<std::size_t>, 
                decltype(cmp)> countDescQueue(cmp);
            for (std::size_t i = 0U; i < taskCount.size(); ++i) {
                if (taskCount.at(i) == 0) {
                    continue;
                }
                countDescQueue.push(i);
            }

            int totalTime = 0;
            while (true) {
                std::vector<std::size_t> taskIds{};
                taskIds.reserve(n + 1);
                for (int i = 0; i < n + 1 && !countDescQueue.empty(); ++i) {
                    auto taskId = countDescQueue.top();
                    countDescQueue.pop();
                    taskIds.push_back(taskId);
                    --taskCount.at(taskId);
                }
                for (auto exeTaskId : taskIds) {
                    if (taskCount.at(exeTaskId) == 0) {
                        continue;
                    }
                    countDescQueue.push(exeTaskId);
                }
                if (!countDescQueue.empty()) {
                    totalTime += n + 1;
                } else {
                    totalTime += taskIds.size();
                    break;
                }
            }
            return totalTime;
        }
    };