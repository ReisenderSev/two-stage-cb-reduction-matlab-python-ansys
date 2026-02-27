function writeHBbinRSA(filename, A )
%WRITEHBBINRSA writes A to sparse Harwell boeing file
%   only for sparse real symmetric matrices

assert(isreal(A))
assert(issymmetric(A))

[ vals, ir, jc ] = sparse2CSC( tril(A) );
ir = ir+1;
jc = jc+1;
%%

PTRCRD = length(jc);
INDCRD = length(ir);
VALCRD = length(vals);
RHSCRD = 0;
TOTCRD = PTRCRD + INDCRD + VALCRD;

MXTYPE = uint8('RSA');
NROW = size(A,1);
NCOL =  size(A,2);
NNZERO = VALCRD;
NELTVL = 0;

nBytes1 = PTRCRD * 8;
nBytes2 = INDCRD * 4;
nBytes3 = VALCRD * 8;
%%

copyfile('C:\Leibniz_Uni\AnsysEigsinMatlab\HBtemplate',filename)

fid = fopen(filename,'r+');
fseek(fid,92,'bof');
fwrite(fid,TOTCRD,'uint32');
fwrite(fid,PTRCRD,'uint32');
fwrite(fid,INDCRD,'uint64');
fwrite(fid,VALCRD,'uint64');
fwrite(fid,RHSCRD,'uint32');

fseek(fid,128,'bof');
fwrite(fid,MXTYPE,'uint8');
fwrite(fid,NROW,'uint32');
fwrite(fid,NCOL,'uint32');
fwrite(fid,NNZERO,'uint32');
fwrite(fid,NELTVL,'uint64');

fseek(fid,235,'bof');
fwrite(fid,nBytes1,'uint32');
fwrite(fid,jc,'uint64');
fwrite(fid,[nBytes1;nBytes2],'uint32');
fwrite(fid,ir,'uint32');
fwrite(fid,[nBytes2;nBytes3],'uint32');
fwrite(fid,vals,'double');
fwrite(fid,nBytes3,'uint32');
fclose(fid);

end

