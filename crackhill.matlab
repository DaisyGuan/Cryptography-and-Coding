function [plaintext]=crackhill(snippetplaintext,ciphertext,blocklength)
r=blocklength;
len=length(snippetplaintext);
%define sniplain and snicipher 
sniplain=block(snippetplaintext(1:r^2),1,r)-97;
snicipher=block(ciphertext(1:r^2),1,r)-97;
cipher=block(ciphertext,1,r)-97;
i = 1;
% try for the inverse of sniplain
    while mod(round(det(sniplain)),2)==0 && i <= floor(len/r)
        sniplain=block(snippetplaintext((i*r+1):((i+r)*r)),1,r)-97;
        snicipher=block(ciphertext((i*r+1):((i+r)*r)),1,r)-97;
        i=i+1;
    end
    
    invplain=invkeymatrix(sniplain);
    key=round(mod(snicipher*invplain,26));
%try for the inverse of key
%if key cannot be inversed, then we try a new sniplain to do so

    while mod(round(det(key)),2)==0 && i <= floor(len/r)   
         while mod(round(det(sniplain)),2)==0 && i <= floor(len/r)
                sniplain=block(snippetplaintext((i*r+1):((i+r)*r)),1,r)-97;
                snicipher=block(ciphertext((i*r+1):((i+r)*r)),1,r)-97;
                i=i+1;
         end
     invplain=invkeymatrix(sniplain);
     key=round(mod(snicipher*invplain,26));
    end
%compute for key inverse to crack the hill cipher        
kinv=invkeymatrix(key);
newplain=mod(kinv*cipher,26);
plaintext=[];
plaintext=[plaintext,char(block(newplain,-1,r)+97)];
end
