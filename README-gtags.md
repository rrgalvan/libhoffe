GNU Global (gtags) for Fortran
==============================
- For using GNU Global for fortran, you need to install exuberant
  ctags. In debian: package exuberant-ctags. Binary is called
  ctags-exuberant
- Current version of Debian package (oct 2015) is too old. So you need
  to compile and install gtags
- Download from http://www.gnu.org/software/global/download.html
- Compile & install global:
> ./configure --with-exuberant-ctags=/usr/bin/ctags-exuberant --disable-gtagscscope
> sudo make install
- You must update the default configuration of gtags:
> cp /usr/local/share/gtags/gtags.conf ~/.globalrc
- Finally, add to Add to .bashrc:
> export GTAGSLABEL=ctags
