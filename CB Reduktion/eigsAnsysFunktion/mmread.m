function  [A,rows,cols,entries,rep,field,symm] = mmread(filename)
%
% function  [A] = mmread(filename)
%
% function  [A,rows,cols,entries,rep,field,symm] = mmread(filename)
%
%      Reads the contents of the Matrix Market file 'filename'
%      into the matrix 'A'.  'A' will be either sparse or full,
%      depending on the Matrix Market format indicated by
%      'coordinate' (coordinate sparse storage), or
%      'array' (dense array storage).  The data will be duplicated
%      as appropriate if symmetry is indicated in the header.
%
%      Optionally, size information about the matrix can be
%      obtained by using the return values rows, cols, and
%      entries, where entries is the number of nonzero entries
%      in the final matrix. Type information can also be retrieved
%      using the optional return values rep (representation), field,
%      and symm (symmetry).
%
% Based on mmread from math.nist.gov/MatrixMarket/mmio/matlab/mmiomatlab.html
% Edits by Lukas Schwerdt

mmfile = fopen(filename,'r');
if ( mmfile == -1 )
    disp(filename);
    error('File not found');
end

header = fgets(mmfile);
if (header == -1 )
    error('Empty file.')
end

% NOTE: If using a version of Matlab for which strtok is not
%       defined, substitute 'gettok' for 'strtok' in the
%       following lines, and download gettok.m from the
%       Matrix Market site.
[head0,header]   = strtok(header);  % see note above
[head1,header]   = strtok(header);
[rep,header]     = strtok(header);
[field,header]   = strtok(header);
[symm,header]    = strtok(header);
head1 = lower(head1);
rep   = lower(rep);
field = lower(field);
symm  = lower(symm);
if isempty(symm)
    disp(['Not enough words in header line of file ',filename])
    disp('Recognized format: ')
    disp('%%MatrixMarket matrix representation field symmetry')
    error('Check header line.')
end
if ( ~ strcmp(head0,'%%MatrixMarket') )
    error('Not a valid MatrixMarket header.')
end
if (  ~ strcmp(head1,'matrix') )
    disp(['This seems to be a MatrixMarket ',head1,' file.']);
    disp('This function only knows how to read MatrixMarket matrix files.');
    disp('  ');
    error('  ');
end

% Read through comments, ignoring them

commentline = fgets(mmfile);
while length(commentline) > 0 && commentline(1) == '%'
    commentline = fgets(mmfile);
end

% Read size information, then branch according to
% sparse or dense format

if ( strcmp(rep,'coordinate')) %  read matrix given in sparse
    %  coordinate matrix format
    
    [sizeinfo,count] = sscanf(commentline,'%d%d%d');
    while ( count == 0 )
        commentline =  fgets(mmfile);
        if (commentline == -1 )
            error('End-of-file reached before size information was found.')
        end
        [sizeinfo,count] = sscanf(commentline,'%d%d%d');
        if ( count > 0 && count ~= 3 )
            error('Invalid size specification line.')
        end
    end
    rows = sizeinfo(1);
    cols = sizeinfo(2);
    entries = sizeinfo(3);
    
    if  ( strcmp(field,'real') )               % real valued entries:
        A = textscan(fread(mmfile,'uint8=>char'), '%f %f %f');
        if numel(A{1}) ~= entries || numel(A{2}) ~= entries || numel(A{3}) ~= entries
            nnzerror()
        end
        A = sparse(A{1}, A{2}, A{3}, rows , cols);
        
    elseif   ( strcmp(field,'complex'))            % complex valued entries:
        A = textscan(fread(mmfile,'uint8=>char'), '%f %f %f %f');
        if numel(A{1}) ~= entries || numel(A{2}) ~= entries || numel(A{3}) ~= entries || numel(A{4}) ~= entries
            nnzerror()
        end
        A = sparse(A{1}, A{2}, A{3} + 1i*A{4}, rows, cols);
        
    elseif  ( strcmp(field,'pattern'))    % pattern matrix (no values given):
        
        A = textscan(fread(mmfile,'uint8=>char'), '%f %f');
        if numel(A{1}) ~= entries || numel(A{2}) ~= entries
            nnzerror()
        end
        A = sparse(A{1}, A{2}, ones(entries,1), rows , cols);
    end
    
elseif ( strcmp(rep,'array') ) %  read matrix given in dense
    %  array (column major) format
    
    [sizeinfo,count] = sscanf(commentline,'%d%d');
    while ( count == 0 )
        commentline =  fgets(mmfile);
        if (commentline == -1 )
            error('End-of-file reached before size information was found.')
        end
        [sizeinfo,count] = sscanf(commentline,'%d%d');
        if ( count > 0 && count ~= 2 )
            error('Invalid size specification line.')
        end
    end
    rows = sizeinfo(1);
    cols = sizeinfo(2);
    entries = rows*cols;
    
    if  ( strcmp(field,'real') )               % real valued entries:
        A = sscanf(fread(mmfile,'uint8=>char'),'%f');
        
    elseif  ( strcmp(field,'complex'))         % complx valued entries:
        A = textscan(fread(mmfile,'uint8=>char'), '%f %f');
        A = A{1} + A{2} * 1i;
        
    elseif  ( strcmp(field,'pattern'))    % pattern (makes no sense for dense)
        disp(['Matrix type:',field])
        error('Pattern matrix type invalid for array storage format.');
        
    else                                 % Unknown matrix type
        disp(['Matrix type:',field])
        error('Invalid matrix type specification. Check header against MM documentation.');
    end
    
    if strcmp(symm,'symmetric') || strcmp(symm,'hermitian')        
        source_idx = length(A);
        A(rows*cols) = 0;
        for j = cols:-1:2
            ii = j*rows;
            nnzcol = rows - j;
            A(ii-rows+1:ii) = [zeros(j-1,1); A(source_idx-nnzcol:source_idx)];
            source_idx = source_idx - (nnzcol+1);
        end
    elseif strcmp(symm,'skew-symmetric')
        source_idx = length(A);
        A(rows*cols) = 0;
        for j = cols-1:-1:1
            ii = j*rows;
            nnzcol = rows - j-1;
            A(ii-rows+1:ii) = [zeros(j,1); A(source_idx-nnzcol:source_idx)];
            source_idx = source_idx - (nnzcol+1);
        end
    elseif ~strcmp(symm,'general')
        symerror(symm)
    end
    
    A = reshape(A,rows,cols);
end

%
% If symmetric, skew-symmetric or Hermitian, duplicate lower
% triangular part and modify entries as appropriate:
%
if ( strcmp(symm,'symmetric') )
    A = A + A.' - diag(diag(A));
    entries = nnz(A);
elseif ( strcmp(symm,'hermitian') )
    A = A + A' - diag(diag(A));
    entries = nnz(A);
elseif ( strcmp(symm,'skew-symmetric') )
    A = A - A';
    entries = nnz(A);
end

fclose(mmfile);
% Done.
end


%%
function nnzerror()
message = ...
    str2mat('Data file does not contain expected amount of data.',...
    'Check that number of data lines matches nonzero count.');
disp(message);
error('Invalid data.');
end

function symerror(symm)
disp('Unrecognized symmetry')
disp(symm)
disp('Recognized choices:')
disp('   symmetric')
disp('   hermitian')
disp('   skew-symmetric')
disp('   general')
error('Check symmetry specification in header.');
end