function part_v_compare_if_available(p, figDir, dataDir)
% Part (v): compare Fourier/IFFT output to exported Simscape output.

ifftFile = fullfile(dataDir,'part_iii_ifft_output.mat');
simFile  = fullfile(dataDir,'part_iv_simscape_output.mat');

load(ifftFile,'t','y_ifft');

if ~exist(simFile,'file')
    fprintf('Part (v)\n');
    fprintf('  No Simscape export found yet: %s\n', simFile);
    fprintf('  After Part (iv), save t_sim, x_sim, y_sim there and rerun.\n\n');
    return;
end

load(simFile,'t_sim','y_sim');

t_two = [t, t+p.T0];
y_two = [y_ifft, y_ifft];

% Use the final two seconds as steady-state comparison.
mask = (t_sim >= p.Tstop-2*p.T0) & (t_sim <= p.Tstop);
t_sim_two = t_sim(mask) - (p.Tstop-2*p.T0);
y_sim_two = y_sim(mask);

f = figure('Name','Part v comparison','Color','w','Position',[100 100 950 500]);
plot(t_two,y_two,'LineWidth',1.8); hold on;
plot(t_sim_two,y_sim_two,'o','MarkerSize',4);
grid on;
xlabel('t  (seconds)');
ylabel('y(t)  (V)');
title('Two-period comparison: Fourier/IFFT output and Simscape output');
legend('truncated Fourier series','Simscape markers','Location','best');
xlim([0 2*p.T0]);

% RMS error after interpolation to the Fourier grid.
y_sim_interp = interp1(t_sim_two,y_sim_two,t_two,'linear','extrap');
rms_error = sqrt(mean((y_two-y_sim_interp).^2));
fprintf('Part (v)\n');
fprintf('  RMS difference between IFFT and Simscape comparison = %.6g\n\n', rms_error);

saveas(f,fullfile(figDir,'part_v_ifft_vs_simscape.png'));
savefig(f,fullfile(figDir,'part_v_ifft_vs_simscape.fig'));
save(fullfile(dataDir,'part_v_comparison.mat'), ...
    't_two','y_two','t_sim_two','y_sim_two','rms_error');
end
