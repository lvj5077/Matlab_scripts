function [d_ts,d_ls,d_tk,d_ba] = loadData(full_path)
%     full_path = base_dir+cameraSetUp(2)+cameraSetting;
    d_ls = importdata(full_path+"/checkLifespan.txt");
    d_ts = importdata(full_path+"/timestamp.txt");
    d_tk = importdata(full_path+"/GoodFeature.txt");
    d_bat = importdata(full_path+"/BAverify.txt");
    ll = min([length(d_ls),length(d_ts),length(d_tk),length(d_bat)]);
    d_ls = d_ls(1:ll,:);
    d_ts = d_ts(1:ll,:);
    d_tk = d_tk(1:ll,:);
    d_ba = d_bat(1:ll,:);
    if length(d_bat)>1.5*length(d_ts)
        idx = 1:ll;
        d_baMono = d_bat(2*idx-1,:);
        d_baStereo = d_bat(2*idx,:);
        d_ba = [d_baMono,d_baStereo];  
    end
end

