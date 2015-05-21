classdef evol1 < handle

    
    properties
        pop_num
        pop_length
        a
        b
        polulation
        f
        mutation_prop
        p_cross
    end
    
    methods
        function [] = generatePopulation(obj)
            obj.polulation = randi([0 1], obj.pop_num, obj.pop_length);
        end
        
        function [x, y] = getPoints(obj)
            x = bin2dec(num2str(obj.polulation))/bin2dec(num2str(ones(1, obj.pop_length)));
            x = x * (obj.b - obj.a) + obj.a;
            y = obj.f(x);
        end
        
        function [] = nextPopulation(obj)
            cs = cumsum(obj.getFitness());
            r = rand(1, obj.pop_num);
            new_i = arrayfun(@(rr) find(cs-rr>0,1), r);
            obj.polulation = obj.polulation(new_i, :);
            %crossingover
            obj.pop_num;
            for i = 1:(obj.pop_num-1)/2
               r = randi([1 obj.pop_length-1]);
               pc = rand(1);
               if(obj.p_cross < pc)
                   t = obj.polulation(2*i, :);
                   obj.polulation(2*i, r+1:obj.pop_length) = obj.polulation(2*i+1, r+1:obj.pop_length);
                   obj.polulation(2*i+1, r+1:obj.pop_length) = t(r+1:obj.pop_length);
               end
            end
            %mutation
            r = rand(1, obj.pop_num);
            for i = find(r < obj.mutation_prop)
                ri = randi([1 obj.pop_length]);
                obj.polulation(i, ri) = mod(obj.polulation(i, ri) + 1, 2);
            end
        end
        
        function [k] = optimize(obj, n)
            for k = 1:n
                [~, fv] = obj.getPoints();
                if length(unique(fv)) == 1
                    return;
                end
                obj.nextPopulation();
            end
        end
        
        function [x, y] = getOptimal(obj)
            [x, y] = getPoints(obj);
            [y, i] = max(y);
            x = x(i);
        end
        
        function [fit] = getFitness(obj)
            [~, fVals] = obj.getPoints();
            fit = (fVals - min(fVals)) ./ (sum(fVals) - length(fVals) * min(fVals));
        end
       
    end
    
end

