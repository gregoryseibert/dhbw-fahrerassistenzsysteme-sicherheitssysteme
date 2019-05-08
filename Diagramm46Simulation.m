function [ay, delta, deltaPsi] = Diagramm46Simulation(simTime, simStep, deltaH, r, v, CvStern, ChStern, controllerActive, lv, lh, is, m, theta, g)

%% Setup Simulation
handle = load_system('Querdynamikmodell');
params = get_param('Querdynamikmodell','modelworkspace');
params.assignin('controllerActive', controllerActive);
params.assignin('deltaH', deltaH);
params.assignin('r', r);
params.assignin('v', v);
params.assignin('lv',lv);
params.assignin('lh',lh);
params.assignin('cvStern',CvStern);
params.assignin('chStern',ChStern);
params.assignin('is',is);
params.assignin('theta',theta);
params.assignin('m',m);
params.assignin('g',g);


%% Simulation
simOut = sim('Querdynamikmodell','Solver','ode4','FixedStep',num2str(simStep),'StopTime',num2str(simTime));
ay = simOut.get('ay');
delta = simOut.get('delta');
vy = simOut.get('vy');
deltaPsi = simOut.get('deltaPsi');
alphaV = simOut.get('alphaV');
alphaH = simOut.get('alphaH');

%% Plot 46
k = 0;
ay_k = ay.data(end,1);
while(ay_k < 2 && k < size(ay.data(end,:),2))
    k = k + 1;
    ay_k = ay.data(end,k);
end

ay = ay.data(end,:);
delta = delta.data(end,:);
deltaPsi = deltaPsi.data(end,:);
close_system('Querdynamikmodell',0);

end