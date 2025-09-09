## Q08: capture_from_camera
## Attempts one-frame capture via ffmpeg; saves to outputs.
function img = Q08_capture_from_camera(outfile, width, height)
  config; addpath('scripts');
  ensure_outdir(OUTPUT_DIR);
  if nargin < 1 || isempty(outfile), outfile = fullfile(OUTPUT_DIR, sprintf('Q08_cam_%s.jpg', ts())); end
  if nargin < 2 || isempty(width),  width  = 640; end
  if nargin < 3 || isempty(height), height = 480; end
  img = [];

  cmd = sprintf('ffmpeg -y -f video4linux2 -s %dx%d -i /dev/video0 -vframes 1 "%s"', width, height, outfile);
  if ispc()
    cmd = sprintf('ffmpeg -y -f dshow -video_size %dx%d -i video="Integrated Camera" -vframes 1 "%s"', width, height, outfile);
  end
  status = system(cmd);
  if status ~= 0
    fprintf(2, 'ffmpeg capture failed or not available. Install ffmpeg or capture via OS camera app.\n');
    return;
  end
  try
    img = imread(outfile);
  catch err
    fprintf(2, 'Captured but failed to read %s: %s\n', outfile, err.message);
  end
end

