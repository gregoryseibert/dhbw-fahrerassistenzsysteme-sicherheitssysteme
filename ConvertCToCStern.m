function [CvStern, ChStern] = ConvertCToCStern(Cv, Ch, m, g, lv, lh)
    ChStern = Ch * (lv+lh) / lv / m / g;
    CvStern = Cv * (lv+lh) / lh / m / g;
end