% ---- DATA ----

%  products
enum PRODUCT;
% Profit per unit for each product
array[PRODUCT] of float: profit;

% resources
enum RESOURCE;
array[RESOURCE] of float: capacity;

% Units of each resource required to produce 1 unit of product
array[PRODUCT, RESOURCE] of float: consumption;
% ---- DATA ----

% ---- CONSTRAINTS ----
% Variables: how much should we make of each product
array[PRODUCT] of var int: produce;

% Must produce non-negative amount
constraint forall (p in PRODUCT) (
    produce[p] >= 0
);

% Production can only use the available resources
constraint forall (r in RESOURCE) (
    sum (p in PRODUCT)
        (consumption[p, r] * produce[p]) <= capacity[r]
);
% ---- CONSTRAINTS ----
% ---- OBJECTIVE ----
% Maximize profit
solve maximize sum (p in PRODUCT) (
    profit[p] * produce[p]
);
% ---- OBJECTIVE ----

output ["\(p): \(produce[p])\n" | p in PRODUCT];