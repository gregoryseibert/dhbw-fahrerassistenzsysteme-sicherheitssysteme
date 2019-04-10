function Diagramm46KonstanteGeschwindigkeit(plotInstance, v0, g, lv, lh, lEG, lSG, is, m, theta)
    controllerActive = 0;
    deltaH = 0:0.02:6;
    v = v0;

    EG = [max(-lEG, -lSG*0.9) 0 lEG];
    SG = lSG;
    
    ChStern = 1./(g*SG);
    CvStern = ConvertGradToCStern(EG, 0, g, ChStern);

    simStep = 0.001;
    simTime = 10;

    colors = [[0 0 0.5], [0.8 0.4 0], [0.5 0 0]];
    hold(plotInstance,'off');
    
    for k = 1:size(CvStern,2)
        [ay_val, delta_val] = SimulationQuerDynamik(simTime, simStep, deltaH, 1, v, CvStern(k), ChStern, controllerActive, lv, lh, is, m, theta, g);

        plot(plotInstance, ay_val, delta_val, 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
        hold(plotInstance,'on');
    end
    
    grid(plotInstance,'on');
    legend(plotInstance, strcat('EG=',num2str(EG(1),2)),  strcat('EG=',num2str(EG(2),2)), strcat('EG=',num2str(EG(3),2)), 'Location','northwest'); %'EG='+num2str(EG(2)), 'EG='+num2str(EG(3))    
end