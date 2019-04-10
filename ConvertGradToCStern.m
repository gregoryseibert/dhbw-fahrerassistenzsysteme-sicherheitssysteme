function [CvStern, ChStern] = ConvertGradToCStern(EG, SG, g, ChStern) 
    if(nargin == 3)
        ChStern = 1./(g*SG);
    else
        SG = 1./(g*ChStern);
    end
    
    CvStern = 1./(g*(EG+SG));
end
