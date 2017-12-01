function m = idct2d(m)
 [height, width] = size(m);
 m = idct1drow(m, height); % dct the rows
 m = idct1dcolumn(m, width); %dct the columns
end

function inverse_row_output = idct1drow(input, N)
    % N is the length of the ouput signal
    lambda = ones(1,N);
    lambda(1) = sqrt(1/2);
    f = zeros(1,N);
    inverse_row_output = zeros(N,N); %2D matrix
    for row = 1:N 
       c = input(row,:); %extracted c = input[row], 1<=row<=N
       for k = 1:N %iterate over 1D row
           temp = 0;
           for n = 1:N %iterate over each element
               temp = temp + lambda(n)*c(n)*cos((n-1)*(pi/N)*((k-1)+0.5));
           end
           f(k) = sqrt(2/N)*temp;
       end
       inverse_row_output(row,:) = f;
    end
end

function inverse_col_output = idct1dcolumn(input, N)
    % N is the length of the ouput signal
    lambda = ones(1,N);
    lambda(1) = sqrt(1/2);
    f = zeros(1,N);
    inverse_col_output = zeros(N,N); %2D matrix
    for column = 1:N 
       c = input(:,column); %extracted c = input[column], 1<=column<=N
       for k = 1:N %iterate over 1D column
           temp = 0;
           for n = 1:N %iterate over each element
               temp = temp + lambda(n)*c(n)*cos((n-1)*(pi/N)*((k-1)+0.5));
           end
           f(k) = sqrt(2/N)*temp;
       end
       inverse_col_output(:,column) = f;
    end
end