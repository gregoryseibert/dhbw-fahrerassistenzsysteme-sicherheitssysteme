function Diagramm46KonstanterRadius(plotInstance, r, g, lv, lh, lEG, lSG, is, m, theta)
    controllerActive = 1;
    deltaH = 0;
    v = 2.5:1.0:20.0;

    EG = [max(-lEG, -lSG*0.9) 0 lEG];
    SG = lSG;  
    
    ChStern = 1./(g*SG);
    CvStern = ConvertGradToCStern(EG, 0, g, ChStern);

    simStep = 0.001 - (r/40*0.0009);
    simTime = 10 - (r/40*9);

    colors = [[0 0 0.5], [0.8 0.4 0], [0.5 0 0]];
    hold(plotInstance,'off'); 

    for k = 1:size(CvStern,2)
        [ay, delta] = Diagramm46Simulation(simTime, simStep, deltaH, r, v, CvStern(k), ChStern, controllerActive, lv, lh, is, m, theta, g);
        
        plot(plotInstance, ay, delta, 'LineWidth', 2.5, 'Color', colors((k-1)*3+1:k*3));
        hold(plotInstance,'on');
    end
    
    grid(plotInstance, 'on');
    legend(plotInstance, strcat('EG=',num2str(EG(1),2)),  strcat('EG=',num2str(EG(2),2)), strcat('EG=',num2str(EG(3),2)), 'Location','northwest');

end