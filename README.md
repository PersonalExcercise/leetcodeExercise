# leetcodeExercise

2. 两数相加
    
    [detail](src/prob2add2numbers.md)

    **链表** *数学*

12. 整数转罗马数字
    
    [detail](src/prob12integer2roman.md)

    **转换**

13. 罗马数字转整数

    [detail](src/prob13roman2integer.md)

26. Unique操作

    **两指针** **unique**

    [detail](src/prob26removeduplicatesfromsortedarray.md)

35. 确定插入位置

    **二分查找** ； **插入**

    **二分查找违背条件而退出时，必然有`low=high+1`**

    **循环条件是小于等于**

    [detail](src/prob35searchinsertposition.md)

39. 从集合中找出一些数使得其和为某个值，找出的数集合彼此不能重复

    **递归** , **组合**

    **回溯**

    [detail](src/prob39combinationsum.md)

40. 从数组中找出一些数，每个数至多选中一次，找出的数集合彼此不能重复

    **递归** ， **组合**

    **回溯**

    [detail](src/prob40combinationsumII.md)

44. 通配符匹配

    [detail](src/prob44wildcardmatching.md)

    **动态规划** —> 慢

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

57. 插入区间到一个区间序列中

    [detail](src/prob57insertinterval.md)

    **数组**

    **区间** ， **插入**

60. 找到第k个n位随机数（排列数）

    [detail](src/prob60permutationsequence.md)

    **数学**；**枚举**；**规律**

    **类·进制转换**


62. 到达目标的不同路径

    [detail](src/prob62uniquepaths.md)
    
    **动态规划**

    **组合**

63. 有障碍情况下到达目标的不同路径
    
    **动态规划**

    [detail](src/prob63uniquepaths2.md)


64. 给定一个代价矩阵，从起点到终点（左右、上下只能取1个方向），求最小代价及相应的路径
    
    [detail](src/prob64minpathsum.md)

    **动态规划**

    到每个位置的最小代价，与其左（或右）和其上（下）的点有关。


69. 求一个整数的非精确平方根。 int sqrt(int x)

    [detail](src/prob69sqrt.md)

    **二分** ; **分治（剪枝）** 

70. 爬梯子的方法

    [detail](src/prob70climbingstairs.md)

    **动态规划** ； **类-斐波拉切**

72. 编辑距离

    [detail](src/prob72editdistance.md)

    **动态规划** ； 

    *经典*

77. 生成c(n,k)的所有可能

    [detail](src/prob77combinations.md)

    **组合**； **回溯** ； **递归与迭代**

80. uniq升级版——允许两次重复

    [detail](src/prob80removeduplicatesfromsortedarraysII.md)

    **双指针**

    **两种思维方式** ， **容器end()调用耗时显著性**

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

89. Gray Code 生成n位格雷码

    [detail](src/prob89graycode.md)

    **递归**

    **格雷码**


91. 解码方法数

    [detail](src/prob91decodeways.md)

    **动态规划**；**递推**；

94. 树的中序（非递归）遍历
    
    [detail](src/prob94binarytreeinordertraversal.md)

    **中序遍历**； **非递归树遍历**

97.  一个字符串是否有其他两个字符串交叉组合而成

     [detail](src/prob97interleavingstring.md)

     动态规划；

     *Hard*

98. 验证是否是二叉查找树

    [detail](src/prob98validBST.md)

    **二叉查找树，BST**

105. 从先序遍历序列和中序遍历序列重建二叉树

    [detail](src/prob105constructbinarytreefrompreorderandinordertraversal.md)

    **二叉树** ； **建树**； **先序遍历**； **中序遍历**； **遍历规律**

108. 有序数组转为平衡的二叉查找树

    [detail](src/prob108convertsortedarray2bst.md)

    **二叉查找树，BST**

    **转换** ， **逆向** ， **数组**

109. 有序链表转为平衡二叉查找树

    [detail](src/prob109convertsortedlist2bst.md)

    **二叉查找树**

    **转换** ， **逆向** ， **中序遍历** ， **链表**

114. 把一棵二叉树转为一个先序遍历结果的链表

    **先序遍历**+记录前一个节点 ； **后序遍历** 右左根 = r(根左右)

    [detail](src/prob114flattenbinarytree2linkedlist.md)


