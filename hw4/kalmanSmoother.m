function [result]=kalmanSmoother(A,q,result)
N=size(q,1);
for k=N:-1:1
    if(k==N)
        result(k).xs_k=result(k).x_k_k;
        result(k).Ps_k=result(k).P_k_k;
    else
        xs_kp1=result(k+1).xs_k;
        xf_kp1_k=result(k).x_kp1_k;
        xf_k_k=result(k).x_k_k;
        
        Pf_k_k=result(k).P_k_k;
        Pf_kp1_k=result(k).P_kp1_k;
        K_k=Pf_k_k*A'*inv(Pf_kp1_k);
        result(k).xs_k=xf_k_k+K_k*(xs_kp1-xf_kp1_k);
    end
end
end