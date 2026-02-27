function [ data_out, ir, jc ] = sparse2CSC( A )
%SPARSE2CSR CSC representation of sparse matrix
%   A: sparse matix
%   data: == A(:)
%   ir: (0-based) row index of each data value
%   jc: (0-based) indices into data

[ir,col,data] = find(A);
jc = [0; cumsum(accumarray(col,1,[size(A,2) 1]))];
ir = ir-1;

if ~isreal(data)
    data_out.real = real(data);
    data_out.imag = imag(data);
else
    data_out = data;
end

