function part_iv_make_simulink_helper(p, simDir, figDir, dataDir)
% Part (iv): writes a Simscape checklist and plotting script.
% The assignment asks for a Simscape Electrical circuit, so the checklist
% emphasizes the physical circuit rather than a shortcut Transfer Fcn block.

checklist = fullfile(simDir,'PART_IV_SIMSCAPE_BUILD_NOTES.txt');
fid = fopen(checklist,'w');
fprintf(fid,'Part (iv): Simscape Electrical circuit checklist\n');
fprintf(fid,'============================================================\n\n');
fprintf(fid,'Build the physical RLC network, not just a Transfer Fcn shortcut.\n\n');
fprintf(fid,'Circuit topology:\n');
fprintf(fid,'  pulse voltage source -> 9 H inductor -> node -> 3 H inductor -> 100 ohm resistor -> electrical reference\n');
fprintf(fid,'                                      |\n');
fprintf(fid,'                                   800 uF capacitor\n');
fprintf(fid,'                                      |\n');
fprintf(fid,'                              electrical reference\n\n');
fprintf(fid,'Blocks to use:\n');
fprintf(fid,'  Simscape / Utilities / Solver Configuration\n');
fprintf(fid,'  Simscape / Electrical / Electrical Elements / Electrical Reference\n');
fprintf(fid,'  Simscape / Electrical / Sources / Controlled Voltage Source or Pulse Voltage Source\n');
fprintf(fid,'  Simscape / Electrical / Electrical Elements / Inductor\n');
fprintf(fid,'  Simscape / Electrical / Electrical Elements / Capacitor\n');
fprintf(fid,'  Simscape / Electrical / Electrical Elements / Resistor\n');
fprintf(fid,'  Simscape / Electrical / Sensors / Voltage Sensor\n');
fprintf(fid,'  Simscape / Utilities / PS-Simulink Converter\n');
fprintf(fid,'  Simulink / Sinks / To Workspace\n\n');
fprintf(fid,'Parameters:\n');
fprintf(fid,'  L1 = 9 H\n');
fprintf(fid,'  C  = 800e-6 F\n');
fprintf(fid,'  L2 = 3 H\n');
fprintf(fid,'  R  = 100 ohm\n');
fprintf(fid,'  Pulse amplitude = 1 V\n');
fprintf(fid,'  Period = %.3f s\n', p.T0);
fprintf(fid,'  Duty cycle = %.1f percent\n', 100*p.alpha);
fprintf(fid,'  Stop time = %.3f s\n', p.Tstop);
fprintf(fid,'  Sampling period = %.3f s\n\n', p.Ts_sim);
fprintf(fid,'Export variable names expected by the comparison script:\n');
fprintf(fid,'  t_sim : time vector\n');
fprintf(fid,'  x_sim : input voltage vector\n');
fprintf(fid,'  y_sim : output voltage across the 100 ohm resistor\n\n');
fprintf(fid,'After the simulation, save them with:\n');
fprintf(fid,'  save(''../data/part_iv_simscape_output.mat'',''t_sim'',''x_sim'',''y_sim'');\n');
fclose(fid);

plotScript = fullfile(simDir,'plot_simscape_export.m');
fid = fopen(plotScript,'w');
fprintf(fid,'%% Plot exported Simscape results for Part (iv)\n');
fprintf(fid,'%% Expected variables: t_sim, x_sim, y_sim\n');
fprintf(fid,'figure(''Color'',''w'');\n');
fprintf(fid,'plot(t_sim,x_sim,''LineWidth'',1.2); hold on;\n');
fprintf(fid,'plot(t_sim,y_sim,''LineWidth'',1.5);\n');
fprintf(fid,'grid on; xlabel(''t (seconds)''); ylabel(''voltage (V)'');\n');
fprintf(fid,'title(''Simscape input and output'');\n');
fprintf(fid,'legend(''input x(t)'',''output y(t)'',''Location'',''best'');\n');
fprintf(fid,'saveas(gcf,fullfile(''..'',''figures'',''part_iv_simscape_input_output.png''));\n');
fprintf(fid,'savefig(gcf,fullfile(''..'',''figures'',''part_iv_simscape_input_output.fig''));\n');
fprintf(fid,'save(fullfile(''..'',''data'',''part_iv_simscape_output.mat''),''t_sim'',''x_sim'',''y_sim'');\n');
fclose(fid);

fprintf('Part (iv)\n');
fprintf('  Simscape build notes written to %s\n', checklist);
fprintf('  Plot helper written to %s\n\n', plotScript);
end
