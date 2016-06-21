# problem 105. Construct Binary Tree from Preorder and Inorder Traversal

[题目链接](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)

## 方法

这道题应该是必须要会的吧！之前在编程之美中看到过，这次又遇到，递归的方法会了，但是迭代方法还不是很会。看了DISCUSS中的代码，大致明白了，尝试用更加清晰的代码描述出来。

**首先说递归版**

同样从先序遍历递归方法看起：

```C++
visit(root);
visit(root->left);
visit(root->right);
```

以上就是对根节点的递归遍历，我们不递归展开，而是仅从这个结构中可以看出，对于根节点，其先序遍历的结果有如下结构：

```XML
[ 根节点值 ]  [ 根节点左边的子孙节点构成的区块 ]  [ 根节点右边的子孙节点构成的区块 ]
```
所以，对根节点的遍历序列，第一个值必然是根的值，接着一个区块是左边子孙的值，最后一个区块是右边子孙的值。

我们拿到先序序列，立即可以构建根节点，但是却无法构建左孩子和右孩子！因为我们不知道左子孙区块和有子孙区块的边界！

这个时候就需要用上中序遍历的结果了！中序遍历的顺序为：

```C++
visit(root->left);
visit(root);
visit(root->right);
```

可知，其遍历结果如下：

```XML
[ 根节点左边的子孙节点构成的区块 ]  [ 根节点值 ]  [ 根节点右边的子孙节点构成的区块 ]
```

由先序遍历我们知道了根节点值，而树中不包含重复值，所以我们可以在中序遍历结果中定位到根节点。于是，我们就知道了左子孙节点的个数，右子孙节点的个数！

重复一下，通过中序遍历的结果，我们定位到根节点所在位置，然后得到左子孙节点和由子孙节点个数。

有了个数，我们再回到先序遍历的结果，显然左子孙节点和右子孙节点在中序、先序下个数是一致的。所以现在我们就可以完整划分出先序遍历的各个visit函数得到的结果序列，同时也得到了中序遍历的划分。

于是，我们就可以递归了，不是吗？对于先序序列，左子孙区块同样可以看做以左孩子为根的子树，同理右子孙区块。此时依然需要用到对应的中序遍历的区块划分结果。一个非常完美的、与递归遍历非常类似的构建方法。

代码见代码区递归部分。

**接着是迭代版**

我觉得现在我可以说出应该怎么做，但是不能保证把为什么要这么做说得透彻。

首先我们需要知道迭代的先序、中序遍历方法。

这里只用伪*伪代码*表示了：

先序

```C++
stack s ;
ptr = root ;
while(ptr != null || !s.empty())
{
    if(ptr != null)
    {
        visit(ptr);
        s.push(ptr);
        ptr = ptr->left;
    }
    else
    {
        // ptr == null , backtracing
        ptr = s.top();
        s.pop(); // pop , so only can backtracing from left child
        ptr = ptr->right ;
    }
}
```

中序

```C++
stack s ;
ptr = root ;
while(ptr != null || !s.empty())
{
    if(ptr != null)
    {
        s.push(ptr);
        ptr = ptr->left;
    }
    else
    {
        // ptr == null , backtracing
        ptr = s.top();
        visit(ptr);
        s.pop(); // pop , so only can backtracing from left child
        ptr = ptr->right ;
    }
}
```

可以看到二者唯一的差别就是访问节点时机的不同。先序在第一次遇到节点时就访问，中序在从节点左孩子回溯时访问。

所以，构建的一个关键点就是——如何根据中序节点和先序节点值，判断此刻是否是回溯阶段。

直观的想，第一次回溯必然发生在访问沿根节点一直往左孩子遍历直到左孩子为空的时刻。此时，先序已经得到了此路径上的所有层级节点值（所谓层级，就是指从root依次往下，树的深度变大），且最后一个就是此刻回溯的节点。而中序结果呢？在没有回溯发生时，中序为空。所以当回溯完成，中序节点有了第一个值，且此值等于此刻回溯节点的值。于是问题就清晰了，如果先序节点的值等于中序节点的值，那么此刻就发生了回溯。

重复一下，我们分别定义先序序列的指针和中序序列的指针，表示当前遍历的节点值，均初始化为0。然后一直移动先序序列指针（+1），表示我们一直在向左孩子方向遍历。如果，在某个时刻，先序指针指向的节点值与中序指针指向的值第一次相等了，那么说明此刻发生回溯。回溯时，由遍历方法可知，先序不会产生新节点值，而中序产生新值。故此刻应该移动中序指针（+1）。同时，在遍历时，回溯过后，我们需要弹栈并设置指向右孩子。那么考虑构建的情况，我们也需要构建一个堆栈，每访问一个先序节点，就push一个值进去。同时，在回溯时pop掉。接着，还需要考虑左右孩子的情况，首先我们需要设置一个标识位（布尔值），来表示当前构建的是左孩子还是右孩子。当回溯发生时，我们立即设置将要构建右孩子，其余情况下，我们都是在构建左孩子。此外，由于pop之后父亲节点在栈中就没有了，所以我们还需要设置一个指针来存储父亲节点。

