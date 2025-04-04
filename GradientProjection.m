%Box: y=min{u,max{l,x}}
%ball: y=(r/max{Norm(x),r})*x
%none negative orthant: y=max{x,0}
%Examples:
geradient_box_projection_method(@(x) (x')*[-1 0; 0 -2]*x, @(x) [-2 0; 0 -4]*x, [1; -20], [3; 10], [2; 1], 3, 1e-5);
geradient_ball_projection_method(@(x) [0 -1]*x,@(x) [0;-1], 2, [-2; 0], 3, 1e-5);
geradient_none_negative_orthant_projection_method(@(x)(x')*[1 0; 0 0]*x + [-10 0]*x + 25, @(x) [2 0; 0 0]*x + [-10; 0],[-2; 4], 0.5, 1e-5);

%Box Projection:
function [x, fun_value] = geradient_box_projection_method(f, g, l,u, x0, t, epsilon)
    disp('1. Geradient Box Projection Method:');
    disp("min ");
    disp(f);
    x = x0;
    x= min(u, max(x - (t*g(x)), l));
    fun_value = f(x);
    e = norm(x - x0);
    while (e > epsilon)
        x0 = x;
        x= min(u, max(x - (t*g(x)), l));
        fun_value = f(x);
        e = norm(x - x0);
    end
    fprintf('Geradient Box Projection Method: x = (');
    fprintf('%g, ', x(1:end-1));
    fprintf('%g) Objective Value =  %2.6f \n', x(end), fun_value);
    disp('---------------------------------------------------------------------------------------------');
end

%Ball Projection:
function [x, fun_value] = geradient_ball_projection_method(f, g, r, x0, t, epsilon)
    disp('2. Geradient Ball Projection Method:');
    disp("min ");
    disp(f);
    x = x0;
    x = (r/max( r , norm(x - (t*(g(x))))))*(x - (t*(g(x))));
    fun_value = f(x);
    e = norm(x-x0);
    while (e > epsilon)
        x0 = x;
        x = (r/max( r , norm(x - (t*(g(x))))))*(x - (t*(g(x))));
        fun_value = f(x);
        e = norm(x - x0);
    end
    fprintf('x = (');
    fprintf('%g, ', x(1:end-1));
    fprintf('%g) Objective Value =  %2.6f \n', x(end), fun_value);
    disp('---------------------------------------------------------------------------------------------');
end

%None Negative Orthant Projection:
function [x, fun_value] = geradient_none_negative_orthant_projection_method(f, g, x0, t, epsilon)
    disp('3. Geradient None Negative Orthant Projection Method:');
    disp("min ");
    disp(f);
    x = x0;
    x = max(zeros(size(x)), x - (t*(g(x))));
    fun_value = f(x);
    e = norm(x - x0);
    while (e > epsilon)
        x0 = x;
        x = max(zeros(size(x)), x - (t*(g(x))));
        fun_value = f(x);
        e = norm(x - x0);
    end
    fprintf('x = (');
    fprintf('%g, ', x(1:end-1));
    fprintf('%g) Objective Value =  %2.6f \n', x(end), fun_value);
    disp('---------------------------------------------------------------------------------------------');
end