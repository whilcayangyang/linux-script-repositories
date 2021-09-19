# How to fixed Spotify outdated AUR</br>

Download this package's PKGBUILD (with yay, run yay -G spotify).</br>
Navigate to the directory containing the PKGBUILD file, and open it in your preferred editor.</br>

Find these two lines in the file:

**pkgver={version string}</br>
commit={commit hash}**

Navigate to *https://repository-origin.spotify.com/pool/non-free/s/spotify-client/.*</br>
Locate the file in the list with the latest version number. It should be of the format **"spotify-client_{version string}.{commit hash}_amd64.deb".**</br>
Replace the lines you found earlier with the corresponding values in the file name. Save the file.</br>
From the terminal, in the directory of the PKGBUILD file you just edited, run updpkgsums, followed by makepkg -si.</br>
Spotify should install properly. If you wish, you can remove the directory the PKGBUILD file was contained in.</br>

Source: *https://aur.archlinux.org/packages/spotify#comment-827040*
