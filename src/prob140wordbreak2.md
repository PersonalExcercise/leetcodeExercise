###problem 140 Word Break 2

[link](https://leetcode.com/problems/word-break-ii/)


### 方法


### 代码

超时了...

```C++
class Solution {
private :
    void addNewList(const vector< vector<string> > &prePosLists , const string & str , 
                    vector<vector<string>> &curPosLists)
    {
        for(const vector<string> &prePosList : prePosLists)
        {
            curPosLists.push_back(prePosList) ;
            curPosLists.back().push_back(str) ;
        }
        
    }
public:
    vector<string> wordBreak(string s, unordered_set<string>& wordDict) {
        size_t sLen = s.size() ,
               dictSize = wordDict.size() ;
        if(sLen == 0 || dictSize == 0) return {} ;
        size_t wordMaxAvailLen = 0 ;
        for(auto ite = wordDict.cbegin() ; ite != wordDict.cend() ; ++ite)
            wordMaxAvailLen = max( wordMaxAvailLen , (*ite).length()) ;
        vector< vector<vector<string> > > allPosList(sLen , vector<vector<string>>()); // ARRAY is not familiar
        for(size_t idx = 0 ; idx < sLen ; ++idx)
        {
            vector<vector<string> > &curPosList = allPosList[idx] ;
            curPosList.clear() ;
            
            string subStr = s.substr(0,idx+1) ;
            // 1. Test total substr 
            if(idx+1 <= wordMaxAvailLen )
            {
                if(wordDict.find(subStr) != wordDict.end())
                {
                    curPosList.push_back({subStr}) ;
                }
            }
            // 2. find all posible position
            int startSearchIdx = max( 1 , static_cast<int>(idx) - static_cast<int>(wordMaxAvailLen) + 1) ;
            for( ; startSearchIdx <= idx ; ++startSearchIdx)
            {
                string searchWord = subStr.substr(startSearchIdx) ;
                if( wordDict.find(searchWord) != wordDict.end() )
                {
                    // valid ! combine !
                    addNewList(allPosList[startSearchIdx-1] , searchWord , curPosList) ;
                }
            }
            
        }
        vector<string> retResult ;
        for(vector<string> &strVec : allPosList[sLen-1])
        {
            ostringstream os ;
            os << strVec[0] ;
            for(size_t i_idx = 1 ; i_idx < strVec.size() ; ++i_idx)
            {
                os << " " << strVec[i_idx] ;
            }
            retResult.push_back(os.str()) ;
        }
        sort(retResult.rbegin() , retResult.rend()) ;
        return retResult ;
    }
    
};
```