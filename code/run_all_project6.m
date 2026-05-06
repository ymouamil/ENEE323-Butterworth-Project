%% ENEE322/323 Project 6
% Pulse-wave response of a third-order Butterworth lowpass RLC filter
% Put this file inside the /code folder, then run it.

clear; clc; close all;

%% Paths
thisFile = mfilename('fullpath');
codeDir  = fileparts(thisFile);
rootDir  = fileparts(codeDir);
figDir   = fullfile(rootDir,'figures');
dataDir  = fullfile(rootDir,'data');
simDir   = fullfile(rootDir,'simulink');

if ~exist(figDir,'dir'), mkdir(figDir); end
if ~exist(dataDir,'dir'), mkdir(dataDir); end
if ~exist(simDir,'dir'), mkdir(simDir); end

%% Project constants
p.T0     = 1.0;              % seconds
p.alpha  = 0.40;             % duty cycle
p.Omega0 = 2*pi/p.T0;        % rad/s
p.beta   = 50/3;             % rad/s
p.N      = 1000;             % samples per period
p.Kmax   = 100;              % harmonic cutoff
p.Ts_sim = 0.020;            % Simulink sampling period
p.Tstop  = 10*p.T0;          % total simulation time

% H(s) = beta^3/(s^3 + 2 beta s^2 + 2 beta^2 s + beta^3)
p.num = p.beta^3;
p.den = [1, 2*p.beta, 2*p.beta^2, p.beta^3];

fprintf('\n============================================================\n');
fprintf(' ENEE322/323 Project 6: Butterworth pulse response\n');
fprintf('============================================================\n');
fprintf('beta = %.10g rad/s, Omega0 = %.10g rad/s\n', p.beta, p.Omega0);
fprintf('T0 = %.3f s, duty cycle = %.1f%%\n\n', p.T0, 100*p.alpha);

%% Part (i)
part_i_frequency_response(p, figDir, dataDir);

%% Part (ii)
part_ii_write_equations(p, fullfile(rootDir,'docs'));

%% Part (iii)
part_iii_ifft_response(p, figDir, dataDir);

%% Part (iv) helper
part_iv_make_simulink_helper(p, simDir, figDir, dataDir);

%% Part (v) will run only if Simulink export data exists
part_v_compare_if_available(p, figDir, dataDir);

fprintf('\nDone. Check /figures and /data.\n');
fprintf('For part (iv), build/run the Simscape circuit, export data, then rerun part_v_compare_if_available.\n');
