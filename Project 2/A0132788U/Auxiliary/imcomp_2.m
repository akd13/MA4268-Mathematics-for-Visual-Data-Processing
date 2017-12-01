function C = imcomp(m, ratio)
    [height, width] = size(m); %extract M and N
    
    block_rows = 8; % Rows in patch.
    block_columns = 8; % Columns in patch.
    
    m = double(m); %convert uint8 to double
    
    %apply DCT to each of the image patches and concatenate co-efficients
    dct_function = @(block_struct) dct2(block_struct.data);
    C = blockproc(m,[block_rows block_columns],dct_function);
    C = int32(C); %convert all entries to 32-bit signed integers
    
    num_entries_tozero = ceil((1-1/ratio)*height*width); %find number of entries to be made zero
   
    C_abs = abs(C); 
    C_1D = C_abs(:);
    [A,I] = mink(C_1D,num_entries_tozero); %find the values to be set to 0
    
    C_1D = C(:); %convert C to a 1D matrix   
    
    for i = 1:num_entries_tozero
        C_1D(I(i)) = 0;
    end   
    
    C = reshape(C_1D,[height,width]); %convert C_1D back to 2D.
    
    %out =nnz(~C); %check number of zeros 
end