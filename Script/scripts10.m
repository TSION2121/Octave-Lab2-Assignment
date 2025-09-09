## Q10: extract_image_metadata
## Saves metadata to outputs/metadata_<name>.txt (and prints if exiftool is available).
function meta = Q10_extract_image_metadata(img_path, outdir)
  config; addpath('scripts');
  outdir = ensure_outdir(nargin>=2 && ~isempty(outdir) ? outdir : OUTPUT_DIR);
  if nargin < 1 || isempty(img_path), img_path = BASE_IMG; end

  [~, base, ext] = fileparts(img_path);
  meta_txt = fullfile(outdir, sprintf('Q10_metadata_%s_%s.txt', base, ts()));
  fid = fopen(meta_txt, 'w');
  meta = struct();
  if fid < 0, warning('Could not write metadata file.'); end

  try
    info = imfinfo(img_path);
    meta = info;
    if fid >= 0
      fprintf(fid, 'imfinfo for %s%s\n', base, ext);
      flds = fieldnames(info);
      for k=1:numel(flds)
        val = info.(flds{k});
        if ischar(val)
          fprintf(fid, '%s: %s\n', flds{k}, val);
        elseif isnumeric(val)
          fprintf(fid, '%s: %s\n', flds{k}, mat2str(val));
        elseif isstruct(val)
          fprintf(fid, '%s: [struct]\n', flds{k});
        else
          fprintf(fid, '%s: [unhandled type]\n', flds{k});
        end
      end
    end
  catch err
    fprintf(2, 'imfinfo failed: %s\n', err.message);
  end

  [s,~] = system('exiftool -ver > NUL 2>&1');  % Windows-friendly
  if s ~= 0, [s,~] = system('exiftool -ver > /dev/null 2>&1'); end
  if s == 0
    if fid >= 0, fprintf(fid, '\n--- exiftool output ---\n'); end
    cmd = sprintf('exiftool "%s"', img_path);
    if ispc(), cmd = [cmd ' >> "' meta_txt '"']; end
    if ~ispc()
      [~, exout] = system(cmd);
      if fid >= 0, fprintf(fid, '%s\n', exout); end
    else
      system(cmd); % output already appended on Windows path above
    end
  end
  if fid >= 0, fclose(fid); end
end

