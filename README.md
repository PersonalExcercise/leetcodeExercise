# leetcodeExercise
leetcode exercise 

12. 整数转罗马数字
    
    [detail](src/prob12integer2roman.md)

    **转换**

13. 罗马数字转整数

    [detail](src/prob13roman2integer.md)

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

72. 编辑距离

    [detail](src/prob72editdistance.md)

    **动态规划** ； 

    *经典*


84. 直方图中最大矩形面积

    [detail](src/prob84largestrectangleinhistogram.md)

    **栈方法**

85. 最大全部为1的矩形面积

    [detail](src/prob85maximalrectangle.md)

    **动态规划**；

    *Hard*

    还有*栈方法*待完成。

87. Scramble String

    [detail](src/prob87scramblestring.md)

    **暴力**；**递归**；**三阶动态规划**；**剪枝**；

    *Hard*；
91. 解码方法数

    [detail](src/prob91decodeways.md)

    **动态规划**；**递推**；

97.  一个字符串是否有其他两个字符串交叉组合而成

     [detail](src/prob97interleavingstring.md)

     动态规划；

     *Hard*

98. 验证是否是二叉查找树

    [detail](src/prob98validBST.md)

    **二叉查找树，BST**

115. 计数：与一个串相同的不同子串数量

    [detail](src/prob115distinctsubsequences.md)

    **动态规划** ； 

    **题目不清**；

120. 一个三角形从顶到底的最小和。

    [detail](src/prob120triangle.md)

    **动态规划**

    直观上肯定是自顶向下的做动态规划；但是*如果反过来，从底往上做，一下子就变得清晰简单多了*!

123. 买卖股票赚大钱III

    [detail](src/prob123besttimetobuyandsellstockIII.md)

    **动态规划**（非典型）

    想错了的题！！

132. 回文字符串最小分割

    [detail](src/prob132palindromep.md)

    **动态规划**

    与矩阵链乘类似。如果使用二维的动态规划，则超时，换为一维的终于通过了。一维的优化子结构是，定义从该位置到末尾位置的最小分割数。

139. 句子是否可由词典中的词构成

    [detail](src/prob139wordbreak.md)

    **动态规划**

140. 句子的所有划分结果

    [detail](src/prob140wordbreak2.md)

    **动态规划**

    **深度搜索**

    **生成所有可能结果**

345. 反序句子中的元音字母

    [detail](src/prob345reversevowel.md)