function part_iii_ifft_response(p, figDir, dataDir)
% Part (iii): compute one period of y(t) using an N-point IFFT.

t = (0:p.N-1)*(p.T0/p.N);
Y = zeros(1,p.N);

for k = -p.Kmax:p.Kmax
    if k == 0
        Xk = p.alpha;
    else
        Xk = sin(k*p.alpha*pi)/(k*pi);
    end

    Hk = polyval(p.num,1j*k*p.Omega0)./polyval(p.den,1j*k*p.Omega0);
    Yk = Xk*Hk;

    % MATLAB bin: k=0 -> 1, k=1 -> 2, k=-1 -> N, etc.
    idx = mod(k,p.N) + 1;
    Y(idx) = Yk;
end

% MATLAB ifft includes 1/N. The Fourier series does not, so multiply by N.
y_ifft = real(ifft(Y)*p.N);
max_imag = max(abs(imag(ifft(Y)*p.N)));

% Direct cosine sum as a check. This intentionally keeps the sign of Xk.
y_cos = p.alpha*ones(size(t));
for k = 1:p.Kmax
    Xk = sin(k*p.alpha*pi)/(k*pi);
    Hk = polyval(p.num,1j*k*p.Omega0)./polyval(p.den,1j*k*p.Omega0);
    y_cos = y_cos + 2*Xk*abs(Hk)*cos(k*p.Omega0*t + angle(Hk));
end
check_error = max(abs(y_ifft-y_cos));

fprintf('Part (iii)\n');
fprintf('  Max imaginary residue from IFFT: %.3e\n', max_imag);
fprintf('  Max difference between IFFT and cosine check: %.3e\n\n', check_error);

f = figure('Name','Part iii IFFT output','Color','w','Position',[100 100 900 450]);
plot(t,y_ifft,'LineWidth',1.7); hold on;
plot(t,y_cos,'--','LineWidth',1.0);
grid on;
xlabel('t  (seconds)');
ylabel('y(t)');
title('Output over one period from truncated Fourier series');
legend('IFFT result','direct cosine check','Location','best');
xlim([0 p.T0]);

saveas(f,fullfile(figDir,'part_iii_ifft_output.png'));
savefig(f,fullfile(figDir,'part_iii_ifft_output.fig'));
save(fullfile(dataDir,'part_iii_ifft_output.mat'), ...
    't','Y','y_ifft','y_cos','max_imag','check_error');
end
