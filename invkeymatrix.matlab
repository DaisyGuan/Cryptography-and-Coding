function key = invkeymatrix(block);
%key is a matrix
%the result is the inverse of key under mod 26 situation
d=det(block);
d=round(d);
recipd=powermod(d,-1,26);
Kinv=recipd*d*inv(block);
Kinv=round(Kinv);
Kinv=mod(Kinv,26);
key=[];
key=[key,Kinv];
end
