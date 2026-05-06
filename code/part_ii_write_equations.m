function part_ii_write_equations(p, docsDir)
% Part (ii): write the Fourier-series equations to a text file.

if ~exist(docsDir,'dir'), mkdir(docsDir); end
outFile = fullfile(docsDir,'part_ii_equations.txt');
fid = fopen(outFile,'w');

fprintf(fid,'Part (ii): Fourier-series output equation\n');
fprintf(fid,'============================================================\n\n');
fprintf(fid,'The input pulse train is real and even, so\n\n');
fprintf(fid,'  x(t) = sum_{k=-inf}^{inf} X_k exp(j k Omega0 t),\n');
fprintf(fid,'  X_k = sin(k alpha pi)/(k pi), k not 0,\n');
fprintf(fid,'  X_0 = alpha.\n\n');
fprintf(fid,'For this project, alpha = %.2f and Omega0 = 2*pi rad/s.\n\n', p.alpha);
fprintf(fid,'Because the circuit is LTI, each harmonic is multiplied by H(j k Omega0):\n\n');
fprintf(fid,'  Y_k = X_k H(j k Omega0),\n');
fprintf(fid,'  y(t) = sum_{k=-inf}^{inf} X_k H(j k Omega0) exp(j k Omega0 t).\n\n');
fprintf(fid,'Using conjugate symmetry, the real cosine form is\n\n');
fprintf(fid,'  y(t) = alpha H(0) + 2 sum_{k=1}^{inf} X_k |H(j k Omega0)|\n');
fprintf(fid,'         cos(k Omega0 t + angle H(j k Omega0)).\n\n');
fprintf(fid,'Here H(0)=1, so the DC term is alpha = %.2f.\n\n', p.alpha);
fprintf(fid,'Important: keep X_k with its sign. Do not replace X_k by |X_k| unless\n');
fprintf(fid,'the missing pi phase for negative X_k is also included.\n');
fclose(fid);

fprintf('Part (ii)\n');
fprintf('  Equations written to %s\n\n', outFile);
end
