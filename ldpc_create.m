function Nldpc = ldpc_create(x)


global kbch_length
global nldpc_length
global ldpc_par_adress
global qldpc
global kldpc_length %% 3nisan

%Initial values of parity bits are zero
par_bits = zeros(1,(nldpc_length- kldpc_length));

%Get the table for the given rate, rate variable is global

% par_adress = par_adress_table(rate) ; 


r = 0;
size2=size(ldpc_par_adress);
time=size2(2);
length(x)
for k = 1:length(x)
    if mod(k,360) == 1 
            r = r + 1;            
    end;
    for n = 1:time 
        if (ldpc_par_adress(r,n) ~= 0)
            p_adress = mod(  (ldpc_par_adress(r,n) +  mod(k,360)*qldpc ) , nldpc_length- kldpc_length); % Qldpc changes with rate variable        
        end
        par_bits(p_adress + 1) = xor( par_bits(p_adress + 1) , x(k) );
    end;
end;
   
for m = 2:length(par_bits) 
    par_bits(m) = xor(par_bits(m), par_bits(m-1));
end;

par_bits_int = parity_bit_interleaver(par_bits); %
Nldpc = [x par_bits_int];

return

% 4 nisan  par_bits(p_adress) yerine Par_bits(p_adress + 1) yap�ld�
% r= 1 yerine r=0 yap�ld� son d�ng�de outoff bound oluyordu.
%ilk for un i�indeki forun s�n�rlar� yukar�da hesaplanarak yaz�ld� time
%olarak eski hali length(ldpc_par_adress) bir eksik sonu� veriyordu.



        
        
        
    