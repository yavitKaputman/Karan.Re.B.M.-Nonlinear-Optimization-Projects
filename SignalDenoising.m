%Sample 01:
randn('seed',314);
t = (linspace(0,1,1000))' ;
n = length(t);
x = sin(10*t);
figure(1)
subplot(2,2,1), plot(t,x)
title('Original Signal')
axis([0,1,-1.5,1.5]);
y = x + (0.1)*randn(n,1);
subplot(2,2,2), plot(t,y)
title('Noisy Signal')
L = sparse(n-1,n);
for i = 1 : n-1
    L(i,i) = 1;
    L(i,i+1) = -1;
end
lambda = 100;
x1=RLS_denoising(y, lambda, L, n);
subplot(2,2,3), plot(t,x1)
title('Denoised Using Quadric Regulaztion Signal')
l = -lambda*ones(n-1,1);
u = lambda*ones(n-1,1);
x2=norm_1_denoising(@(mu) -(0.25)*L*(L')*mu + (0.5)*L*y, y, l, u, zeros(n-1,1), 1e-5,L);
subplot(2,2,4), plot(t,x2)
title('Denoised Using Norm 1 Signal')

%Sample 02:
x=zeros(1000,1);
x(1:250)=1;
x(251:500)=3;
x(501:750)=0;
x(751:1000)=2;
t=1:1000;
n = length(t);
figure(2)
subplot(2,2,1), plot(t,x,'.')
title('Original Signal')
axis([0,1000,-1,4]);
y = x + (0.05)*randn(n,1);
subplot(2,2,2), plot(t,y,'.')
title('Noisy Signal')
L = sparse(n-1,n);
for i = 1 : n-1
    L(i,i) = 1;
    L(i,i+1) = -1;
end
lambda = 100;
x1=RLS_denoising(y, lambda, L, n);
subplot(2,2,3), plot(t,x1,'.')
title('Denoised Using Quadric Regulaztion Signal')
l = -lambda*ones(n-1,1);
u = lambda*ones(n-1,1);
x2=norm_1_denoising(@(mu) -(0.25)*L*(L')*mu + (0.5)*L*y, y, l, u, zeros(n-1,1), 1e-5,L);
subplot(2,2,4), plot(t,x2,'.')
title('Denoised Using Norm 1 Signal')

%RLS Denoising:
function [x] = RLS_denoising(y, lambda, L, n)
    x = (speye(n) + lambda*(L')*L)\y;
end

%Norm 1 Denoising:
function [x] = norm_1_denoising(g, y, l, u, mu0, epsilon, L)
    mu = mu0;
    mu= min(u, max(mu + g(mu), l));
    e = norm(mu - mu0);
    while (e > epsilon)
        mu0 = mu;
        mu= min(u, max(mu + g(mu), l));
        e = norm(mu - mu0);
    end
    x = y - (0.5)*L'*mu;
end