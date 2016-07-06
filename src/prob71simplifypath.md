# problem 71. Simplify Path

[题目链接](https://leetcode.com/problems/simplify-path/)

## 方法

规范化路径表示。

方法很简单啦，不如说下规则：

1. 如果是`..`，则应该回到上一目录；如果上个目录已经是根目录，则维持根目录不变。

2. 如果是`.`，或者空，则保持当前目录

3. 否则，进入该目录

输出目录时，最后一个目录不带`/` , 即`/root/other/a`

## 代码

```C++
class Solution {
public:
    string simplifyPath(string path) {
        size_t len = path.length();
        if(0 == len){ return ""; }
        if(path[0] != '/'){ return "/"; }
        string::iterator start = path.begin() + 1 ,
                         pos = start;
        deque<string> s;
        while(pos < path.end())
        {
            while(pos != path.end() && *pos != '/'){ ++pos; }
            string dirname = string(start, pos);
            if(dirname == "..")
            {
                //if(s.size() == 0){ return "/"; } // bad !
                if(s.size() != 0) { s.pop_back(); }
            }
            else if(dirname != "."  && dirname != "")
            { 
                s.push_back(dirname);
            }
            start = ++pos;
        }
        string simplifiedPath;
        while(!s.empty())
        {
            simplifiedPath += "/";
            simplifiedPath += s.front();
            s.pop_front();
        }
        if(simplifiedPath.length() == 0){ simplifiedPath = "/"; }
        return simplifiedPath;
    }
};
```
