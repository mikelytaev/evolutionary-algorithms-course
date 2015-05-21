clear;
points = dlmread('berlin.txt');
best = [1 49 32 45 19 41 8 9 10 43 33 51 11 52 14 13 47 26 27 28 12 25 4 6 15 5 ...
24 48 38 37 40 39 36 35 34 44 46 16 29 50 20 23 30 2 7 42 21 17 3 18 31 22 1];
e3 = evol3;
e3.popNum = 100;
e3.points = points(:, 2:3);
e3.mutation_prop = 0.5;
e3.cross_p = 0.9;

e3.generatePopulation();
n = 50;
for i = 1:n
    e3.nextPopulation();
    [val, ~] = e3.getOptimal();
    val;
end

[val, path] = e3.getOptimal();
val
plot(points(path(1:end), 2), points(path(1:end), 3), 'b', points(path(1:end), 2), points(path(1:end), 3), 'b*');
e3.getPermutationLength(best)
plot(points(best(1:end), 2), points(best(1:end), 3), 'b', points(best(1:end), 2), points(best(1:end), 3), 'b*');