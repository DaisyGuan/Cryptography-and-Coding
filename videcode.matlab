function key=videcode(c);
%this function decode vigenere cipher
%c is ciphertext
%n is the key position
%shift by i;compute 20 agreements

b=[];
for i=1:length(c)
    b=[b,coinc(c,i)];
end
limit=length(c)*0.066;

b2=[];
for i=1:length(c)
    if b(1,i)>=limit
        b2=[b2,i];
    end
end
bl=b2(1,1)

%sorting agreements;choose i by sorting b
%sorting i according to b

%choose 3 max agreements
%min is block length
%cut the text according to the block  

key = [];
    for n=1:bl
        s=choose(c,bl,n);
        %compute the reletive frequency
        [f,relf]=zfrequency(s);
        %correlate to englishfreq
        cr=corr(relf);
        %frequency and key
        [val,pos]=max(cr);
    key=[key,pos];
    end
end
        
    
    
