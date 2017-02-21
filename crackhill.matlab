function [plaintext]=crackhill(snippetplaintext,ciphertext,blocklength)
r=blocklength;
len=length(snippetplaintext);

sniplain=block(snippetplaintext(1:r^2),1,r)-97;
snicipher=block(ciphertext(1:r^2),1,r)-97;
cipher=block(ciphertext,1,r)-97;
i = 1;

    while mod(round(det(sniplain)),2)==0 && i <= floor(len/r)
        sniplain=block(snippetplaintext((i*r+1):((i+r)*r)),1,r)-97;
        snicipher=block(ciphertext((i*r+1):((i+r)*r)),1,r)-97;
        i=i+1;
    end
    
    invplain=invkeymatrix(sniplain);
    key=round(mod(snicipher*invplain,26));
        
    while mod(round(det(key)),2)==0 && i <= floor(len/r)   
         while mod(round(det(sniplain)),2)==0 && i <= floor(len/r)
                sniplain=block(snippetplaintext((i*r+1):((i+r)*r)),1,r)-97;
                snicipher=block(ciphertext((i*r+1):((i+r)*r)),1,r)-97;
                i=i+1;
         end
     invplain=invkeymatrix(sniplain);
     key=round(mod(snicipher*invplain,26));
    end
          
kinv=invkeymatrix(key);
newplain=mod(kinv*cipher,26);
plaintext=[];
plaintext=[plaintext,char(block(newplain,-1,r)+97)];
end
