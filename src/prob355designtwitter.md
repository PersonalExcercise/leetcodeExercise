# problem 355. Design Twitter

[题目链接](https://leetcode.com/problems/design-twitter/)

## 方法

很简单的题目... 有点坑的就是！根本没有什么invalid的操作！！不要被它的注释吓到了然后想一些看起来不合法的操作..

## 代码

```C++
class Twitter {
public:
    using TweetId = int;
    using UserId = int;
    size_t feedNumLimit = 10;
public:
    /** Initialize your data structure here. */
    Twitter() {}
    
    /** Compose a new tweet. */
    void postTweet(int userId, int tweetId) {
        tweetList.push_back(tweetId);
        tweet2user[tweetId] = userId;
    }
    
    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    vector<int> getNewsFeed(int userId) {
        unordered_set<UserId> &followSet = userFollowSetMap[userId];
        size_t feedCnt = 0;
        int tweetIdx = tweetList.size() - 1;
        vector<TweetId> feeds;
        while(feedCnt < feedNumLimit && tweetIdx >= 0)
        {
            TweetId tweet = tweetList[tweetIdx];
            UserId user = tweet2user[tweet];
            if(user == userId || followSet.count(user) > 0)
            {
                feeds.push_back(tweet);
                ++feedCnt;
            }
            --tweetIdx;
        }
        return feeds;
    }
    
    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    void follow(int followerId, int followeeId) {
        // what is invalid ?
        userFollowSetMap[followerId].insert(followeeId);
        if(userFollowSetMap.count(followeeId) == 0){ userFollowSetMap[followeeId];  }
    }
    
    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    void unfollow(int followerId, int followeeId) {
        userFollowSetMap[followerId].erase(followeeId);
    }
private:
    vector<TweetId> tweetList;
    unordered_map<TweetId, UserId> tweet2user;
    unordered_map<UserId, unordered_set<UserId>> userFollowSetMap;
};
```