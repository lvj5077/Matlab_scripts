syms x y z;

eq1 = x-y == 1;

eq2 = x + y - 6 == 2;


[x0,y0] = solve(eq1,eq2,x,y);

sol = double([x0,y0])

%%


