function [result]=kalmanFilterPredictor(x0,P0,A,C,Q,R,q,result)
N=size(q,1);

for k=1:N
    if(k==1)
        %filter
        result(k).x_k_k=x0;
        result(k).P_k_k=P0;
        
        %predictor
        result(k).x_kp1_k=x0;
        result(k).P_kp1_k=P0;
    else
        %filter
        P_kp1_k=result(k-1).P_kp1_k;
        x_kp1_k=result(k-1).x_kp1_k;
        K_k=P_kp1_k*C'*inv(C*P_kp1_k*C'+R);
        result(k).x_k_k=x_kp1_k+K_k*(q(k)-C*x_kp1_k);
        result(k).P_k_k=P_kp1_k-K_k*C*P_kp1_k;
        
        %predictor
        result(k).x_kp1_k=A*result(k).x_k_k;
        result(k).P_kp1_k=A*result(k).P_k_k*A'+Q;
    end
end
end