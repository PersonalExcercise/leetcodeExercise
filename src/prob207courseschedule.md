# problem 207. Course Schedule

[题目链接](https://leetcode.com/problems/course-schedule/)

## 方法

判断DAG是否有环的问题，可以转换为一个TOP排序，也可以直接检测。

我觉得，使用DFS的拓扑排序，也是直接检测。

还是先说Topological sort的思想： 找到当前所有入度为0的点，从图中移除（并且移除相关的边）；更新剩余节点的入度，继续寻找入度为0的点，循环此过程。知道找不到入度为0的点，此时有两种可能，一种是图被删空了，此时有一个拓扑排序；一种是图不空，则有环，不能构成一个拓扑排序。

很简单、直观的思想。

接下来就是实现，第一把朴素实现，每次都要遍历当前剩余的图，从图中找到入度为0的点。然后再批量删除；完全和上述逻辑一致，结果耗时很长。时间复杂度有些高。

然后，查看了[维基百科](https://en.wikipedia.org/wiki/Topological_sorting#Algorithms)，看到了以下两个算法：

1. kahn's Alogorithm （就叫做卡恩算法吧）

    维护一个入度为0的数据结构I；（如果为队列，则BFS；如果为栈，则先序遍历+深度优先，但访问的序列不是合法的拓扑序；所以我们最好使用队列来做）

    只要I不空，

    1. 从I中拿出一个节点v，访问本身的值

    2. 对 图中每个(v, t)，减少 t节点的入度；如果t入度变为0，则加入到I

2. DFS方法
    
    使用递归，维护一个全局已访问的布尔表；

    对每个入度为0的顶点，调用递归遍历子程序

    递归遍历子程序，需要维护一个临时已访问的布尔表：

    1. 如果当前节点已经临时被访问，有环！退出。
    
    2. 将当前访问节点设为临时已访问

    3. 如果当前节点的全局已访问状态为真，则返回；否则到4

    4. 对每个邻接的顶点，递归调用遍历子程序

    5. 完成邻接顶点遍历后，访问该节点！（所以它的出度已经先被访问了，然后访问该入度节点；因此得到的拓扑序是一个反序!）

    6. 设置该节点全局访问状态为真；（这样已经被遍历过的节点在其他公共路径下不会再被访问）

只实现了第一种卡恩算法。我觉得就这道题而言，不考虑递归程序的影响，DFS应该实际的潜在时间复杂度更低。因为如果没有环，那么二则时间复杂度一样；如果有环，DFS可以提前退出，而卡恩算法还是会遍历完所有节点。

## 代码

```C++
class Solution {
public:
    bool canFinish(int numCourses, vector<pair<int, int>>& prerequisites) {
        // build adjacent table
        vector<vector<int>> edgeTable(numCourses);
        vector<size_t> inDegreeTable(numCourses);
        for(pair<int, int> &edge : prerequisites)
        {
            int &from = edge.first,
                &to = edge.second;
            edgeTable[from].push_back(to);
            ++inDegreeTable[to];
        }
        // topological sort via kahn's algorithm
        // using queue as BFS
        queue<int> zeroInDegreeQ;
        for(int vertex = 0; vertex < numCourses; ++vertex)
        {
            if(inDegreeTable[vertex] == 0){ zeroInDegreeQ.push(vertex); }
        }
        size_t visitCnt = 0;
        while(!zeroInDegreeQ.empty())
        {
            int removeVertex = zeroInDegreeQ.front();
            zeroInDegreeQ.pop();
            ++visitCnt;
            // update
            for(int to : edgeTable[removeVertex])
            { 
                if(--inDegreeTable[to] == 0){ zeroInDegreeQ.push(to); }
            }
        }
        return visitCnt == numCourses;
    }
};
```

## 后记

一个好的实现很重要。之前朴素的版本，104ms，kahn算法20ms。想想第一版的关键就是，忽略了新的入度为0的点，只能由刚刚移除的边的出度点产生。而之前的算法还是全部遍历一遍。这大概就是关键所在吧。