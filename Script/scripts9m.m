## Q09: load_and_compare_color_spaces (RGB/HSV + simulated CMYK)
## Saves comparison figure.
function Q09_load_and_compare_color_spaces(img_path, outdir)
  config; pkg load image; addpath('scripts');
  outdir = ensure_outdir(nargin>=2 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end

  I = im2double(imread(img_path));
  if size(I,3) == 1, I = cat(3,I,I,I); end
  HSV = rgb2hsv(I);
  C = 1 - I(:,:,1); M = 1 - I(:,:,2); Y = 1 - I(:,:,3);
  K = min(min(C, M), Y);
  C = (C - K) ./ (1 - K + eps);
  M = (M - K) ./ (1 - K + eps);
  Y = (Y - K) ./ (1 - K + eps);

  figure('Visible','off');
  subplot(2,3,1); imshow(I);           title('RGB');
  subplot(2,3,2); imshow(HSV(:,:,1));  title('HSV - H');
  subplot(2,3,3); imshow(HSV(:,:,2));  title('HSV - S');
  subplot(2,3,4); imshow(HSV(:,:,3));  title('HSV - V');
  subplot(2,3,5); imshow(cat(3,C,M,Y)); title('Simulated CMY');
  subplot(2,3,6); imshow(K);           title('K (black)');
  save_current_figure_png(fullfile(outdir, sprintf('Q09_compare_%s.png', ts()))); close;
end

