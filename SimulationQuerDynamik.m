function [ay_val, delta_val, dpsi_val] = SimulationQuerDynamik(simTime, simStep, deltaH, r, v, CvStern, ChStern, controllerActive, lv, lh, is, m, theta, g)

%% Init Values
mDivTheta = m / theta;

%% Setup Simulation
handle = load_system('QuerDynamicModell');
params = get_param('QuerDynamicModell','modelworkspace');
params.assignin('controllerActive', controllerActive);
params.assignin('deltaH', deltaH);
params.assignin('r', r);
params.assignin('v', v);
params.assignin('lv',lv);
params.assignin('lh',lh);
params.assignin('cvStern',CvStern);
params.assignin('chStern',ChStern);
params.assignin('is',is);
params.assignin('mDivTheta',mDivTheta);
params.assignin('g',g);


%% Simulate
simOut = sim('QuerDynamicModell','Solver','ode4','FixedStep',num2str(simStep),'StopTime',num2str(simTime));
ay = simOut.get('ay');
delta = simOut.get('delta');
vy = simOut.get('vy');
dpsi = simOut.get('deltaPsi');
alphaV = simOut.get('alphaV');
alphaH = simOut.get('alphaH');

%% Plot 4_6
k = 0;
ay_k = ay.data(end,1);
while(ay_k < 2 && k < size(ay.data(end,:),2))
    k = k + 1;
    ay_k = ay.data(end,k);
end
ay_val = ay.data(end,:);
delta_val = delta.data(end,:);
dpsi_val = dpsi.data(end,:);
close_system('QuerDynamicModell',0);

end