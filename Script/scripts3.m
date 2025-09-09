## Q03: grayscale_conversions (average, luminosity, desaturation)
## Saves each grayscale result + a comparison figure.
function [Gavg, Glum, Gdesat] = Q03_grayscale_conversions(img_path, outdir)
  pkg load image; config; addpath('scripts');
  outdir = ensure_outdir(nargin>=2 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end

  I = im2double(imread(img_path));
  if size(I,3) == 1, I = cat(3,I,I,I); end
  R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
  Gavg   = (R + G + B) / 3;
  Glum   = 0.299*R + 0.587*G + 0.114*B;
  Gdesat = (max(max(R,G),B) + min(min(R,G),B)) / 2;

  imwrite(Gavg,   fullfile(outdir, sprintf('Q03_avg_%s.png', ts())));
  imwrite(Glum,   fullfile(outdir, sprintf('Q03_lum_%s.png', ts())));
  imwrite(Gdesat, fullfile(outdir, sprintf('Q03_desat_%s.png', ts())));

  figure('Visible','off');
  subplot(2,2,1); imshow(I);      title('Original');
  subplot(2,2,2); imshow(Gavg);   title('Average');
  subplot(2,2,3); imshow(Glum);   title('Luminosity');
  subplot(2,2,4); imshow(Gdesat); title('Desaturation');
  save_current_figure_png(fullfile(outdir, sprintf('Q03_compare_%s.png', ts()))); close;
end

