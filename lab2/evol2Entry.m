clear;
fEaso = @(x1,x2) cos(x1).*cos(x2).*exp(-((x1-pi).^2+(x2-pi).^2));
%fEaso = @(x1, x2) -(x1.^2+x2.^2);
grid = -7:0.01:7;
grid2dY = grid.' * ones(1, length(grid));
grid2dX = grid2dY.';

e2 = evol2;
e2.f = fEaso;
e2.a = 3;
e2.b = 3.3;
e2.pop_num = 50;
e2.mutation_prop = 0.0;
e2.alpha = 0.5;
e2.cross_p = 0;

e2.generatePopulation();
[xp, yp] = e2.getPoints();
figure;
imagesc(grid, grid, fEaso(grid2dX, grid2dY));
plot(xp(:, 1), xp(:, 2), 'b*');
n = 100;
for i = 1:n
    e2.nextPopulation();
end
[xp, yp] = e2.getPoints();

figure;
imagesc(grid, grid, fEaso(grid2dX, grid2dY));
plot(xp(:, 1), xp(:, 2), 'b*');
[x, y] = e2.getOptimal()