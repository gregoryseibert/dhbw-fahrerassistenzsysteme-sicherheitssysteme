function Diagramm48(plotInstance, g, lv, lh, lEG, lSG, is, m, theta)
    deltaControlled = 0;

    EG = [max(-lEG, -lSG*0.9) 0 max(lEG, -lSG*0.9)];
    SG = lSG;

    ChStern = 1./(g*SG);
    CvStern = ConvertGradToCStern(EG, 0, g, ChStern);

    vmax = int32(sqrt((lv+lh)/max(EG)) + 5);
    vmax = vmax + (5 - mod(vmax, 5));

    deltaH = 1;
    deltaH_array = deltaH * ones(1, int32(vmax));

    r = 1;
    v = 1:vmax;

    max_limit_y = 0;

    simStep = 0.001;
    simTime = 10;

    colors = [[0 0 0.5], [0.8 0.4 0], [0.5 0 0]];
    hold(plotInstance,'off');

    for k = 1:size(CvStern,2)
        [~, ~, dpsi_val] = Querdynamik(simTime, simStep, deltaH_array, r, v, CvStern(k), ChStern, deltaControlled, lv, lh, is, m, theta, g);

        yVals = dpsi_val/(deltaH/is);
        max_limit_y = max(max(yVals), max_limit_y);

        if k > 1
            plot(plotInstance, v, yVals, 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
        else
            diffs = yVals(2:end) - yVals(1:end-1);
            falling = int32(diffs < 0);
            k_max = min(falling .* int32(1:(size(yVals, 2)-1)) + (1-falling) .* 10000);
            plot(plotInstance, v(1:k_max), yVals(1:k_max), 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
        end

        hold(plotInstance,'on');
    end

    ylim(plotInstance, [0 max_limit_y]);

    grid(plotInstance, 'on');
    legend(plotInstance, strcat('EG=',num2str(EG(1), 2)),  strcat('EG=',num2str(EG(2), 2)), strcat('EG=',num2str(EG(3), 2)), 'Location','northwest');
end
