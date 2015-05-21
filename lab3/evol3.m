classdef evol3 < handle

    
    properties
        popNum
        points
        pointsNum
        distanse
        population
        mutation_prop
        alpha
        cross_p
    end
    
    methods
        function [] = generatePopulation(obj)
            [obj.pointsNum, ~] = size(obj.points);
            obj.population = zeros(obj.popNum, obj.pointsNum);
            for i = 1:obj.popNum
                obj.population(i,:) = randperm(obj.pointsNum);
            end
            
            obj.distanse = zeros(obj.pointsNum, obj.pointsNum);
            for i = 1:obj.pointsNum
                for j = 1:obj.pointsNum
                    obj.distanse(i, j) = sqrt((obj.points(i, 1) - obj.points(j, 1)).^2 + ...
                    (obj.points(i, 2) - obj.points(j, 2)).^2);
                end
            end
        end
        
        function [] = nextPopulation(obj)
            cs = cumsum(obj.getFitness());
            r = rand(1, obj.popNum);
            new_i = arrayfun(@(rr) find(cs-rr>0,1), r);
            obj.population = obj.population(new_i, :);
            %crossingover
            for i = 1:(obj.popNum/2-1)
                if rand(1, 1) < obj.cross_p
                    [c1, c2] = obj.pmxCross(obj.population(2*i, :), obj.population(2*i+1, :));
                    obj.population(2*i, :) = c1;
                    obj.population(2*i+1, :) = c2;
                end
            end            
        end
        
        function [c1, c2] = pmxCross(obj, p1, p2)
            r1 = randi(obj.pointsNum-3)+1;
            r2 = randi(obj.pointsNum-3)+1;
            if r1 > r2
                t = r1;
                r1 = r2;
                r2 = t;
            end
            c1 = zeros(1, obj.pointsNum);
            c2 = zeros(1, obj.pointsNum);
            c1(r1:(r2-1)) = p1(r1:(r2-1));
            c2(r1:(r2-1)) = p2(r1:(r2-1));
            
            p1u = zeros(1, obj.pointsNum);
            p2u = zeros(1, obj.pointsNum);
            p1u(p1(r1:(r2-1))) = 1;
            p2u(p2(r1:(r2-1))) = 1;
            
            j1 = r2;
            j2 = r2;
            for i = [r2:obj.pointsNum 1:(r2-1)]
                if(p1u(p2(i)) == 0)
                   c1(j1) = p2(i);
                   j1 = mod(j1, obj.pointsNum) + 1; 
                end
                
                if(p2u(p1(i)) == 0)
                   c2(j2) = p1(i);
                   j2 = mod(j2, obj.pointsNum) + 1;
                end
            end
            
        end
        
        function [x] = getPolulationsLength(obj)
            x = zeros(1, obj.popNum);
            for i = 1:obj.popNum
                for j = 1:(obj.pointsNum-1)
                    x(i) = x(i) + obj.distanse(obj.population(i, j), obj.population(i, j+1));
                end
                x(i) = x(i) + obj.distanse(obj.population(i, 1), obj.population(i, obj.pointsNum));
            end
        end
        
        function [x] = getPermutationLength(obj, perm)
            x = 0;
            for j = 1:(length(perm)-1)
                x = x + obj.distanse(perm(j), perm(j+1));
            end
            x = x + obj.distanse(perm(1), perm(end));
        end
        
        function [x, y] = getOptimal(obj)
            fVals = obj.getPolulationsLength();
            [x, x_i] = min(fVals);
            y = obj.population(x_i, :);
        end
        
        function [fit] = getFitness(obj)
            fVals = -obj.getPolulationsLength();
            fVals;
            fit = (fVals - min(fVals)) ./ (sum(fVals) - length(fVals) * min(fVals));
             [a, b] = sort(fit);
             c = sum(a(1:10));
             fit(b(1:10)) = 0;
             fit(b(11:end)) = fit(b(11:end)) + c / length(a(1:10));
        end
       
    end
    
end

