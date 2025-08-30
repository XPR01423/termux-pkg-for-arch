# Maintainer: Efe Kaan ASLAN <efekaanaslan58@gmail.com>
pkgname=pkg
pkgver=0.1 
pkgrel=1  
pkgdesc="Minimal AUR package manager inspired by Termux pkg"
arch=('x86_64' 'aarch64')
url="https://github.com/XPR01423/termux-pkg-for-arch"
license=('MIT')
depends=('git' 'base-devel' 'jq')
source=("pkg")
sha256sums=('pkg')

package() {
    install -Dm755 pkg "$pkgdir/usr/local/bin/pkg"
}
 




