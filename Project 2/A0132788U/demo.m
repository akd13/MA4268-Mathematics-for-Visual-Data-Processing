im_1 = imread('sample.png');
r = 10;
c = imcomp(im_1,r);
im_2 = imdecomp(c);
imwrite(im_2,'sample_new.png')
subplot(1,2,1); imshow(im_1) 
subplot(1,2,2); imshow(im_2);