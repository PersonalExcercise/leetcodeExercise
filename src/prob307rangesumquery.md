# problem 307. Range Sum Query - Mutable

[题目链接](https://leetcode.com/problems/range-sum-query-mutable/)


## 方法

想不到就这样与`segment tree`不期而遇。

在做这道题之前，真的一点也没有听说过这个名字。但是看过这道题后，发现线段树却是如此常用？

关于线段树，尝试看了维基百科，觉得没看太清楚，看了题解里提到的[Segment Tree | Set 1 (Sum of given range)](http://www.geeksforgeeks.org/segment-tree-set-1-sum-of-given-range/)，觉得讲得很好。今天给实现了一下。发现了一个问题，就是这种递归构建segment tree 的方法会导致一定的空间冗余——即本来值需要 2n - 1 的空间，但是却不得不申请 `2 * pow( ceil( log2 (n) ) ) - 1` 的空间（对用数组表示树而言）。

相反，在上述实现完成后，看了LeetCode官方题解： [307. Range Sum Query - Mutable](https://leetcode.com/articles/range-sum-query-mutable/#approach-2-sqrt-decomposition-accepted)， 发现其使用的是自底向上的构建方法。

## 代码

```C++
class SumSegmentTree
{
public:
    SumSegmentTree(const vector<int> &rawData)
        : rawData(rawData)
    {
        buildTree();      
    }

    SumSegmentTree(vector<int> &&rawDataRref)
        : rawData(std::move(rawDataRref))
    {
        buildTree();
    }

    void updateNodeVal(int rawDataIndex, int newNodeVal)
    {
        if(!checkRawDataIndex(rawDataIndex))
        { 
            string errMsg = string("raw data index ");
            errMsg += to_string(rawDataIndex);
            errMsg += " is out of range";
            throw out_of_range(errMsg);
        }
        int increment = newNodeVal - rawData[rawDataIndex];
        rawData[rawDataIndex] = newNodeVal;
        updateTreeNodeVal(make_pair(0, rawData.size() - 1), 0, rawDataIndex, increment);
    }

    int queryRangeSum(int rangeStart, int rangeEnd) // [rangeStart, rangeEnd] -> inclusive
    {
        return queryRangeSumRecursively(make_pair(rangeStart, rangeEnd), 
            make_pair(0, rawData.size() - 1), 0);
    }
private:
    using Range = pair<int, int>;
    void buildTree()
    {
        int nrTreeNode = 2 * pow(2, ceil( log2(rawData.size()) ) ) -1  ;
        if(nrTreeNode < 0){ return; } // -> rawData.size() == 0
        treeData.resize(nrTreeNode);
        buildTreeNodeRecursively(Range(0, rawData.size() - 1), 0);
    }

    int buildTreeNodeRecursively(const Range &nodeRange, int treeNodeIndex)
    {
        if(nodeRange.first == nodeRange.second)
        {
            // leaf node
            treeData.at(treeNodeIndex) = rawData.at(nodeRange.first);
        }
        else
        {
            int treeLeftChildIndex = getTreeLeftChildIndex(treeNodeIndex),
                treeRightChildIndex = getTreeRightChildIndex(treeNodeIndex);
            int rangeMidVal = getRangeMidVal(nodeRange);
            Range leftRange(nodeRange.first, rangeMidVal),
                rightRange(rangeMidVal + 1, nodeRange.second);
            treeData.at(treeNodeIndex) = buildTreeNodeRecursively(leftRange, treeLeftChildIndex) + // left
                buildTreeNodeRecursively(rightRange, treeRightChildIndex);// right
        }
        return treeData[treeNodeIndex];
    }

    int getTreeLeftChildIndex(int parentIndex)
    {
        return parentIndex * 2 + 1;
    }

    int getTreeRightChildIndex(int parentIndex)
    {
        return parentIndex * 2 + 2;
    }

    int getRangeMidVal(const Range& range)
    {
        return range.first + (range.second - range.first) / 2;
    }

    bool checkRawDataIndex(int index)
    {
        return index >= 0 && static_cast<size_t>(index) < rawData.size();
    }
    void updateTreeNodeVal(const Range &nodeRange, int treeNodeIndex, int rawDataIndex, int increment)
    {
        if(rawDataIndex < nodeRange.first || rawDataIndex > nodeRange.second){ return; } // irrelevant
        treeData[treeNodeIndex] += increment;
        if(nodeRange.first < nodeRange.second)
        {
            int rangeMidVal = getRangeMidVal(nodeRange);
            Range leftRange(nodeRange.first, rangeMidVal),
                rightRange(rangeMidVal + 1, nodeRange.second);
            int treeLeftChildIndex = getTreeLeftChildIndex(treeNodeIndex),
                treeRightChildIndex = getTreeRightChildIndex(treeNodeIndex);
            updateTreeNodeVal(leftRange, treeLeftChildIndex, rawDataIndex, increment);
            updateTreeNodeVal(rightRange, treeRightChildIndex, rawDataIndex, increment);   
        }
    }

    int queryRangeSumRecursively(const Range &queryRange, const Range &nodeRange, int treeNodeIndex)
    {
        if(nodeRange.first >= queryRange.first && nodeRange.second <= queryRange.second)
        {
            // node range is all in query range
            return treeData[treeNodeIndex];
        }
        if(nodeRange.first > queryRange.second || nodeRange.second < queryRange.first)
        {
            // node range is totally out of query range
            return 0;
        }
        // node range partially overlap  query range , split node range
        int rangeMidVal = getRangeMidVal(nodeRange);
        Range leftRange(nodeRange.first, rangeMidVal),
            rightRange(rangeMidVal + 1, nodeRange.second);
        int treeLeftChildIndex = getTreeLeftChildIndex(treeNodeIndex),
            treeRightChildIndex = getTreeRightChildIndex(treeNodeIndex);
        return queryRangeSumRecursively(queryRange, leftRange, treeLeftChildIndex) +
            queryRangeSumRecursively(queryRange, rightRange, treeRightChildIndex);
    }

private:
    vector<int> rawData;
    vector<int> treeData;
};


class NumArray {
public:
    NumArray(vector<int> &nums) 
    : segTree(std::move(nums))
    {
    }

    void update(int i, int val) {
        segTree.updateNodeVal(i, val);
    }

    int sumRange(int i, int j) {
        return segTree.queryRangeSum(i, j);
    }
private:
    SumSegmentTree segTree;
};

```

## 后记

`make_pair`时出错了... 因为它是个模板函数，其实可以不用传模板参数的，但是我传了，而且传错了！不过这个错误很隐蔽，感觉对于理解C++很有意义。

如下：

```C++
make_pair<int, int>(i, j) // -> error , cannot convert 'i' (type 'int') to type 'int&&'
make_pair<int&, int&>(i, j) // right
make_pair<int, int>(std::move(i), std::move(j)) // right
```

总结来说，对于`int`, 其实编译器会默认解释为`int &&` （C++11）,即右值引用，这导致左值绑定错误了。怎么会呢？左值引用绑定到右值引用不行吗？ 经过代码测试，是的：

```C++
void processRVal(int && rv)
{
}
int main(int argc, char *argv[])
{
    processRVal(1);
    int i = 0;
    processRVal(i);
    return 0;
}
// error: cannot bind 'int' lvalue to 'int&&'
```

由上面的编译报错，可知这的确是不能绑定的！想想也对，右值表示的是这个值在后续都不会被用到了——如用右值做初始化，会改变原始值的内容（move）——所以将左值引用绑定到右值上，的确应该被禁止。

只不过，我们是可以把右值引用绑定到const 左值引用上，而在之前的C++标准中，我们会把const 左值引用当作可接受任意参数的类型，但是到了C++11就不行了。

最后总结： 自动类型推导时，字面值会被当作右值引用，有名字的变量（即使从上下文可知是右值，如右值参数）会被当作左值引用。