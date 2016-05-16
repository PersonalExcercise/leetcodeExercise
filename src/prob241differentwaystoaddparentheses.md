###problem 241. Different Ways to Add Parentheses 

[link](https://leetcode.com/problems/different-ways-to-add-parentheses/)

## 方法

分治算法的核心是将大问题分解为小问题，通过求解小问题，再合并小问题的解，得到大问题的解。

通常地，一般一个问题，将其分为两部分！

这里，考虑最小的情况。对于加括号，当只有两个数时，加括号只有一种方法。

那么，大问题化小问题的关键，就是将长串在每个运算符的位置分解为左右两个部分，作为两个“数”。如此递归，终结条件可以是只含两个操作数或者只含一个操作数，对这道题更简单的方法当然是将终结条件设置为只含一个操作数。

合并时也非常简单，做一个左右两边解集合的笛卡尔乘积，就是两个for循环的组合。

---------分割线-------------

orz，完全懵逼的题。太菜。

之前一直在苦苦地思考用递归方法，试图自顶向下地求解。视图每次递归合并一个数，将整个字符串合并连个操作数后作为下次递归的输入。这样为问题就是重复，然后自己就一直在想怎么去重...

忘了分治算法的核心！分治算法的核心，其实仍然是自底向上的求。一定是求解子问题，再往上合并。这或许也说明了自己的思维方式，总是要陷入细节，不能宏观去分配一件事情。不行不行，得学习啊！


## 代码

```C++
class Solution {
public:
    vector<int> diffWaysToCompute(string input) {
        return solverUsingDivideAndConquer(input) ;
    }
private :
    size_t getFirstNumber(const string::const_iterator &beg_iter , const string::const_iterator &end_iter , int &number)
    {
        auto iter = beg_iter ; 
        if(iter >= end_iter) return 0 ;
        while(iter != end_iter && isdigit(*iter)) ++iter ;
        number = stol(string(beg_iter , iter)) ;
        return end_iter - beg_iter ;
    }
    
    bool isOp(char op_char) 
    {
        return op_char == '+' || op_char == '-' || op_char == '*' ;
    }
    
    string::const_iterator getNextOpIter(const string::const_iterator &begin_iter , const string::const_iterator &end_iter)
    {
        string::const_iterator iter = begin_iter ;
        while(iter != end_iter && !isOp(*iter)) ++iter ;
        return iter ;
    }
    
    int compute(int num1 , int num2 , char op)
    {
        switch(op)
        {
            case '+' :
                return num1 + num2 ;
                break ;
            case '-' :
                return num1 - num2 ;
                break ;
            case '*' :
                return num1 * num2 ;
                break ;
            default :
                cerr << "illegal operator " + op << endl ;
                throw runtime_error("illegal operator " + op) ;
        }
    }
    
    vector<int> solverUsingDivideAndConquer(string input)
    {
        string::const_iterator opIter = getNextOpIter(input.cbegin() , input.cend()) ;
        if(opIter == input.cend())
        {
            int num ;
            size_t num_len = getFirstNumber(input.cbegin() , input.cend() , num) ;
            if(0 == num_len)
            {
                cerr << "unexpeted to get first number , for input : " + input << endl ;
                throw runtime_error("unexpeted to get first number , for input : " + input) ;    
            } 
            return { num } ;
        }
        vector<int> rst ,
                    leftRst , 
                    rightRst ;
        while(opIter != input.cend())
        {
            // divide
            leftRst = solverUsingDivideAndConquer(string(input.cbegin() , opIter)) ;
            rightRst = solverUsingDivideAndConquer(string(opIter+1 , input.cend())) ;
            
            // merge 
            for(vector<int>::const_iterator lIter = leftRst.cbegin() ; lIter != leftRst.cend() ; ++lIter )
            {
                for(auto rIter = rightRst.cbegin() ; rIter != rightRst.cend() ; ++rIter)
                {
                    rst.push_back(compute(*lIter , *rIter , *opIter)) ;
                }
            }
            opIter = getNextOpIter(opIter + 1 , input.cend()) ;
        }
        
        return rst ;
    }
};
```