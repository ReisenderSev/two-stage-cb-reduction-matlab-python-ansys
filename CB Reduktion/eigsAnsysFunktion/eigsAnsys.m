function [ Phi,Lambda ] = eigsAnsys( K,M,k )
%EIGSANSYS sparse eigenanalysis using ansys block lanczos solver
%   
% Parameters:
%   K,M: hermitian Matrices
%   k:   Number of eigenvalues to exract

%% check inputs
assert(size(K,1) == size(K,2));
assert(all(size(K) == size(M)));
assert(ishermitian(K));
assert(ishermitian(M));
assert(k <= size(K,1));

%% transform to problem with real matrices
isComplexProblem = ~isreal(K) || ~isreal(M);
if isComplexProblem
    % Numerical Recipes 3rd Edition: The Art of Scientific Computing p.590
    K = [real(K) -imag(K); imag(K) real(K)];
    M = [real(M) -imag(M); imag(M) real(M)];
    k = 2*k;
end

%% write matrices to disk
foldername = 'C:\Leibniz_Uni\AnsysEigsinMatlab\ansys';
mkdir(foldername);
copyfile('C:\Leibniz_Uni\AnsysEigsinMatlab\apdlscr.inp',foldername);

writeHBbinRSA(fullfile(foldername,'K.hbmat'), K )
writeHBbinRSA(fullfile(foldername,'M.hbmat'), M )

%% run apdl script
ansys_pfade = 'C:\Program Files\ANSYS Inc\ANSYS Student\v251\ansys\bin\winx64\ANSYS251.exe';
oldFolder = cd(foldername);
ansys_pathQ = ['"', ansys_pfade, '"'];
APDL_command = [ansys_pathQ,' ','-b ','-i ',pwd,'\apdlscr.inp ','-o ',pwd,'\apdlscr.out ','-nmodes ',num2str(k)];
system(APDL_command);
cd(oldFolder);

%% read results from disk
Lambda = mmread(fullfile(foldername,'Lambda.mmf'));
Phi = mmread(fullfile(foldername,'Phi.mmf'));

if isComplexProblem
    % transform problem to original size
    Lambda = Lambda(1:2:end);
    Phi = Phi(1:end/2,1:2:end) + 1i * Phi(end/2+1:end,1:2:end);
end

Lambda = (Lambda * 2 * pi).^2; % convert f -> omega^2

%% delete files
rmdir(foldername,'s');
end

