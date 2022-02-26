function [F,inlierPts] = RANSAC2d2dF_fisheye(vpts1,vpts2)
hpNum=8;
confidence=0.99;
% vpts1 = normalize(vpts1);
% vpts2 = normalize(vpts2);
F= zeros(3);
iterations = 0;
N = length(vpts1);

SamponDistThreshold = 3e-1;

feature_inlierRatio=0.6;

iterationMax=round(log(1-confidence)/log(1-(1-feature_inlierRatio)^hpNum));

iterationMax = max(iterationMax,5000);
foundT = 0;

% inlierPts = ones(N,1);

F_test_localBest = zeros(3);
inlierRatio_localBest = 0;
inlierPts_localBest = zeros(N,1);


while (iterations < iterationMax && foundT==0 )

    inlierPts = zeros(N,1);
    iterations = iterations+1;  
    
    testIndex = randperm(N,hpNum);
        
%     T_test = fundamental_matrix(x1, x2);
    [F_test,~,~] = estimateFundamentalMatrix(vpts1(testIndex,:),vpts2(testIndex,:),'Method','Norm8Point');
    
    
    error_Pts = sampsonErrf(F_test, vpts1, vpts2);
    
    [inlierPts, GoodptsError] = find(error_Pts<SamponDistThreshold);

    rr = length(GoodptsError)/length(error_Pts);
    
    if (rr >feature_inlierRatio)
        foundT = 1;
        F = F_test;
        


        if (rr >inlierRatio_localBest)
            inlierRatio_localBest = rr;
            inlierPts_localBest = inlierPts;
            F_test_localBest = F_test;
        end

        disp("iterations "+iterations+" "+inlierRatio_localBest)
    end
    

end

if (foundT == 0)
%     all_weight
    disp("failed")
    disp(iterations)
    F = F_test_localBest;
    inlierPts = inlierPts_localBest;
%     disp(T_test)
%     disp(inlierObjs')
%     disp(inlierNum)
end


end
