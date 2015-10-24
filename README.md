# leetcodeExercise
leetcode exercise 

50. 求x的n次方 , pow(double x , int n)

    [detail](src/prob50pow.md)

    **二分** ； **分治**

    一定要考虑n 为负的情况！ 一定要考虑n为0的情况。

53. 最大子数组和，Maximum Subarray

    [detail](src/prob53maxsubarray.md)
    
    一道比较有意思的题目。

    **分治** ； **动态规划** ；

55. Jump Game ，求能否到达数组的最后一个位置
    
    [detail](src/prob55jumpgame.md)

    **贪心** ； **动态规划**

    贪心不简单啊。  

64. 给定一个代价矩阵，从起点到终点（左右、上下只能取1个方向），求最小代价及相应的路径
    
    [detail](src/prob64minpathsum.md)

    **动态规划**

    到每个位置的最小代价，与其左（或右）和其上（下）的点有关。


69. 求一个整数的非精确平方根。 int sqrt(int x)

    [detail](src/prob69sqrt.md)

    **二分** ; **分治（剪枝）** 

120. 一个三角形从顶到底的最小和。

    [detail](src/prob120triangle.md)

    **动态规划**

    直观上肯定是自顶向下的做动态规划；但是*如果反过来，从底往上做，一下子就变得清晰简单多了*!