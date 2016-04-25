###problem 140 Word Break 2

[link](https://leetcode.com/problems/word-break-ii/)


### 方法

一般的动态规划问题，问的可能都是能不能、或者是最优解的问题。类似与Word Break I 便是能不能切分的问题。或者梢进一步，问下最优解下的路径，这时只需一个开个矩阵记录一下到此步时的前一个状态，最后回溯一遍即可。不过，这里就更进了一步，问的是能不能解的问题下的全部解问题！

之前一直磕磕绊绊，折腾了好久，终于明白。这个跟求最优解的路径是完全一样的，只不过求最优解时我们只会保留一个前向状态，在求此问题时，我们保留所有的状态即可。

这时，唯一没有遇到过的就是此时该如果回溯。非常简单，其实就是一个搜索问题，DFS、BFS均可，当然DFS应该更省内存一些。

使用DFS做搜索，使用循环+栈来代替递归。栈中放已经搜索的状态，这里就是前一个划分的位置序列。设DP得到的状态记录为R。其在每个位置，如果该位置可划分，则记录了该位置上前一个划分位置的所有可能；如果不可划分，为空。

1. 初始时 , 对最后一个一个位置的R记录里的所有值，对应创建一个状态
2. 只要栈不空，开始以下循环：

    1. 取栈顶元素，为一个划分序列（状态）
    2. 从划分序列中取出最前面的划分位置
    3. 如果该位置为-1，说明已经到达最前端，此状态为终结状态，将此划分结果放入结果列表
    4. 如果不为-1，则取出此位置的R记录里的值，对每个值，创建一个新的状态，此状态为 "取出状态+该值" 的结果

之前写代码时犯了一个错误，就是在DP过程中不断地合并结果。如果这样做了，到最后一部搜索时，应该是可以直接得到结果的。但是这样的话会产生巨大的中间结果。具体会怎样我也不知道...

### 代码

beats 75.56% 的C++用户，感觉吊吊的~

```C++
class Solution {
public:
    vector<string> wordBreak(string s, unordered_set<string>& wordDict) {
        size_t sLen = s.length() , 
               dictSize = wordDict.size() ;
        if( 0 == sLen || 0 == dictSize) return {} ;
        size_t maxWordLen = 0 ;
        for(auto ite = wordDict.cbegin() ; ite != wordDict.cend() ; ++ite)
            maxWordLen = max(maxWordLen , ite->length()) ;
        vector<vector<int>> R(sLen) ;
        // build records
        for(int pos = 0 ; pos < sLen ; ++pos)
        {
            for(int testWordLen = 1 ; testWordLen <= maxWordLen ; ++testWordLen)
            {
                int startPos = pos - testWordLen + 1 ;
                if(startPos < 0) break ;
                string testWord = s.substr(startPos , testWordLen) ;
                if( wordDict.find(testWord) != wordDict.end() && ( startPos == 0 || R[startPos-1].size() > 0  ) )
                {
                    R[pos].push_back(startPos -1) ;
                }
            }
        }
        // find all possible split
        // DFS
        vector<string> rst ;
        stack<vector<int>> stateStack ;
        // init stack
        for(int prePos : R[sLen-1])
        {
            stateStack.push({ prePos }) ;
        }
        while(!stateStack.empty())
        {
            vector<int> curState = stateStack.top() ;
            stateStack.pop() ;
            // generate the continues
            int firstPos = curState.back() ;
            if(firstPos == -1)
            {
                // finish one search !
                rst.push_back(generate_split_str(s , curState)) ;
            }
            else
            {
                // generate 
                for(int newSplit : R[firstPos])
                {
                    vector<int> newState(curState) ;
                    newState.push_back(newSplit) ;
                    stateStack.push(newState) ;
                }
            }
            
        }
        return rst ;
    }
private :
    string generate_split_str(const string &s , const vector<int> &reverse_pos)
    {
        auto ite = reverse_pos.crbegin() ;
        ++ite ; // -1
        if(ite == reverse_pos.crend())
        {
            // only -1 , means the total s is a word
            return s ;
        }
        ostringstream os ;
        int startPos = 0 ;
        for( ; ite != reverse_pos.crend() ; ++ite)
        {
            int len = *ite - startPos + 1 ;
            os << s.substr(startPos , len) << " " ;
            startPos = *ite + 1;
        }
        os << s.substr(startPos) ;
        return os.str() ;
    }
};
```