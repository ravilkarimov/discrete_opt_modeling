% workshop 2
% select a set of trade negotiation party
enum NEGOTIATOR;
NEGOTIATOR: dummy;

int: l; % minimum party size
int: u; % maximum party size
int: m; % minimum joint ability

array[NEGOTIATOR] of int: honor;
array[NEGOTIATOR, NEGOTIATOR] of int: joint;

array[1..u] of var NEGOTIATOR: party;
constraint forall (i in 1..u-1) (
    party[i] >= party[i+1] + (party[i] != dummy)
);
constraint forall (i in 1..u) (
    party[i] != dummy
);

var int: strength = sum (i, j in 1..u where i < j) (
    joint[party[i], party[j]]
);
constraint strength >= m;

var int: minhonor;
constraint minhonor = min (i in 1..u) (
    honor[party[i]] + (party[i] = dummy) * (max(honor) + 1)
);
solve maximize minhonor;

set of NEGOTIATOR: os :: output_only %% remove the dummy value
    = { fix(party[i]) | i in 1..u } diff { dummy };

output ["party = \(os)\n"];
output ["obj = \(minhonor)"];