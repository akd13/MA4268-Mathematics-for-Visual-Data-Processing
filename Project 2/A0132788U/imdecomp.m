function C = imdecomp(m)
    [height, width] = size(m);
    block_rows = 8;
    block_columns = 8;
    
    m = double(m); %convert int32 to double
    
    P = block_patches(m, block_rows, block_columns, height, width); % contains patches of size 8X8
    
    C_coefficient_matrix = apply_idct(P,height,width,block_rows,block_columns); %apply inverse DCT to the patches
    
    C_concatenated_matrix = cell2mat(C_coefficient_matrix); %concatenate all 8X8 patches
    
    C = uint8(C_concatenated_matrix); %convert to unsigned 8-bit integer
end

function C = block_patches(m, block_rows, block_columns, height, width)
    num_patch_rows = height/block_rows; %number of rows of the concatenated matrix containing image patches
    num_patch_columns = width/block_columns; %number of columns
    for i = 1:num_patch_rows
        for j = 1:num_patch_columns
            C(i,j) = mat2cell(m(8*i-7:i*8,8*j-7:8*j),block_rows,block_columns);
        end
    end
end

function C = apply_idct(C,height,width,block_rows,block_columns)
    
    num_patch_rows = height/block_rows; %number of rows of the concatenated matrix containing image patches
    num_patch_columns = width/block_columns; %number of columns
    
    for i = 1:num_patch_rows
        for j = 1:num_patch_columns
            A = idct2(cell2mat(C(i,j))); %apply inverse DCT to the [i,j] patch
            C(i,j) = mat2cell(A,8,8);  %store the patch back in the concatenated matrix
        end
    end
end