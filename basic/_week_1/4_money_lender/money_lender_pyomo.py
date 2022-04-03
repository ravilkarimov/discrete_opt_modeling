from pyomo.environ import *

model = ConcreteModel()

# model.P = Var(domain=NonNegativeReals)
# model.R = Var(domain=NonNegativeReals)
# model.I = Var(domain=NonNegativeReals, bounds=(0.0,2.0))

# model.P = 10000.0
# model.R = 2600.0
# model.I = 0.04

P = 10000.0
R = 2600.0
I = 0.04

model.B1 = Var(domain=NonNegativeReals)
model.B2 = Var(domain=NonNegativeReals)
model.B3 = Var(domain=NonNegativeReals)
model.B4 = Var(domain=NonNegativeReals)

# model.C1 = Constraint(expr= model.B1 ==  model.P * (1.0 + model.I) - model.R)
# model.C2 = Constraint(expr= model.B2 == model.B1 * (1.0 + model.I) - model.R)
# model.C3 = Constraint(expr= model.B3 == model.B2 * (1.0 + model.I) - model.R)
# model.C4 = Constraint(expr= model.B4 == model.B3 * (1.0 + model.I) - model.R)

model.C1 = Constraint(expr= model.B1 == P * (1.0 + I) - R)
model.C2 = Constraint(expr= model.B2 == model.B1 * (1.0 + I) - R)
model.C3 = Constraint(expr= model.B3 == model.B2 * (1.0 + I) - R)
model.C4 = Constraint(expr= model.B4 == model.B3 * (1.0 + I) - R)

model.obj = Objective(expr=model.B4)

opt = SolverFactory('gurobi')
opt.options['NonConvex'] = 2
opt.solve(model).write()

print('B1: ', model.B1())
print('B2: ', model.B2())
print('B3: ', model.B3())
print('B4: ', model.B4())