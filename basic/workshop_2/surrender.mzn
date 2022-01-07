% workshop 2
% select a set of trade negotiation party
enum NEGOTIATOR;
NEGOTIATOR: dummy;

int: l; % minimum party size
int: u; % maximum party size
int: m; % minimum joint ability

array[NEGOTIATOR] of int: honor;
array[NEGOTIATOR, NEGOTIATOR] of int: joint;

var set of NEGOTIATOR: party;

var int: strength = sum (i, j in party where i < j) (joint[i, j]);
constraint strength >= m;

constraint not(dummy in party);
constraint card(party) >= l;
constraint card(party) <= u;

var int: minhonor;
constraint minhonor = min ([honor[i] | i in NEGOTIATOR
                           where i in party]);
solve maximize minhonor;

output ["party = \(party)\n"];
output ["obj = \(minhonor)"];