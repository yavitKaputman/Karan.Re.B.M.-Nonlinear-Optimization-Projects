%Creating Samples:
a = 1;
I = iter_counter([2; 1], 2, 0.25, 0.5, 1e-5, 1);
for i = (2:2500)
    a = [a (i^(-1))];
    I = [I iter_counter([2; 1], 2, 0.25, 0.5, 1e-5, (i^(-1)))];
end

%Plotting:
plot(a, I,'LineWidth',2);
title('Parameter & Iteration Relation')
xlabel('Parameter')
ylabel('Iteration')

%Iteration Counter:
function [iter] = iter_counter(x0, s, alpha, beta, epsilon, a)
    x = x0;
    fun_val = f(x0,a);
    grad = g(x0,a);
    iter = 0;
    while (norm(grad) > epsilon)
        iter = iter + 1;
        t = s;
        while (fun_val - f(x - t*grad, a) < alpha*t*((norm(grad))^2))
            t = beta*t;
        end
        x = x -t*grad;
        fun_val = f(x,a);
        grad = g(x,a);
    end
end

%Objective Function:
function [fun_val] = f(x, a)
    fun_val = (x')*[1 0; 0 a]*x;
end

%Geradient Function:
function [grad] = g(x, a)
    grad = [2 0; 0 2*a]*x;
end