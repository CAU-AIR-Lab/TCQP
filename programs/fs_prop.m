function ret = fs_prop( data, label, opt )
col = size(data, 2);
ret = zeros( col, 1 );

if strcmp( opt, 'ig' )
    cvec = zeros( col, 1 );
    Q = zeros( col, col );
    
    for i=1:col
        [a, b, c, d] = cal_abcd( data(:, i), label );
        cvec(i, 1) = cal_ig( a, b, c, d );
    end
    for i=1:col
        for j=(i+1):col
            [a, b, c, d] = cal_abcd( data(:, i), data(:, j) );
            Q(i, j) = cal_ig( a, b, c, d );
        end
        if mod(i, 500) == 0
            fprintf('%d\n', i);
        end
    end
    Q = Q + Q';
    
    Q(isnan(Q)) = 0;
    Q(isinf(Q)) = 0;
    cvec(isnan(cvec)) = 0;
    cvec(isinf(cvec)) = 0;
    
    [U, S] = eig( Q );
    nu = min(diag(S));
    Vs = U * diag( ( 1 / abs ( diag( S ) ) ) ) * ( ( S - ( nu - eps ) * eye(col) ).^0.5 );
    Q = Q * ( Vs * Vs' ) * Q;
    Q = (Q + Q') / 2;
    
    % set constraints and algorithm for quadratic programming
    A = -eye( col );
    b = zeros( col, 1 );
    Aeq = ones( 1, col );
    beq = 1;
    opts = optimoptions('quadprog', 'Algorithm', 'interior-point-convex', 'Display', 'off');
    
    ret(:, 1) = quadprog( Q, -cvec, A, b, Aeq, beq, [], [], [], opts );
    [~, ret] = sort(ret, 'descend');
    return;
elseif strcmp( opt, 'chi' )
    cvec = zeros( col, 2 );
    Q = zeros( col, col, 2 );
    
    for i=1:col
        [a, b, c, d] = cal_abcd( data(:, i), label );
        [cvec(i, 1), cvec(i, 2)] = cal_chi( a, b, c, d );
    end
    for i=1:col
        for j=(i+1):col
            [a, b, c, d] = cal_abcd( data(:, i), data(:, j) );
            [Q(i, j, 1), Q(i, j, 2)] = cal_chi( a, b, c, d );
        end
        if mod(i, 500) == 0
            fprintf('%d\n', i);
        end
    end
else % mi
    cvec = zeros( col, 2 );
    Q = zeros( col, col, 2 );
    
    for i=1:col
        [a, b, c, d] = cal_abcd( data(:, i), label );
        [cvec(i, 1), cvec(i, 2)] = cal_mi( a, b, c, d );
    end
    for i=1:col
        for j=(i+1):col
            [a, b, c, d] = cal_abcd( data(:, i), data(:, j) );
            [Q(i, j, 1), Q(i, j, 2)] = cal_mi( a, b, c, d );
        end
        if mod(i, 500) == 0
            fprintf('%d\n', i);
        end
    end
end
Q(:, :, 1) = Q(:, :, 1) + Q(:, :, 1)';
Q(:, :, 2) = Q(:, :, 2) + Q(:, :, 2)';
Q(isnan(Q)) = 0;
Q(isinf(Q)) = 0;
cvec(isnan(cvec)) = 0;
cvec(isinf(cvec)) = 0;

[U1, S1] = eig( Q(:, :, 1) );
nu1 = min(diag(S1));
Vs1 = U1 * diag( ( 1 / abs ( diag( S1 ) ) ) ) * ( ( S1 - ( nu1 - eps ) * eye(col) ).^0.5 );
Q(:, :, 1) = Q(:, :, 1) * ( Vs1 * Vs1' ) * Q(:, :, 1)';
Q(:, :, 1) = (Q(:, :, 1) + Q(:, :, 1)') / 2;

[U2, S2] = eig( Q(:, :, 2) );
nu2 = min(diag(S2));
Vs2 = U2 * diag( ( 1 / abs ( diag( S2 ) ) ) ) * ( ( S2 - ( nu2 - eps ) * eye(col) ).^0.5 );
Q(:, :, 2) = Q(:, :, 2) * ( Vs2 * Vs2' ) * Q(:, :, 2)';
Q(:, :, 2) = (Q(:, :, 2) + Q(:, :, 2)') / 2;

% set constraints and algorithm for quadratic programming
A = -eye( col );
b = zeros( col, 1 );
Aeq = ones( 1, col );
beq = 1;
opts = optimoptions('quadprog', 'Algorithm', 'interior-point-convex', 'Display', 'off');

ret(:, 1) = quadprog( Q(:, :, 1), -cvec(:, 1), A, b, Aeq, beq, [], [], [], opts );
ret(:, 2) = quadprog( Q(:, :, 2), -cvec(:, 2), A, b, Aeq, beq, [], [], [], opts );
[~, ret] = sort(ret, 1, 'descend');

end