function err = sampsonErrf( F, x, xp )

fx = 500;
fy = 500;
cx = 1224/2;
cy = 1024/2;

x(:,3) = 1;
xp(:,3) = 1;

x(:,1:2) = [x(:,1)-cx,x(:,2)-cy]./ fx;

xp(:,1:2) = [xp(:,1)-cx,xp(:,2)-cy]./ fx;


L = F * x';
Lp = F' * xp';
num = sum(xp' .* L).^2;
den = L(1,:).^2 + L(2,:).^2 + Lp(1,:).^2 + Lp(2,:).^2;
err = num ./ den;
% mean(err)

end