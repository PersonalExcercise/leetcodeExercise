# problem 210. Course Schedule II 

[题目链接](https://leetcode.com/problems/course-schedule-ii/)

## 方法

如果上道题是用的拓扑排序的话，那么这道题就没有什么意义了...

## 代码

```C++
class Solution {
public:
    vector<int> findOrder(int numCourses, vector<pair<int, int>>& prerequisites) {
        vector<int> result;
        vector<vector<int>> edgeTable(numCourses);
        vector<int> inDegreeRecord(numCourses);
        for(pair<int, int> &prerequisite : prerequisites)
        {
            int &pre = prerequisite.second,
                &follow = prerequisite.first;
            edgeTable[pre].push_back(follow);
            ++inDegreeRecord[follow];
        }
        queue<int> zeroInDegreeQ;
        for(int courseId = 0; courseId < numCourses; ++courseId)
        {
            if(inDegreeRecord[courseId] == 0){ zeroInDegreeQ.push(courseId); }
        }
        while(!zeroInDegreeQ.empty())
        {
            int courseId = zeroInDegreeQ.front();
            zeroInDegreeQ.pop();
            result.push_back(courseId);
            // update in degree
            for(int toId : edgeTable[courseId])
            {
                --inDegreeRecord[toId];
                if(inDegreeRecord[toId] == 0){ zeroInDegreeQ.push(toId); }
            }
        }
        if(result.size() < numCourses){ result.clear(); }
        return result;
    }
};
```