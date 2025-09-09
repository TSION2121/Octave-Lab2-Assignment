## Q07: download_images
## Saves downloaded files in 'downloads/' and thumbnails in 'outputs/'.
function files = Q07_download_images(urls, outdir)
  config; pkg load image; addpath('scripts');
  outdir = ensure_outdir(nargin>=2 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(urls)
    urls = {'https://via.placeholder.com/128.jpg', 'https://via.placeholder.com/256.png'};
  end
  dldir = 'downloads'; if ~exist(dldir,'dir'), mkdir(dldir); end
  files = {};
  for i=1:numel(urls)
    url = urls{i};
    [~, name, ext] = fileparts(url); if isempty(ext), ext = '.jpg'; end
    outfile = fullfile(dldir, [name ext]);
    try
      urlwrite(url, outfile);
      files{end+1} = outfile; %#ok<AGROW>
      I = imread(outfile);
      thumb = imresize(I, [256 NaN], 'bilinear');
      imwrite(thumb, fullfile(outdir, sprintf('Q07_thumb_%02d_%s.png', i, ts())));
    catch err
      fprintf(2, 'Failed to download %s: %s\n', url, err.message);
    end
  end
end

