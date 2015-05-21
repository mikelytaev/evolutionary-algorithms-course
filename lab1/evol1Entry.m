clear;
f = @(x) -cos(x-0.5)./abs(x);

D = [-10:0.001:-0.5 0.5:0.001:10];

e1 = evol1;
e1.pop_num = 50;
e1.pop_length = 15;
e1.a = -10;
e1.b = 10;
e1.mutation_prop = 0.1;
e1.f = f;
e1.p_cross = 0.1;

e1.generatePopulation();
[xp, yp] = e1.getPoints();
figure(1);
plot(D, f(D), 'b', xp, yp, 'b*');
n = 50;
e1.optimize(n)
[xp, yp] = e1.getPoints();
figure(2);
plot(D, f(D), 'b', xp, yp, 'b*');
[x, y] = e1.getOptimal()