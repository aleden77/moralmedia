#!/usr/bin/env bash
# Run this ONCE from inside the repo folder, while the old WordPress site is still online.
# It downloads every image and PDF the new site uses into the same /wp-content/uploads/...
# paths, so old direct links to PDFs and images keep working after the move.
#
#   Mac/Linux:  bash fetch-wp-uploads.sh
#   Windows:    run it in Git Bash (comes with Git for Windows)

set -u
BASE="https://moralmedia.org"
FILES=(
  /wp-content/uploads/2018/06/junction.png
  /wp-content/uploads/2018/06/conference-1024x533.png
  /wp-content/uploads/2018/06/eden.png
  /wp-content/uploads/2018/06/grizzard.png
  /wp-content/uploads/2018/06/huskey.png
  /wp-content/uploads/2018/06/derby.png
  /wp-content/uploads/2018/07/deadline.jpg
  /wp-content/uploads/2019/07/sparty-e1564511605470.png
  /wp-content/uploads/2019/09/moral_media_agenda_2019.pdf
  /wp-content/uploads/2022/02/drew.jpeg
  /wp-content/uploads/2022/02/ucdavis_sign.jpg
  /wp-content/uploads/2022/04/mmm22_program.pdf
  /wp-content/uploads/2024/02/Oval_3_1600x1200-edited-scaled.jpg
  /wp-content/uploads/2024/10/Hahn_headshot_trimmed-1.jpg
  /wp-content/uploads/2024/10/1713979131797.jpg
  /wp-content/uploads/2024/10/1714157882183.jpg
  /wp-content/uploads/2024/10/spring-outside3.jpg
  /wp-content/uploads/2025/09/headshot_frazer-scaled-300x300-1-4.jpg
  /wp-content/uploads/2025/09/uflorida_cover-1.jpg
  /wp-content/uploads/2026/07/spring-2026.jpg
)

ok=0; failed=()
for f in "${FILES[@]}"; do
  dest=".${f}"
  mkdir -p "$(dirname "$dest")"
  if curl -fsSL --retry 2 -o "$dest" "${BASE}${f}"; then
    echo "  ok   ${f}"; ok=$((ok+1))
  else
    echo "  FAIL ${f}"; failed+=("$f"); rm -f "$dest"
  fi
done

echo
echo "Downloaded ${ok} of ${#FILES[@]} files."
if [ ${#failed[@]} -gt 0 ]; then
  echo "These failed — download them by hand from the WordPress Media Library and put them at the same path:"
  printf '  %s\n' "${failed[@]}"
fi
