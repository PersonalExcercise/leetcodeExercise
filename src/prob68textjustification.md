# problem 68. Text Justification

[题目链接](https://leetcode.com/problems/text-justification/)

## 方法

没有什么思维难度，就是把想的逻辑实现为代码逻辑。关键是想得清楚。


## 代码

```C++
class Solution {
public:
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        int sz = words.size();
        if(sz == 0 || maxWidth == 0){ return {""}; }
        vector<string> result;
        int startIdx = 0; 
        int curWordsLen = words[0].size(),
            curWordsCnt = 1; // [startIdx, startIdx + curWordsCnt)
        for(int i = 1; i < sz; ++i)
        {
            int leastLen = curWordsLen + curWordsCnt - 1;
            // try to add one word
            if(leastLen + words[i].size() + 1 <= maxWidth )
            {
                curWordsLen += words[i].size();
                ++curWordsCnt;
            }
            else
            {
                // can't fit
                // build previous line.
                string line = buildJustifiedLine(words, startIdx, curWordsCnt, 
                                                   curWordsLen, maxWidth);
                result.push_back(std::move(line));
                // update for new line
                startIdx = i;
                curWordsLen = words[i].size();
                curWordsCnt = 1;
            }
        }
        // last line
        string lastLine = words[startIdx];
        for(int i = startIdx + 1; i < sz; ++i)
        {
            lastLine.push_back(' ');
            lastLine.append(words[i]);
        }
        lastLine.append(string(maxWidth - curWordsLen - curWordsCnt + 1,' '));
        result.push_back(lastLine);
        return result;
    }
private:
    string buildJustifiedLine(const vector<string>& words, int startIdx, int wordCnt, 
                             int wordsTotalLen, int maxWidth)
    {
        int totalSpaceLen = maxWidth - wordsTotalLen;
        if(wordCnt == 1)
        {
            return words[startIdx] + string(totalSpaceLen, ' ');
        }
        int averageSpaceLen = totalSpaceLen / (wordCnt - 1);
        int oneMoreSpaceCnt = totalSpaceLen % (wordCnt - 1);
        string line =  "";
        for(int i = 0; i < wordCnt - 1; ++i)
        {
            line.append(words[startIdx+i]);
            int spaceLen = (i < oneMoreSpaceCnt) ? averageSpaceLen + 1 : averageSpaceLen;
            line.append(string(spaceLen, ' '));
        }
        line.append(words[startIdx + wordCnt - 1]);
        return line;
    }
};
```