function [Y_hat_adpt]=adativeAlgorithm(X,Y,Ts,g)

adpt=[];
b0=[0;0];
for k=1:size(X,1)
    if(k==1)
        err_k=Y(k,:)-X(k,:)*b0;
        adpt(k).b=b0+Ts*g*X(k,:)'*err_k;
    else 
        err_k=Y(k,:)-X(k,:)*adpt(k-1).b;
        adpt(k).b=adpt(k-1).b+Ts*g*X(k,:)'*err_k;
    end
    adpt(k).Y_hat=X(k,:)*adpt(k).b;
end
Y_hat_adpt=[adpt.Y_hat]';
% k_adpt=1/adpt(end).b(2);
% tau_adpt=adpt(end).b(1)*k_adpt;

end