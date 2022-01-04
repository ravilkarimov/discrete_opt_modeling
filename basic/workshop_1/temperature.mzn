array[int] of int: readings;
int: start;
int: n = length(readings);
set of int: TIME0 = 0..n;
set of int: TIME = 1..n;

enum CHOICE = {
    heat, strongly_heat, cool,
    strongly_cool, do_nothing};

array[CHOICE] of int: adjust = [+1, +4, -2, -5, 0];
array[CHOICE] of int: cost = [1, 5, 3, 9, 0];

array[TIME0] of var 25..30: temp;
array[TIME] of var CHOICE: choice;

constraint temp[0] = start;
constraint forall(t in TIME) (temp[t] = (readings[t] + temp[t-1]) div 2
                                        + adjust[choice[t]]);

% solve satisfy;
var int: obj = sum(i in choice)(cost[i]);
solve minimize obj;
output ["temp = \(temp);\nchoice = \(choice);\ncost = \(obj);"];