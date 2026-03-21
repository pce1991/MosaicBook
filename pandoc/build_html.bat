
@echo off
pandoc mosaic_intro.md -o mosaic.html --toc --self-contained --section-divs
echo HTML Build Complete.
pause
