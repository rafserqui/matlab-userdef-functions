function [X] = spatial_noise(N)
%spatial_noise - Description
%
% Syntax: [X] = spatial_noise(N)
%       - N is the number of points
% Long description
% Create spatially correlated noise
    
    % Generate a grid of random phase shifts
    phi = rand(N,N);

    % Correlation parameter
    bett = -2.5;

    % First quadrant are positive frequencies.  Zero frequency is at u(1,1).
    u = [(0:floor(N/2)) -(ceil(N/2)-1:-1:1)]'/N;

    % Reproduce these frequencies along every row
    u = repmat(u,1,N);

    % v is the set of frequencies along the second dimension.  For a square
    % region it will be the transpose of u
    v = u';

    % Generate the power spectrum
    S_f = (u.^2 + v.^2).^(bett/2);

    % Set any infinities to zero
    S_f(S_f==inf) = 0;

    % Inverse Fourier transform to obtain the the spatial pattern
    X = ifft2(sqrt(S_f).*(cos(2*pi*phi(:,:,1))+1i*sin(2*pi*phi(:,:))));
    X = exp(real(X));
end