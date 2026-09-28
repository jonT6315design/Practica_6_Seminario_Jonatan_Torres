L = 2e-3;       
C = 10e-6;      
R = 10;         
Uin = 32;       
f = 100e3;      
D = 0.4;        

x0 = [0; 0];

tspan = [0 0.005]; 

opciones = odeset('MaxStep', 1e-6);

[t, x] = ode45(@(t, x) convertidor(t, x, L, C, R, Uin, f, D), tspan, x0, opciones);

iL = x(:, 1);
Vc = x(:, 2);

figure;
subplot(2,1,1);
plot(t, iL, 'b', 'LineWidth', 1.5);
title('Corriente en el Inductor (i_L)');
xlabel('Tiempo (s)'); ylabel('Corriente (A)');
grid on;

subplot(2,1,2);
plot(t, Vc, 'r', 'LineWidth', 1.5);
title('Voltaje en el Capacitor (V_c)');
xlabel('Tiempo (s)'); ylabel('Voltaje (V)');
grid on;

function dxdt = convertidor(t, x, L, C, R, Uin, f, D)
T = 1/f;
t_mod = mod(t, T);
if t_mod < D * T
    d = 1;
else
    d = 0;
end

iL = x(1);
Vc = x(2);

diL_dt = -(1/L)*Vc + (Uin/L)*d;
dVc_dt = (1/C)*iL - (1/(R*C))*Vc;

dxdt = [diL_dt; dVc_dt];
end