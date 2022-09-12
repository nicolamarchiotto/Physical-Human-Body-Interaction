function [Y_hat_rls,k_rls,tau_rls]=RLS(X,Y,P0,lamba)
% RLS, the lamba must be in the range 0.005 < lamba < 1 for computational
% reasons, if lamba < 0.005, lamba is set to 0.005

rls=[];
b0=[0;0];
for k=1:size(X,1)
    if(k==1)
        rls(k).e=Y(k,:)-X(k,:)*b0;
        if lamba >= 0.005
            rls(k).P=(P0-(P0*X(k,:)'*X(k,:)*P0)/(lamba+X(k,:)*P0*X(k,:)')/lamba);
        else
            lamba_temp=0.005;
            rls(k).P=(P0-(P0*X(k,:)'*X(k,:)*P0)/(lamba_temp+X(k,:)*P0*X(k,:)')/lamba_temp);
        end
        rls(k).K=rls(k).P*X(k,:)';
        rls(k).b=b0+rls(k).K*rls(k).e;
    else
        rls(k).e=Y(k,:)-X(k,:)*rls(k-1).b;
        if lamba > 0.005
            rls(k).P=(rls(k-1).P-(rls(k-1).P*X(k,:)'*X(k,:)*rls(k-1).P)/(lamba+X(k,:)*rls(k-1).P*X(k,:)')/lamba); 
        else
            lamba_temp=0.005;
            rls(k).P=(rls(k-1).P-(rls(k-1).P*X(k,:)'*X(k,:)*rls(k-1).P)/(lamba_temp+X(k,:)*rls(k-1).P*X(k,:)')/lamba_temp); 
        end
        rls(k).K=rls(k).P*X(k,:)';
        rls(k).b=rls(k-1).b+rls(k).K*rls(k).e;
    end
    rls(k).Y_hat=X(k,:)*rls(k).b;
end

Y_hat_rls=[rls.Y_hat]';
k_rls=1/rls(end).b(2);
tau_rls=rls(end).b(1)*k_rls;

end