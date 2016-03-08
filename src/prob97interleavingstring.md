###problem 97 Interleaving String

[link](https://leetcode.com/problems/interleaving-string/)

###方法

三个字符串a,b,c，确定第三个字符串c是否由前两个字符串a,b交叉组合而成。

第一感觉有些类似最长公共子串。

第二感觉是不是在各串上分别设置一个指针，遇到相同的就移动，都移动到尾就ok。马上就否定了，因为如果此时指针指向的三个位置的字符都是一样的，那么怎么确认c上的这个字符是来自a还是来自b呢？

这才是问题的难点啊... 一上来犯了一个错才发现问题的困难在哪里...

想了一下，还是没有DP的思路，只能看题解了。

用F[i\][j\]表示第三个字符串`c`前 `i+j`个字符，是否是由第一个字符串`a`的前`i`个字符以及b的前`j`个字符交叉构成的。

那么其递推关系可以写作

    F[i][j] = ( ( a[i-1] == c[i+j-1] ) && F[i-1][j] )
            ||( ( b[j-1] == c[i+j-1] ) && F[i][j-1] )

注意下标的关系！（F这个表格是有 `(a.size() + 1) x ( b.size() + 1 )` 的）

递推关系说明，在DP表格中，F[i\][j\]依赖于上方和左方的两个值。

需要初始化第0行和第0列，方法为：

    F[0][j] = (b[j-1] == c[j-1]) && F[0][j-1] , 1 <= j <= b.size()
    F[i][0] = (a[i-1] == c[i-1]) ** F[i-1][0] , 1 <= i <= a.size()



###代码

    class Solution {
    public:
        bool isInterleave(string s1, string s2, string s3) {
            size_t len1 = s1.size() , 
                   len2 = s2.size() ,
                   len3 = s3.size() ;
            // asert lenght is valid
            if(len1 + len2 != len3) return false ;
            vector<vector<bool> > F(len1+1 , vector<bool>(len2+1 , false)) ;
            F[0][0] = true ;
            
            // init row
            for(size_t j = 1 ; j <= len2 ; ++j) F[0][j] = ( s2[j-1] == s3[j-1] ) && F[0][j-1] ;
            // init col
            for(size_t i = 1 ; i <= len1 ; ++i) F[i][0] = ( s1[i-1] == s3[i-1] ) && F[i-1][0] ;
            // build lattice
            for(size_t i = 1 ; i <= len1 ; ++i)
            {
                for(size_t j = 1 ; j <= len2 ; ++j)
                {
                    F[i][j] = ( (s1[i-1] == s3[i+j-1]) && F[i-1][j] )
                            ||( (s2[j-1] == s3[i+j-1]) && F[i][j-1] ) ;
                }
            }
            return F[len1][len2] ;
        }
    };