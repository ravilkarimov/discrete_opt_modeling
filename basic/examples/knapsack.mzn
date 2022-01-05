enum PRODUCT;
int: capacity;
array[PRODUCT] of int: profit;
array[PRODUCT] of int: weight;

var set of PRODUCT: solution;

constraint (sum(p in solution) (weight[p])) <= capacity;

var int: obj = sum(p in solution) (profit[p]);
solve maximize obj;

var int: used_space = sum(p in solution) (weight[p]);
output ["Profit: \(obj) Capacity: \(used_space)"];