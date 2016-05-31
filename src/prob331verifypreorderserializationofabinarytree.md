# problem 331. Verify Preorder Serialization of a Binary Tree

[link](https://leetcode.com/problems/verify-preorder-serialization-of-a-binary-tree/)

## 方法

自己想的非常low的方法... 直接采用先序遍历的思想去验证：

1. 读取一个节点
2. 如果是`#`，则返回真 
3. 如果不是,则入栈 , 递归调用（左孩子），递归调用返回后，验证返回状态（真），栈是否为空，栈顶是否就是当前值，为假则返回假
4. 继续递归调用（右孩子），同样检查
5. 返回真
6. 返回检查结果，以及**最后字符串是否为空**

加粗的部分很重要，因为上述的逻辑解决不了字符串对于的情况——如`1,#,#,1` ， 如果不检查字符串是否非空，则会返回true... 第一次提交就这么错了...

不过这么写完感觉还是有些毛病，也没细想了...

因为看了DISCUZZ的代码，觉得太牛了。

[根据入度出度的检查](https://leetcode.com/discuss/83824/7-lines-easy-java-solution) , 就是每个非叶节点提供2个出度，一个入度，而每个叶节点只提供1个入度。只需本次检查出度与入度的差大于等于0即可。最后要求该差值为0。

应该是非常巧妙的算法了。不是很直观，但是应该是有效的。不是偶然。

## 代码

```C++
class Solution {
public:
    bool isValidSerialization(string preorder) {
        stack<int> s ;
        bool is_null ;
        int val ;
        return visit(preorder , s , is_null , val) && preorder.length() == 0 ;
    }
private :
    bool visit(string &str , stack<int> &s , bool &is_null , int &val)
    {
        if(str.length() == 0) return s.empty() ;
        size_t comma_pos = str.find(",") ;
        string node_str = str.substr(0,comma_pos) ;
        if(comma_pos != string::npos){ str = str.substr(comma_pos+1) ;}
        else { str = "" ;}
        if(node_str == string("#"))
        {
            is_null = true ;
            val = 0 ;
            return true ;
        }
        val = stol(node_str) ;
        s.push(val) ;
        bool lchild_isnull ,
             rchild_isnull ;
        int lval ,
            rval ;
        bool lstatus ,
             rstatus ;
        lstatus = visit(str , s , lchild_isnull , lval) ;
        if(lstatus == false) return false ;
        if( s.empty() || s.top() != val ) return false ;
        rstatus = visit(str , s , rchild_isnull , rval) ;
        if(rstatus == false) return false ;
        if( s.empty() || s.top() != val) return false ;
        /*
        if(!lchild_isnull && lval >= val) return false ;
        if(!rchild_isnull && rval <= val) return false ;
        */
        s.pop() ;
        return true ;
    }
};
```