115. 计数：与一个串相同的不同子串数量

    [detail](src/prob115distinctsubsequences.md)

    **动态规划** ； 

    **题目不清**；

116. 给完全二叉树每个节点找到每层右边的节点

    [detail](src/prob116populatingnextrightpointersineachnode.md)

    **树**

    **类·层序遍历** ； **常量空间**

117. 给任意一颗二叉树每个节点找到每层右边的节点

    [detail](src/prob117populatingnextrightpointersineachnodeII.md)
    
    **树**

    **类·层序遍历** ； **常量空间**

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

145. 二叉树的后序非递归遍历

    [detail](src/prob145BSTpostorder.md)

    **树的后序遍历**

    *判断上一个访问的节点是否是其右孩子，如果是则说明是从右回溯

148. 排序链表

    [detail](src/prob148sortlist.md)

    **归并排序**；**链表**；**非递归归并排序**

151. 反转句子中的单词顺序

    [detail](src/prob151reversewordsinastring.md)

    **双重反转**

    **块反转**


152. 最大乘积的子数组

    [detail](src/prob152maximumproductsubarray.md)

    **最大XX子数组**

    **动态规划** （模式：以该位置结尾的子序列）

160. 找两个无环链表第一个相交节点

    [detail](src/prob160intersectionoftwolinkedlists.md)

    **两个无环链表第一个相交节点**

164. 线性时间找到未排序数组的排序位置下最大相邻间隔

    [detail](src/prob164maximumgap.md)

    **线性时间排序**

    **桶排序** ； **浮点数不精确**

173. 二叉查找树迭代器

    [detail](src/prob173binarysearchtreeiterator.md)

    **二叉查找树**； **迭代器实现**

    **中序遍历二叉查找树得到递增序列**

174. 地牢游戏

    [detail](src/prob174dungeongame.md)

    **动态规划**

179. 拼成一个最大数

    [detail](src/prob179largestnumber.md)

    **排序**！！

191. 二进制数中1的个数/ 汉明重量(Hamming Weight) / popcount

    
    [detail](src/prob191numberof1bits.md)

    **位操作**

    **有背景的题** **__builtin_popcount/std::bitset<32>**

200. 海中岛的数量

    [detail](src/prob200numbersofislands.md)
    
    **连通路径**

    **遍历**

216. 从1-9中找出k个不同的数，使得其和为n

    **递归**

    **回溯**

    [detail](src/prob216combinationsumIII.md)

221. 0，1矩阵全为1的最大正方形面积

    
    **动态规划**

    [detail](src/prob221maximalsquare.md)


241. 加括号的不同方法
    
    **分治** **DP<未完成>**

    [detail](src/prob241differentwaystoaddparentheses.md)

242. 判断一个单词是否是另一个单词的易位构词(anagram)

    **hash_table**计数

    **排序** ！！

    [detail](src/prob242validanagram.md)

290. 判断两个字符串模式是否相同

    **HashTable**

    [detail](src/prob290wordpattern.md)

300. 最长递增子序列 LIS

    **经典**

    **最长递增子序列**
    
    [detail](https://leetcode.com/problems/longest-increasing-subsequence/)

306. 是否是加数字符串

    **逻辑**

    **数学** ， **加法** ， *大数*
    
    [detail](src/prob306additivenumber.md)


329. 求矩阵中最长递增序列的长度

    [detail](src/prob329longestincreasingpathinmatrix.md)

    **拓扑排序**

    **DFS**

    **Memoization**

331. 验证一棵树的先序遍历得到的序列化串是否合法

    [detail](src/prob331verifypreorderserializationofabinarytree.md)

    **先序遍历满足的性质**

    **入度与出度** **巧妙**

    **栈**

334. 是否有 三数递增

    **三数递增**

    [detail](sec/prob334increasingtriplesubsequence.md)

343. 分解整数

    **怎么分解整数n使得其和为n而其乘积最大**——数学推导！

    [detail](src/prob343integerbreak.md)

345. 反序句子中的元音字母

    [detail](src/prob345reversevowel.md)

    **双指针**

354. 俄罗斯套娃，能套多少个

    [detail](src/prob354russiandolldollenvelope.md)

    **二维元素的排序+LIS**

    **最长递增序列问题**