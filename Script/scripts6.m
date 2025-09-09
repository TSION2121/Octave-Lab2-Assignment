## Q06: rotate_image_any_angle
## Saves rotated image and comparison figure.
function J = Q06_rotate_image_any_angle(img_path, angle, outdir)
  config; pkg load image; addpath('scripts');
  outdir = ensure_outdir(nargin>=3 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end
  if nargin < 2 || isempty(angle),    angle = 33; end

  I = imread(img_path);
  J = imrotate(I, angle, 'bilinear', 'loose');
  imwrite(J, fullfile(outdir, sprintf('Q06_rotated_%gdeg_%s.png', angle, ts())));

  figure('Visible','off'); subplot(1,2,1); imshow(I); title('Original');
  subplot(1,2,2); imshow(J); title(sprintf('Rotated %g°', angle));
  save_current_figure_png(fullfile(outdir, sprintf('Q06_compare_%s.png', ts()))); close;
end

