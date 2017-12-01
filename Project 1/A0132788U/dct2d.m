function m = dct2d(m)
 [height, width] = size(m);
 m = dct1drow(m, height); % dct the rows
 m = dct1dcolumn(m, width); % dct the columns
end

function row_output = dct1drow(input, N)
    % N is the length of the ouput signal
    lambda = ones(1,N);
    lambda(1) = sqrt(1/2);
    c = zeros(1,N);
    row_output = zeros(N,N); %2D matrix
    for row = 1:N
       f = input(row,:); %extracted f = input[row], 1<=row<=N
       for n = 1:N %iterate over 1D row
           temp = 0;
           for k = 1:N %iterate over each element
               temp = temp + f(k)*cos((n-1)*(pi/N)*((k-1)+0.5));
           end
           c(n) = sqrt(2/N)*lambda(n)*temp;
       end
       row_output(row,:) = c;
    end
end

function col_output = dct1dcolumn(input, N)
    % N is the length of the ouput signal
    lambda = ones(1,N);
    lambda(1) = sqrt(1/2);
    c = zeros(1,N);
    col_output = zeros(N,N); %2D matrix
    for column = 1:N 
       f = input(:,column); %extracted f = input[column], 1<=column<=N
       for n = 1:N %iterate over 1D column
           temp = 0;
           for k = 1:N %iterate over each element
               temp = temp + f(k)*cos((n-1)*(pi/N)*((k-1)+0.5));
           end
           c(n) = sqrt(2/N)*lambda(n)*temp;
       end
       col_output(:,column) = c;
    end
end