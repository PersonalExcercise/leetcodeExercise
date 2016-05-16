###problem 329. Longest Increasing Path in a Matrix

[link](https://leetcode.com/problems/longest-increasing-path-in-a-matrix/)

## 方法

总结来说，暴力深度搜索+缓存可以解决的问题。

当时看了题纠结了半天，想着分别以每个点为起点搜索一下。问了下学弟，他说建模成图，变为图上的搜索。

当时听到他说建模成图，一下子就震惊了。真是思维的差距啊。

后来自己琢磨，就想着这应该与拓扑排序有关。

看了题解，似乎DFS+缓存就能完成。然而自己还是想写拓扑排序。

结果终于写了个很ugly的代码，220ms通过，打败了18%的用户... 

不过，不管怎么ugly，总比纠结着却什么都没做好啊。

## 代码

```C++
class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if(0 == matrix.size()) return 0 ;
        size_t nr_row = matrix.size() ,
               nr_col = matrix[0].size() ;
        vector<Node> nodes(nr_row*nr_col) ;
        
        // build nodes
        auto get_flat_idx = [=](int row , int col){ return row * nr_col + col ;} ;
        for(size_t row=0 ; row < nr_row ; ++row)
        {
            for(size_t col=0 ; col < nr_col ; ++col)
            {
                int val = matrix[row][col] ;
                int cur_idx = get_flat_idx(row , col) ;
                Node &cur_node = nodes[cur_idx] ;
                // up
                if(row >=1 && matrix[row-1][col] < val)
                {
                    int parent_idx = get_flat_idx(row-1 , col) ;
                    cur_node.add_parent(&nodes[parent_idx]) ;
                }
                // down
                if(row < nr_row - 1 && matrix[row+1][col] < val)
                {
                    int parent_idx = get_flat_idx(row+1 , col) ;
                    cur_node.add_parent(&nodes[parent_idx]) ;
                }
                // left
                if(col >= 1 && matrix[row][col-1] < val)
                {
                    int parent_idx = get_flat_idx(row , col -1) ;
                    cur_node.add_parent(&nodes[parent_idx]) ;
                }
                // right
                if(col < nr_col -1 && matrix[row][col+1] < val)
                {
                    int parent_idx = get_flat_idx(row , col + 1) ;
                    cur_node.add_parent(&nodes[parent_idx]) ;
                }
            }
        }
        //for_each(nodes.begin() , nodes.end() , [](Node &n){ cout << n.children_num << " " ; } ) ;
        //cout << endl ;
        // topological
        unsigned height = 0 ;
        while(true)
        {
            vector<Node*> leaves ;
            for(size_t i = 0 ; i < nr_row * nr_col ; ++i)
            {
                if(!nodes[i].is_removed && nodes[i].is_leaf())
                {
                    leaves.push_back(&nodes[i]) ;
                }
            }
            if(0 == leaves.size()) break ;
            ++height ;
            for_each(leaves.begin() , leaves.end() , [](Node * &n){ n->remove_self() ; }) ;
            
            //for_each(nodes.begin() , nodes.end() , [](Node &n){ cout << n.children_num << " " ; } ) ;
            //cout << endl ;
        }
        return height ;
    }
private:
    struct Node
    {
       vector<Node *> parents ;
       unsigned children_num ;
       bool is_removed ;
       Node():parents() ,children_num(0),is_removed(false){}
       void add_parent(Node *p)
       {
           parents.push_back(p) ;
           ++p->children_num ;
       }
       bool is_leaf(){ return children_num == 0 ;}
       void remove_self()
       {
           for(Node * p : parents)
           {
               --p->children_num;
           }
           parents.clear() ;
           is_removed = true ;
       }
    } ;
};
```