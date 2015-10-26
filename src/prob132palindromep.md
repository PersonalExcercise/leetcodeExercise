###problem 132 Palindrome Partitioning II

[link](https://leetcode.com/problems/palindrome-partitioning-ii/)

###方法

求一个字符串的最小分割数，使得分割的每部分都是一个回文。

首先我们要注意的是：回文的判断也可以用动态规划来做！（具有优化子结构和重叠子问题！）

####回文判断

优化子结构：

设P\[i,j\]表示S\[i,j\]是否是回文，则如果S[i] == S[j] ， 且 P[i+1 , j-1]为真（即S[i+1,j-1]是回文），则P[i,j] = True

完整的递推公式：

```C++
P[i,j] = True  , if i == j
P[i,j] = ( S[i] == S[j] ) , if i = j-1 (相邻)
P[i,j] = (S[i] == S[j]) && P[i+1 , j-1] , i <= j-2
```

代码表示为：

```C++
 void initPalindromeTable(string s , vector<vector<bool> > & palindromeTable)
    {
        int length = s.length() ;
        palindromeTable.clear() ;
        palindromeTable.resize(length , vector<bool>(length , false)) ;
        for(int i = 0 ; i < length ; ++i ) palindromeTable[i][i] = true ;
        for(int j = 1 ; j < length ; ++j ) palindromeTable[j-1][j] = ( s[j-1] == s[j] ) ;
        for(int offset = 2 ; offset < length ; ++offset)
        {
            for(int i = 0 ; i < length < offset ; ++i)
            {
                int j = i + offset ;
                palindromeTable[i][j] = (s[i] == s[j] ) && (palindromeTable[i+1][j-1]) ;
            }
            
        }
    }
```

####最小分割

首先想到的就是类似矩阵链乘的方法！我们定义优化子结构C[i,j]表示在S[i,j]范围内最小分割次数，定义C[i,i] = 0 ，则C[i,j] = P[i,j] ? 0 : min_{i <= k < j} { C[i,k] + C[k+1 , j] } + 1 

完整的递归式：

```C++
C[i,i] = 0
C[i,j] = 0 , if P[i,j] = True (也可以把上述初始条件合并)
C[i,j] = min_{i <= k < j} { C[i,k] + C[k+1 , j] } + 1 
```
代码：

```C++
int minCut(string s) {
    int length = s.length() ;
    vector<vector<bool> > palindromeTable(length , vector<bool>(length , false)) ;
    initPalindromeTable(s , palindromeTable) ;
    
    vector<vector<int> > minCutNums(length , vector<int>(length , 0)) ;
    for(int i = 0 ; i < length ; ++i) minCutNums[i][i] = 0 ;
    for(int offset = 1 ; offset < length ; ++offset)
    {
        for(int i = 0 ; i < length - offset ; ++i)
        {
            int j = i + offset ;
            // is palindrome for S[i,j]
            if(palindromeTable[i][j]) 
            {
                minCutNums[i][j] = 0 ;
                continue ;
            }
            // find k to minimize 
            int minNums = numeric_limits<int>::max() ;
            for(int k = i ; k < j ; ++k)
            {
                int currentCutNum = minCutNums[i][k] + minCutNums[k+1][j] ;
                if( currentCutNum < minNums ) minNums = currentCutNum ;
            }
            minCutNums[i][j] = minNums + 1 ;
        }
       
    }
    return minCutNums[0][length - 1] ;
    }
```

然而，遇到长字符串时，竟然超时了， orz....


题解中还提到了一种表示优化结构：f[i]表示从位置i到字符串末尾的最小分割数，其可以表示为从i位置向后找一个在位置k的分割，使得[i,k]是一个回文，且k+1位置到字符串末尾有最小的分割数。即f[i] = min_{k} { 1+ f[k+1]} 。这个应该在O(n^2)的时间里能够得到结果。

定义详细的递归式：

```C++
f[n] = 0
f[i] = 0 , if P[i,n] == True
f[i] = min_{i<= k < n } { f[k+1] + 1 } , if P[i,n] == False
```

