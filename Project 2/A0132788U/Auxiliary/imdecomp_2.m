function C = imdecomp(m)
    [height, width] = size(m);
    block_rows = 8;
    block_columns = 8;
    
    m = double(m); %convert int32 to double
    
    %apply inverse DCT to each of the image patches and concatenate co-efficients
    idct_function = @(block_struct) idct2(block_struct.data);
    
    %convert to unsigned 8-bit integer
    C = uint8(blockproc(m,[block_rows block_columns],idct_function));
end