###problem 2. Add Two Numbers

[link](https://leetcode.com/problems/add-two-numbers/)

## 方法

非常直观的题，很简答...

一个需要搞清楚的就是，链表表示的数，第一位对应最低位，第二位对应次低位，最后一位代表最高位。

这样，从低位对齐后，直接从后往后加即可，与合并多项式类似。

唯一觉得需要注意的就是加完后依然需要检查进位！当时思考时没注意，不过写代码时想到了。

代码永远是有最完整的逻辑的。

## 代码

```C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        ListNode *root = nullptr , 
                 *cur_pos = root ;
        ListNode *p1 = l1 , 
                 *p2 = l2 ;
        int carry = 0 ;
        while(p1 != nullptr && p2 != nullptr)
        {
            int bit_rst = p1->val + p2->val + carry ;
            carry = bit_rst / 10 ;
            bit_rst %= 10 ;
            ListNode *pos = new ListNode(bit_rst) ;
            if(!root)
            { 
                root = pos ; 
                cur_pos = root ;
            }
            else 
            {
                cur_pos->next = pos ;
                cur_pos = cur_pos->next ;
            }
            p1 = p1->next ;
            p2 = p2->next ;
        }
        while(p1)
        {
            int bit_rst = p1->val + carry ;
            carry = bit_rst / 10 ;
            bit_rst %= 10 ;
            ListNode *pos = new ListNode(bit_rst) ;
            if(!root)
            { 
                root = pos ; 
                cur_pos = root ;
            }
            else 
            {
                cur_pos->next = pos ;
                cur_pos = cur_pos->next ;
            }
            p1 = p1->next ;
        }
        while(p2)
        {
            int bit_rst = p2->val + carry ;
            carry = bit_rst / 10 ;
            bit_rst %= 10 ;
            ListNode *pos = new ListNode(bit_rst) ;
            if(!root)
            { 
                root = pos ; 
                cur_pos = root ;
            }
            else 
            {
                cur_pos->next = pos ;
                cur_pos = cur_pos->next ;
            }
            p2 = p2->next ;
        }
        if(carry)
        {
            ListNode *pos = new ListNode(carry) ;
            if(!root)
            { 
                root = pos ; 
                cur_pos = root ;
            }
            else 
            {
                cur_pos->next = pos ;
                cur_pos = cur_pos->next ;
            }
        }
        return root ;
    }
};
```