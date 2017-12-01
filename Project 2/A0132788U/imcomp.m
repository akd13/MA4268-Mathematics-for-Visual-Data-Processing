function C = imcomp(m, ratio)
    [height, width] = size(m); %extract M and N
    
    block_rows = 8; % Rows in patch.
    block_columns = 8; % Columns in patch.
    
    m = double(m); %convert uint8 to double
    
    % Partition an image into 8X8 patches
    % and store each patch in a matrix P of size M/8 X N/8, where P{m,n} ⊂ R^(8×8).
    % Number of patches is (M*N)/64.
    P = block_patches(m, block_rows, block_columns, height, width); %contains patches of size 8X8
    
    C_coefficient_matrix = apply_dct(P,height,width,block_rows,block_columns);
    
    C_concatenated_matrix = cell2mat(C_coefficient_matrix); %concatenate all 8X8 patches
    
    C = int32(C_concatenated_matrix); %convert all entries to 32-bit signed integers
    
    num_entries_tozero = ceil((1-1/ratio)*height*width); %find number of entries to be made zero
    
    C_abs = abs(C);
    C_1D = C_abs(:); %unravel to a 1D matrix of absolute values
    
    [A,I] = mink(C_1D,num_entries_tozero); %find the indices of minimum magnitude entries to be set to 0
    
    C_1D = C(:); % convert C to a 1D matrix
    
    C_1D = set_values_to_zero(C_1D,I,num_entries_tozero);
    
    C = reshape(C_1D,[height,width]); %convert C_1D back to a 2D matrix.
    
    %out =nnz(~C) %check number of zeros for verification
end

% This function divides an M*N image into patches of 8X8 (or given block_rows,block_columns)
function C = block_patches(m, block_rows, block_columns, height, width)
    
    num_patch_rows = height/block_rows; %number of rows of the concatenated matrix containing image patches
    num_patch_columns = width/block_columns; %number of columns
        
    for i = 1:num_patch_rows
        for j = 1:num_patch_columns
            C(i,j) = mat2cell(m(8*i-7:i*8,8*j-7:8*j),block_rows,block_columns);%convert image patch to cell and store it
        end
    end
    
    %this is a faster way
    %C = mat2cell(m, ones(1,height/block_rows) * block_rows, ones(1,width/block_columns) * block_columns);
end

% This function applies DCT to each patch, then stores it back in the concatenated matrix.
function C = apply_dct(C,height,width,block_rows,block_columns)
    
    num_patch_rows = height/block_rows; %number of rows of the concatenated matrix containing image patches
    num_patch_columns = width/block_columns; %number of columns
    
    for i = 1:num_patch_rows
        for j = 1:num_patch_columns
            A = dct2(cell2mat(C(i,j))); %apply DCT to the [i,j] patch
            C(i,j) = mat2cell(A,8,8);  %store the patch back in the concatenated matrix
        end
    end
end

% This function sets the minimum magnitude values to zero, according to the indices found in the 1D matrix.
function C = set_values_to_zero(C,I,num_entries_tozero)
    for i = 1:num_entries_tozero
        C(I(i)) = 0;
    end
end