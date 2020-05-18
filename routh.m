%         ***** MATLAB Code Starts Here
%
function a = routh(x)
%ROUTH
%
%		a = routh(x);
%
%	Function to create the Routh array for a nth degree
%	polynomial to determine the number of roots of the polynomial
%	with positive real parts.
%
%	x is the polynomial to be tested
%	a is the Routh array for polynomial x
%
n = length(x)-1;				% degree of x
%
if mod(n,2) == 0,				% no. of columns in array
	ncol=(n/2)+1;
else
	ncol=(n+1)/2;
end
%
a = zeros(n+1,ncol);				% initialize array
%
for i = 1:ncol					% 1st row of array
	a(1,i) = x(2*i-1);
end
%
for i = 1:ncol-1				% 2nd row of array
	a(2,i) = x(2*i);
end
%
if mod(n,2) == 1,
	a(2,ncol) = x(n+1);
end
%
for i = 3:n+1					% rest of the rows
for j = 1:ncol-1
	a(i,j) = (a(i-1,1)*a(i-2,j+1) - a(i-1,j+1)*a(i-2,1)) / a(i-1,1);
end
end

%
%         ***** MATLAB Code Stops Here
