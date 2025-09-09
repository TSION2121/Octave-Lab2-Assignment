# Octave Lab 2 — Image Processing Exercises (Q01–Q14)

Complete **at least 1 exercise per day** and push your changes.  
All scripts save results into `outputs/` and default to your image path:

## Quick Start

```bash
git clone https://github.com/TSION2121/Octave-Lab2-Assignment.git
cd Octave_lab2
```

In Octave:

```octave
addpath('scripts');
config;       % sets BASE_IMG, BASE_DIR, OUTPUT_DIR
pkg load image
run('run_demo.m');   % optional: quick showcase
```

## Scripts Overview

* **Q01** Import images (various formats) and save views with `gray/hot/jet` colormaps.
* **Q02** Resize with aspect ratio; save resized + comparison.
* **Q03** Grayscale methods (average/luminosity/desaturation); save all + comparison.
* **Q04** Crop ROI by coordinates; save crop + comparison.
* **Q05** Interpolation resize (nearest/bilinear/bicubic); save all + comparison.
* **Q06** Rotate by any angle; save rotated + comparison.
* **Q07** Download images from URLs; save to `downloads/` + thumbnails to `outputs/`.
* **Q08** Capture one frame from camera via `ffmpeg`; save to `outputs/`.
* **Q09** Load RGB → HSV + simulated CMYK; save comparison.
* **Q10** Extract metadata via `imfinfo` (+ `exiftool` if present); save `.txt`.
* **Q11** Pixel scaling/translation; save adjusted + comparison.
* **Q12** Resolution effects (downscale→upscale); save comparison + outputs.
* **Q13** Color-space effects on edges (Gray/H/S/V); save edge maps + comparison.
* **Q14** Enhancement (histogram equalization, contrast stretching); save results + hist plots.

## Config

Edit `scripts/config.m` to change:

* `BASE_IMG`  (default: `C:\Users\jilow\DIP_Lab\input_images\face1.tiff`)
* `BASE_DIR`  (auto: folder of `BASE_IMG`)
* `OUTPUT_DIR` (default: `outputs/`)

---

