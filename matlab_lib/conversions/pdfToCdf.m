function [cdfDist] = pdfToCdf(pdfDist)
%
%

cdfDist = zeros(length(pdfDist),1);

for i = 1:length(pdfDist)
    cdfDist(i) = sum(pdfDist(i:end));
end;