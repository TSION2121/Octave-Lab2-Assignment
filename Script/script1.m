## Q01: import_images_with_colormaps
## Imports images from a directory and displays/saves with different colormaps.
## Usage:
##   imgs = Q01_import_images_with_colormaps();             % uses BASE_DIR from config.m
##   imgs = Q01_import_images_with_colormaps('path\to\dir', 'outputs');
function imgs = Q01_import_images_with_colormaps(dirpath, outdir)
  pkg load image
  config;                   % load BASE_DIR/OUTPUT_DIR
  addpath('scripts');       % ensure _utils is locatable
  outdir = ensure_outdir(nargin>=2 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(dirpath), dirpath = BASE_DIR; end
  exts = {'*.png','*.jpg','*.jpeg','*.bmp','*.tif','*.tiff'};
  files = {};
  for i=1:numel(exts), files = [files; cellstr(glob(fullfile(dirpath, exts{i})))]; end
  if isempty(files), warning('No images found in %s', dirpath); end

  imgs = struct('name', {}, 'data', {});
  cms = {'gray','hot','jet'};
  for i=1:numel(files)
    f = files{i};
    try
      I = imread(f);
      imgs(end+1).name = f;
      imgs(end).data   = I;
      for c=1:numel(cms)
        figure('Visible','off'); imshow(I, []); colormap(cms{c}); colorbar;
        title(sprintf('%s: %s', upper(cms{c}), f),'Interpreter','none');
        out = fullfile(outdir, sprintf('Q01_%s_%s_%s.png', cms{c}, ts(), [num2str(i,'%02d')]));
        save_current_figure_png(out); close;
      end
    catch err
      fprintf(2, 'Error reading %s: %s\n', f, err.message);
    end
  end
end

