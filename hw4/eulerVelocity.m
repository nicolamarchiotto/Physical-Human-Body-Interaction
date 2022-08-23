function [dq_euler]=eulerVelocity(q, Ts)
	dq_euler=(q(2:end)-q(1:end-1))./Ts;
end