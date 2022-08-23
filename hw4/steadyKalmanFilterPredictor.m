function [result]=steadyKalmanFilterPredictor(x0,A,C,Q,R,q,result)
N=size(q,1);
[P_inf,~,~] = idare(A',C',Q,R,[],eye(3));
K_inf=P_inf*C'*inv(C*P_inf*C'+R);

for k=1:N
    if(k==1)
        %filter
        result(k).S_x_k_k=x0;
        
        %predictor
        result(k).S_x_kp1_k=x0;
    else
        %filter
        S_x_kp1_k=result(k-1).S_x_kp1_k;
        result(k).S_x_k_k=S_x_kp1_k+K_inf*(q(k)-C*S_x_kp1_k);
        
        %predictor
        result(k).S_x_kp1_k=A*result(k).S_x_k_k;
    end
end

end