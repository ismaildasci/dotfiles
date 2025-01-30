# Spotlight Exclusion Paths

macOS Tahoe 26.2'de Xcode build sorunlarini ve genel performansi iyilestirmek icin
asagidaki path'leri Spotlight'tan heric tutun.

## Manuel Ekleme

**System Settings > Siri & Spotlight > Spotlight Privacy > Add (+)**

### Developer Paths (Kritik)

```
/Library/Developer/CoreSimulator/Volumes/
~/Library/Developer/
```

> Bu path'ler Xcode Simulator ve build cache'lerini icerir.
> Spotlight bunlari indexlediginde disk I/O ve CPU kullanimi artar.

### Package Manager Caches

```
~/node_modules
~/.npm
~/.composer
~/.cargo
```

> Her projede ayrica `node_modules` klasorunu de ekleyebilirsiniz.

### Build Outputs

```
~/Library/Caches/
~/Library/Application Support/Code/Cache/
```

## Spotlight'i Yeniden Baslat

Degisikliklerden sonra Spotlight index'ini yeniden olusturmak icin:

```bash
sudo mdutil -E /
```

## Dogrulama

Spotlight'in hangi path'leri heric tuttugunuzu gormek icin:

```bash
mdutil -s /
sudo mdfind -onlyin / "kMDItemDisplayName == '*'" | head -20
```

## Notlar

- Bu ayarlar developer makineleri icindir
- Production/personal backup makinelerinde dikkatli olun
- Time Machine bu path'leri yine de yedekler
