% Submission by: Akankshita Dash
% Matric number: A0132788U
tic
im_1 = double(imread('sample.png')); 
coeff = dct2d(im_1);
im_2 = uint8(idct2d(coeff));   
subplot(1,2,1); imagesc(coeff);colorbar;
subplot(1,2,2); imshow(im_2);
toc