似乎上面把这个构建过程已经说完了。说下顺序吧：

每次迭代

1. 首先需要判断是否是回溯，如果是，则设置将要处理右孩子的标识位，递增中序指针，设置父亲节点为栈顶，然后pop掉。开始下次迭代。
2. 如果不需要回溯，那么就必然要新建一个节点，递增先序指针。然后判断当前是构建左孩子还是右孩子。如果左孩子，则令父亲节点的左指针指向新建节点，否则右孩子指针指向新建节点，且如果是右孩子，在指向完成后，需要重新设置右孩子标识位为假，即下次开始构建左孩子。最后，更新父亲指针为新建节点。

迭代的停止条件？只要先序序列遍历完全就表示树已经构建完了。故可以令先序指针值小于节点个数。

具体见代码部分迭代版。

最后，说明资料来源：

递归版： 看的编程之美，DICUSS上第一个HOT应该也是，没有细看。

迭代版： [The iterative solution is easier than you think!](https://leetcode.com/discuss/2297/the-iterative-solution-is-easier-than-you-think) , 主题干里的代码很多冗余，建议看完整个网页。

## 代码

**递归版**

关键是明白原理后，找到左子孙节点、由子孙节点的先序、中序区间。使用了迭代器区间`[beg, end)`的方式。

56ms。

```C++
class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        return buildTreeRecursively(preorder.begin(), preorder.end(), inorder.begin(), inorder.end());
    }
private :
    TreeNode* buildTreeRecursively(vector<int>::iterator preorderBeginIter, 
                                   vector<int>::iterator preorderEndIter,
                                   vector<int>::iterator inorderBeginIter,
                                   vector<int>::iterator inorderEndIter)
    {
        if(preorderBeginIter == preorderEndIter){ return nullptr ;}
        // root
        int rootVal = *preorderBeginIter ;
        TreeNode *root = new TreeNode(rootVal) ;
        // find left and right range
        auto inorderRootIter = find(inorderBeginIter, inorderEndIter, rootVal);
        auto leftInorderBeginIter = inorderBeginIter,
             leftInorderEndIter = inorderRootIter , // [ beg, end  )
             rightInorderBeginIter = inorderRootIter + 1,
             rightInorderEndIter = inorderEndIter;
        auto leftPreorderBeginIter = preorderBeginIter + 1,
             leftPreorderEndIter = leftPreorderBeginIter + ( leftInorderEndIter - leftInorderBeginIter ),
             rightPreorderBeginIter = leftPreorderEndIter ,
             rightPreorderEndIter = preorderEndIter;
        // left
        root->left = buildTreeRecursively(leftPreorderBeginIter, leftPreorderEndIter,
                                          leftInorderBeginIter, leftInorderEndIter);
        root->right = buildTreeRecursively(rightPreorderBeginIter, rightPreorderEndIter,
                                           rightInorderBeginIter, rightInorderEndIter);
        return root;
    }
};
```

**迭代版**

应该非常清晰，且没有冗余。

20ms，没有达到最快。不过方法上应该是最优的吧。

```C++
class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        size_t nrNode = preorder.size() ; // assert(preorder.size() == inorder.size())
        if(nrNode == 0) return nullptr;
        
        stack<TreeNode *> s ;
        TreeNode * parentNode = nullptr;
        
        size_t preorderPos ,
               inorderPos = 0 ;
        // init
        TreeNode *root = new TreeNode(preorder.at(0)) ;
        s.push(root);
        parentNode = root ;
        preorderPos = 1 ;
        
        // Iterate
        bool nextToHandleRightChild = false ;
        while(preorderPos < nrNode)
        {
            if(!s.empty() && s.top()->val == inorder.at(inorderPos))
            {
                // backtracing process 
                ++inorderPos ;
                parentNode = s.top() ;
                s.pop() ;
                nextToHandleRightChild = true;
            }
            else
            {
                // visit node process
                TreeNode *childNode = new TreeNode(preorder.at(preorderPos));
                ++preorderPos ;
                s.push(childNode);
                if(nextToHandleRightChild)
                {
                    parentNode->right = childNode ;
                    nextToHandleRightChild = false ;
                }
                else
                {
                    parentNode->left = childNode;
                }
                parentNode = childNode ;
            }
        }
        return root ;
    }
};
``` 


## 后记

还有一道题，根据中序和后序遍历结构重建树。

递归版本跟这道题应该完全一致，只是根节点跑到最后一个位置了。

然而迭代版本呢？需要再仔细看下。