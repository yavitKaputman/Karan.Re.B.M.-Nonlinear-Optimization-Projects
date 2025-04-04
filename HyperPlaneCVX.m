%Creating Samples:
rand('seed',314);
x = rand(40,1);
y = rand(40,1);
class = [2*x<y+0.5]+1;
A1 = [x(find(class==1)),y(find(class==1))];
A2 = [x(find(class==2)),y(find(class==2))];

%Solving The Problem Using CVX:
cvx_begin
    variable w(2)
    variable b
    minimize((0.5)*(sum_square(w)))
    subject to
        A1*w + ones(19,1)*b <= -1
        A2*w + ones(21,1)*b >= 1
cvx_end

%The Hyper Space Function:
f = @(z) -(w(1)/w(2))*z-b/w(2);

%Plotting:
m = 0:1;
n=f(m);
plot(A1(:,1),A1(:,2),'*','MarkerSize',6)
hold on
plot(A2(:,1),A2(:,2),'d','MarkerSize',6)
hold on
plot(m',n,'LineWidth',2)
title('Example Of Classification')
xlabel('x')
ylabel('y')
hold off