## Q05: resize_with_interpolation (nearest, bilinear, bicubic)
## Saves each result + comparison figure.
function [N,Bi,Bc] = Q05_resize_with_interpolation(img_path, scale, outdir)
  config; pkg load image; addpath('scripts');
  outdir = ensure_outdir(nargin>=3 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end
  if nargin < 2 || isempty(scale),   scale = 2.0; end

  I  = imread(img_path);
  N  = imresize(I, scale, 'nearest');
  Bi = imresize(I, scale, 'bilinear');
  Bc = imresize(I, scale, 'bicubic');

  imwrite(N,  fullfile(outdir, sprintf('Q05_nearest_%s.png', ts())));
  imwrite(Bi, fullfile(outdir, sprintf('Q05_bilinear_%s.png', ts())));
  imwrite(Bc, fullfile(outdir, sprintf('Q05_bicubic_%s.png', ts())));

  figure('Visible','off');
  subplot(2,2,1); imshow(I);  title('Original');
  subplot(2,2,2); imshow(N);  title('Nearest');
  subplot(2,2,3); imshow(Bi); title('Bilinear');
  subplot(2,2,4); imshow(Bc); title('Bicubic');
  save_current_figure_png(fullfile(outdir, sprintf('Q05_compare_%s.png', ts()))); close;
end

