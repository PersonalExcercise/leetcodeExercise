###problem 115 Distinct Subsequences

[link](https://leetcode.com/problems/distinct-subsequences/)

###方法

题目非常有歧义性，“Given a string S and a string T, count the number of distinct subsequences of T in S.”怎么感觉都是要求T中的不同子串有多少个在S中，但是一看example就知道理解错了。

后来在[discuss](https://leetcode.com/discuss/599/task-clarification)中找到了问题的解释：其实是求S中有多少有不同的子串与T完全相同。

因为是S的子串与T相同，所以必然有`lenth(S) >= length(T)`

递推关系没有想出来，看了题解，只能强行解释了：

用`F(i,j)`表示`S[:i+1]`中有多少子串与`T[:j+1]`相同。

1. 对`i < j `的情况，由前面的说明知，这种是不可能的，为0 ；

2. 对`i == j` (i < len(T))的情况，如果S[:i+1] == T[:j+1] ， 那么就为1 ， 否则就是0

3. 对`i > j` ， 有两种讨论：

    1. 如果S[i] == T[j] ， 那么 `F(i,j) = F(i-1 , j) + F(i-1 , j-1)`

    2. 如果S[i] != T[j] ， 那么 `F(i,j) = F(i-1 , j)`

    至于原因，不能非常清晰的解释，只能强行地说： 如果S[i] == T[j] ，那么S[:i+1]中的子串中与T[:j+1]相同的，即可以是消耗掉T[j]，即F(i-1,j-1) , 也可以是不消耗T[j] , 即F(i-1 ,j) ；不等时，只能是在S[:i]中找子串与T[:j+1]相同。

以上完成了递推；以及计算方式；

还需要考虑初始化——对角线没有问题，但是要考虑j = 0 的情况，这时候根据实际意义，递推关系该写为：

1. S[i] == T[0] , F(i,0) = F(i-1 , 0) + 1

2. S[i] != T[0] , F(i,0) = F(i-1 , 0)

由此可写出代码。

###代码
    
    ```C++
    class Solution {
    public:
        int numDistinct(string s, string t) {
            unsigned sLen = s.length() ,
                     tLen = t.length() ;
            if(sLen < tLen) return 0 ;
            if(0 == tLen) return 0 ;
            vector<vector<int> > C(sLen , vector<int>(tLen , 0)) ;
            // init the diagonal
            C[0][0] = ( s[0] == t[0] ) ? 1 : 0 ; 
            for(unsigned i = 1 ; i < tLen ; ++i)
                C[i][i] = ( C[i-1][i-1] == 1 && s[i] == t[i] ) ? 1 : 0 ;
            // init col 0
            for(unsigned i = 1 ; i < sLen ; ++i)
                C[i][0] = ( s[i] == t[0] ) ? C[i-1][0] + 1 : C[i-1][0] ;
            // calc
            for(unsigned i = 2 ; i < sLen ; ++i)
            {
                unsigned colMax = min( i , tLen) ;
                for(unsigned j = 1 ; j < colMax ; ++j)
                    C[i][j] = ( s[i] == t[j] ) ? C[i-1][j-1] + C[i-1][j] 
                                               : C[i-1][j] ;
            }
            return C[sLen -1][tLen -1] ;
        }
    };
    ```


###OTHERS

最开始直观地考虑，可以是暴力构造T的子串，然后cout与T相等的数量。通过递推构造是一个可行的方法。

    
    T
    void count_substr_equal_num(str , start_delete_pos , &num)
    {
        for(int i = start_delete_pos + 1 ; i < len(str) ; ++i)
        {
            sub_str = str[0 : i] + str[i+1 : ]
            if(sub_str == T) ++num ;
            if(len(sub_str) > len(T)) count_substr_equal_num(sub_str , i , num) ;
        }
        
    }


