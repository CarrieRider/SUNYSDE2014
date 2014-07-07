
% Define the base parameters
delta = .4; 
gamma = .8;
rho = 1;
R = 3; 
D = 7;
alpha = .2; 
beta =.2;


% Define the rate function for the differential equation
shrimpRate = @(x,y,delta, gamma, rho, R, D, alpha, beta) [ ...
    (x*x*(1-x)-alpha*x*y-(gamma*x*x)/(x+D)) ; ...
    (rho*y*y*(1-y)-beta*x*y-(delta*y*y)/(y+R)) ];

% Define the Jacobian of the rate function.
jacobian = @(x,y,delta, gamma, rho, R, D, alpha, beta) [ ...
    (2*x-3*x*x-alpha*y-gamma*x*((x+2*D)/((x+D).^2))) ...
    -alpha*x ; ...
    -beta*y ...
    (-rho*y*y+2*rho*y*(1-y)-beta*x-delta*y*((y+2*R)/((y+R).^2))) ...
    ];

% Define the initial estimate for the first set of trials.
% Define the range of values of gamma to find the roots.
x = [0.86,0.61]';
gammaMax = 8;
gammaValues = 0.0:0.001:gammaMax;

theRoot1 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);

% Do the same thing only for a different initial estimate for the
% roots.
x = [0.21,0.85]';
theRoot2 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);

% Find the third set of roots with the final estimate for the roots.
x = [0.93,0.35]';
theRoot3 = newtonIterations(x,delta, gamma, rho, R, D, ...
                            alpha, beta, ...
                            shrimpRate, jacobian, ...
                            gammaValues);


% Plot the bifurcation diagram for the x species.
which = 1;
subplot(2,1,1)
plot(theRoot1(:,3),theRoot1(:,which),'k', ...
     [0 gammaMax],[1 1],'k', ...
     [0 gammaMax],[0 0],'k', ...
     theRoot2(:,3),theRoot2(:,which),'k--', ...
     theRoot3(:,3),theRoot3(:,which),'k--');
xlabel('\gamma')
ylabel('Fixed Points (x)')
title('Bifurcation diagram with respect to \gamma')
axis([0 gammaMax -0.1 1.1])

% Plot the bifurcation diagram for the y species.
which = 2;
subplot(2,1,2)
plot(theRoot1(:,3),theRoot1(:,which),'k', ...
     [0 gammaMax],[0 0],'k', ...
     [0 gammaMax],[1 1],'k', ...
     theRoot2(:,3),theRoot2(:,which),'k--', ...
     theRoot3(:,3),theRoot3(:,which),'k--');
xlabel('\gamma')
ylabel('Fixed Points (y)')
axis([0 gammaMax -0.1 1.1])
