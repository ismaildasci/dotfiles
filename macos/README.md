# macOS Developer Defaults

macOS Tahoe 26.2 icin optimize edilmis developer ayarlari.

## Kurulum

```bash
bash macos/set-defaults.sh
```

> System Settings'i kapatmayi unutmayin.

## Icerdikleri

### Performance & Animations
- Dock autohide/show animasyonlari hizlandirildi
- Launchpad/Mission Control animasyonlari hizlandirildi
- Pencere animasyonlari devre disi birakildi
- Rubber-band scrolling kapatildi

### Keyboard (Developer icin kritik)
- `KeyRepeat: 1` - Maksimum tus tekrar hizi
- `InitialKeyRepeat: 10` - Hizli ilk tekrar
- Press-and-hold devre disi (tus tekrari icin)
- Fn tusu Globe yerine Fn olarak calisir
- Klavye duzenleri: Turkish Q + US English
- Input source degistirme: Ctrl+Space

### SSD & Energy
- Hibernation kapatildi (hizli uyku)
- Power Nap kapatildi (arka plan sync yok)
- Standby delay 24 saat
- Sleep image dosyasi kaldirildi (disk tasarrufu)

### Finder
- Klasorler her zaman once
- Path bar ve Status bar acik
- USB'lerde .DS_Store olusturma
- 30 gun sonra cop kutusunu bosalt
- Airdrop her yerde aktif

### Dock
- Son kullanilan uygulamalar gizli
- Scale efekti (genie yerine)
- Animasyonlar hizlandirildi

### Trackpad
- Tap to click aktif
- Three finger drag (pencere suruklemek icin)
- Tracking speed: 2.5 (hizli)
- Two finger right click

### Hot Corners
- Sol ust: Mission Control
- Sag ust: Notification Center
- Sol alt: Desktop
- Sag alt: Lock Screen

### Menu Bar
- Battery yuzde gosterimi
- Saat: Gun, tarih, saat:dakika:saniye
- Bluetooth gorunur

### Screenshots
- Konum: `~/Screenshots`
- Shadow yok (clean screenshots)
- Format: PNG
- Dosya adi: screenshot (tarihsiz)

### Accessibility
- Reduce transparency (performans)
- Reduce motion (animasyon azaltma)

### Locale (Turkey)
- Timezone: Europe/Istanbul
- Dil: Turkce (yedek: English)
- Para birimi: TRY
- Sayi formati: 1.234,56
- 24 saat formati
- Hafta Pazartesi baslar

### Security
- Firewall aktif
- Stealth mode aktif

## Manuel Adimlar

Script calistiktan sonra:

1. **Apple Intelligence'i kapat**
   - System Settings > Apple Intelligence & Siri > Toggle OFF

2. **Spotlight exclusions**
   - Bkz: [spotlight-exclude.md](spotlight-exclude.md)

3. **Logout/Login** veya **Restart**

## Test

```bash
# Klavye tekrar hizi
vim -> jjjjjjjjj (hizli olmali)

# Dock animasyonu
Cmd+Option+D (hizli gizlenmeli)

# Hot corners
Mouse'u koselere gotur

# Screenshot (shadow olmamali)
Cmd+Shift+4 -> ~/Screenshots'a kaydedilmeli

# Trackpad
Tek parmakla tikla, uc parmakla surukle

# Sayi formati
System Settings > General > Language & Region
```

## Kaynaklar

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [CodelyTV/dotfiles](https://github.com/CodelyTV/dotfiles)
