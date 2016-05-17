###problem 44. Wildcard Matching

[link](https://leetcode.com/problems/wildcard-matching/)

## 方法

看了标签，才想起用动态规划。定义递归方程：

```C++

R[si][pi] 表示字符串s[0:si+1] 与模式串p[0:pi+1]是否匹配。

则，考虑最后一个字符的匹配情况：

1. 如果p[pi]是'？'，如果匹配，那么必然要消耗一个字符串，即 R[si][pi] = R[si-1][pi-1] 
2. 如果p[pi]是'*'，如果匹配，有三种情况： 
   1. * 只匹配一个字符 ， R[si][pi] = R[si-1][pi-1]
   2. * 还将匹配其他字符, R[si][pi] = R[si-1][pi]
   3. *匹配空，R[si][pi] = R[si][pi-1]
   三种是或关系。
3. 如果是普通字符，则 R[si][pi] = R[si-1][pi-1] && (s[si] == p[pi]) 

```

初始化也需要特别注意，这里就不赘述了。应该只是上面的特例。仔细想就能想明白。

然而这个代码写出了时间复杂度却显得太高了.... 需要1776ms，打败3.46%用户..

照理说DP已经够快了，如果时间复杂度如此，只能说DP去考虑不是很好。

粗看了DISUZZ的代码，直接线性匹配+回溯，效率高很多。不过还不是很明白...

继续学习啊。

## 代码

```C++
class Solution {
public:
    bool isMatch(string s, string p) {
        size_t s_len = s.size() ,
               p_len = p.size() ;
        // edge
        if( 0 == s_len )
        {
            if(p_len == 0 ) return true ;
            return is_all_star(p , p_len -1) ; // is  all *
        }
        if( 0 == p_len )
        {
            if(0 == s_len) return true ;
            else return false ;
        }
        // DP
        vector<vector<bool>> R(s_len , vector<bool>(p_len)) ;
        // init
        if(p[0] == '?' || p[0] == '*' || p[0] == s[0]) R[0][0] = true ;
        else R[0][0] = false ;
        for(size_t row = 1 ; row < s_len ; ++row)
        {
            if(p[0] == '*') R[row][0] = true ;
            else R[row][0] = false ;
        }
        bool all_star = true ;
        for(size_t col = 1 ; col < p_len ; ++col)
        {
            all_star &= (p[col-1] == '*') ;
            if(all_star)
            {
                if(p[col] == s[0] || p[col] == '?' || p[col] == '*')
                {
                    R[0][col] = true ;
                }
                else
                {
                    R[0][col] = false ;
                }
            }
            else
            {
                if(p[col] == '*') R[0][col] = R[0][col-1] ; // according to previous status
                else R[0][col] = false ;
            }
        }
        // dp process
        for(size_t row = 1 ; row < s_len ; ++row)
        {
            for(size_t col = 1 ; col < p_len ; ++col)
            {
                if(p[col] == '?')
                {
                    R[row][col] = R[row-1][col-1] ;
                }
                else if(p[col] == '*')
                {
                    R[row][col] = R[row-1][col-1] || // * stands for only one char 
                                  R[row-1][col] ||   // * stands for more than one char 
                                  R[row][col-1] ;    // * stands for empty
                }
                else if(p[col] == s[row])
                {
                    R[row][col] = R[row-1][col-1] ;
                }
                else
                {
                    R[row][col] = false ;
                }
            }
        }
        return R[s_len-1][p_len-1] ;
    }
private :
    bool is_all_star(const string &str , int end_pos)
    {
        for(size_t i = 0 ; i <= end_pos ; ++i)
        {
            if(str[i] != '*') return false ;
        }
        return true ;
    }
};
```
