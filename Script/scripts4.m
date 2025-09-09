## Q04: crop_roi
## Saves cropped ROI and comparison figure with rectangle overlay.
function C = Q04_crop_roi(img_path, tl, br, outdir)
  config; pkg load image; addpath('scripts');
  outdir = ensure_outdir(nargin>=4 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end
  if nargin < 2 || isempty(tl), tl = [30, 30]; end
  if nargin < 3 || isempty(br), br = [150, 120]; end

  I = imread(img_path);
  [H,W,~] = size(I);
  x1 = max(1, min(W, round(tl(1)))); y1 = max(1, min(H, round(tl(2))));
  x2 = max(1, min(W, round(br(1)))); y2 = max(1, min(H, round(br(2))));
  if x2 < x1, t = x1; x1 = x2; x2 = t; end
  if y2 < y1, t = y1; y1 = y2; y2 = t; end

  C = I(y1:y2, x1:x2, :);
  imwrite(C, fullfile(outdir, sprintf('Q04_crop_%dx%d_%s.png', x2-x1+1, y2-y1+1, ts())));

  figure('Visible','off'); subplot(1,2,1); imshow(I); title('Original'); hold on;
  rectangle('Position',[x1,y1,(x2-x1+1),(y2-y1+1)],'EdgeColor','r','LineWidth',2);
  subplot(1,2,2); imshow(C); title('Cropped ROI');
  save_current_figure_png(fullfile(outdir, sprintf('Q04_compare_%s.png', ts()))); close;
end

