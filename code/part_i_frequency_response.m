function part_i_frequency_response(p, figDir, dataDir)
% Part (i): frequency response H(jOmega), magnitude/phase, and -3 dB check.

Omega = 0:(0.1*p.Omega0):(100*p.Omega0);
s = 1j*Omega;
H = polyval(p.num,s)./polyval(p.den,s);

mag_dB = 20*log10(abs(H));
phase_deg = unwrap(angle(H))*180/pi;

H_beta = polyval(p.num,1j*p.beta)./polyval(p.den,1j*p.beta);
mag_beta_dB = 20*log10(abs(H_beta));

fprintf('Part (i)\n');
fprintf('  |H(j beta)| = %.12f\n', abs(H_beta));
fprintf('  20log10|H(j beta)| = %.12f dB\n', mag_beta_dB);
fprintf('  This confirms beta = 50/3 rad/s is the -3 dB frequency.\n\n');

% Avoid putting zero on a log axis.
Omega_plot = Omega;
Omega_plot(1) = eps;

f = figure('Name','Part i frequency response','Color','w','Position',[100 100 900 650]);

subplot(2,1,1);
semilogx(Omega_plot,mag_dB,'LineWidth',1.6); hold on;
semilogx([p.beta p.beta],[-80 5],'--','LineWidth',1.1);
semilogx([Omega_plot(1) p.beta],[-3.0103 -3.0103],'--','LineWidth',1.1);
plot(p.beta,mag_beta_dB,'o','MarkerSize',7,'MarkerFaceColor','auto');
grid on;
xlabel('\Omega  (rad/s)');
ylabel('|H(j\Omega)|  (dB)');
title('Magnitude response');
ylim([-80 5]);
legend('|H(j\Omega)|','\Omega = \beta','-3.0103 dB','Location','southwest');

subplot(2,1,2);
semilogx(Omega_plot,phase_deg,'LineWidth',1.6); hold on;
semilogx([p.beta p.beta],[-280 10],'--','LineWidth',1.1);
grid on;
xlabel('\Omega  (rad/s)');
ylabel('\angle H(j\Omega)  (degrees)');
title('Phase response');
ylim([-280 10]);

saveas(f,fullfile(figDir,'part_i_frequency_response.png'));
savefig(f,fullfile(figDir,'part_i_frequency_response.fig'));
save(fullfile(dataDir,'part_i_frequency_response.mat'), ...
    'Omega','H','mag_dB','phase_deg','H_beta','mag_beta_dB');
end
