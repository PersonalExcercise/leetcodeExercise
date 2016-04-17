###problem 139 Work Break

[link](https://leetcode.com/problems/word-break/)

###方法

以前做算法作业时做过这个题，当时使用的是3阶的算法，就是定义了`R[i,j]`来判断范围`s[i,j]`是否可以由dict中的词分割。然而看题解其实二阶就可以完成了，因为递归时只需总是查看从0开始到k的位置是否可由dict中词组成，以及`k+1`到末尾的字符串是否在dict中即可。这与三阶是等价的。

之前有道题也是类似的，然而我已经忘记了... 感觉刷LeetCode的速度实在太慢了，而且之前刷过的都忘了。

转移方程：

```C++

R[j] = ( str[:j+1] in dict ) || ( \exists k \in { j-1 downto 0 } (str[k+1:j+1] in dict and  R[k] ) )

```

###代码

```C++

class Solution {
public:
    bool wordBreak(string s, unordered_set<string>& wordDict) {
        size_t setSize = wordDict.size() ;
        if(0 == setSize) return false ;
        size_t sLen = s.length() ;
        if(0 == sLen) return false ;
        vector<bool> R(sLen , false) ;
        for(size_t i = 0 ; i < sLen ; ++i)
        {
            R[i] = false ;
            string testSubStr = s.substr(0 , i+1 ) ;
            // test substr is totally in wordDict
            if(wordDict.find(testSubStr) != wordDict.end())
            {
                R[i] = true ;
                continue ;
            }
            // split and test
            int k = i -1 ;
            while( k >= 0)
            {
                if( wordDict.find(testSubStr.substr(k+1)) != wordDict.end() 
                    && R[k])
                {
                    R[i] = true ;
                    break ;
                }
                --k ;
            }
            
        }
        return R[sLen - 1] ;
    }
};


```