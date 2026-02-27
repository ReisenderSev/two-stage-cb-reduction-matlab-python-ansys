function Phi = massNorm(Phi, M)
%MASSNORM scales Phi so that Phi'*M*Phi = eye
%   only calculates diagonal of Phi'*M*Phi

Phi = Phi./sqrt(sum((Phi'*M).' .* Phi,1));
end

