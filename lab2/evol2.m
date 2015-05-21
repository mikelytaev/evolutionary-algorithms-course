classdef evol2 < handle

    
    properties
        pop_num
        a
        b
        population
        f
        mutation_prop
        alpha
        cross_p
    end
    
    methods
        function [] = generatePopulation(obj)
            obj.population = rand(obj.pop_num, 2) * (obj.b - obj.a) + obj.a;
        end
        
        function [] = nextPopulation(obj)
            cs = cumsum(obj.getFitness());
            r = rand(1, obj.pop_num);
            new_i = arrayfun(@(rr) find(cs-rr>0,1), r);
            obj.population = obj.population(new_i, :);
            %crossingover
            for i = 1:(obj.pop_num/2-1)
                if rand(1, 1) < obj.cross_p
                    t1 = obj.population(2*i, :);
                    t2 = obj.population(2*i+1, :);
                    obj.alpha = rand(1, 1);
                    obj.population(2*i, :) = (obj.alpha*t1)+((1-obj.alpha)*t2);
                    obj.population(2*i+1, :) = (obj.alpha*t2)+((1-obj.alpha)*t1);
                    %obj.population(2*i, :) = t1+(rand(1,1)*1.5-0.25)*(t2-t1);
                    %obj.population(2*i+1, :) = t1+(rand(1,1)*1.5-0.25)*(t2-t1);
                end
            end
            %mutation
            r = rand(1, obj.pop_num);
            for i = find(r < obj.mutation_prop)
                obj.population(i, randi([1 2], 1, 1)) = rand(1, 1) * (obj.b - obj.a) + obj.a;
            end
            
        end
        
        function [x, y] = getPoints(obj)
            x = obj.population;
            y = obj.f(x(:, 1), x(:, 2));
        end
        
        function [x, y] = getOptimal(obj)
            [x, y] = getPoints(obj);
            [y, i] = max(y);
            x = x(i, :);
        end
        
        function [fit] = getFitness(obj)
            [~, fVals] = obj.getPoints();
            fVals;
            fit = (fVals - min(fVals)) ./ (sum(fVals) - length(fVals) * min(fVals))
        end
       
    end
    
end

