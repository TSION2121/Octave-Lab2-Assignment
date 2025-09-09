## Q02: resize_maintain_aspect
## Saves resized image and a side-by-side comparison figure.
## Usage:
##   J = Q02_resize_maintain_aspect();             % uses BASE_IMG, 200x200
##   J = Q02_resize_maintain_aspect(img, W, H, outdir)
function J = Q02_resize_maintain_aspect(img_path, targetW, targetH, outdir)
  pkg load image; config; addpath('scripts');
  outdir = ensure_outdir(exist('outdir','var') && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end
  if nargin < 2 || isempty(targetW), targetW = 200; end
  if nargin < 3 || isempty(targetH), targetH = 200; end

  I = imread(img_path);
  [H, W, ~] = size(I);
  scale = min(targetW / W, targetH / H);
  newW = max(1, round(W * scale)); newH = max(1, round(H * scale));
  J = imresize(I, [newH, newW]);

  imwrite(J, fullfile(outdir, sprintf('Q02_resized_%dx%d_%s.png', newW, newH, ts())));
  figure('Visible','off'); subplot(1,2,1); imshow(I); title(sprintf('Original (%dx%d)', W, H));
  subplot(1,2,2); imshow(J); title(sprintf('Resized (%dx%d)', newW, newH));
  save_current_figure_png(fullfile(outdir, sprintf('Q02_compare_%s.png', ts()))); close;
end

