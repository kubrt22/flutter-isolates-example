# Isolates

Jednoduchá Flutter aplikace demonstrující rozdíl mezi výpočtem na hlavním UI
vlákně a výpočtem spuštěným v samostatném Isolate vlákně.

## Téma aplikace

Aplikace provádí časově náročný výpočet součtu čísel v cyklu. Uživatel může
porovnat:

- výpočet přímo na UI vlákně,
- stejný výpočet spuštěný pomocí Isolate.

Výsledek se zobrazí jako čas výpočtu v milisekundách. Horní část obrazovky
obsahuje animaci, která běží nepřetržitě, aby bylo možné pozorovat dopad
blokujícího výpočtu na UI.

## Spuštění aplikace

Požadavky:

- Flutter SDK,
- Dart SDK kompatibilní s verzí uvedenou v `pubspec.yaml`,
- připojený emulátor, zařízení nebo dostupný desktopový/webový target.

V kořenovém adresáři projektu spusťte:

```bash
flutter pub get
flutter run
```

## Co aplikace zobrazuje

Na obrazovce jsou:

1. animovaná plocha v horních přibližně dvou třetinách obrazovky,
2. tlačítko `UI Vlákno`, které spustí výpočet na hlavním vlákně,
3. tlačítko `Isolate`, které spustí výpočet v samostatném isolate,
4. text s naměřeným časem posledního výpočtu.

Výpočet na UI vlákně může během běhu dočasně blokovat vykreslování animace.
Výpočet v isolate probíhá mimo hlavní UI isolate.

## Testy

Testy se spouštějí příkazem:

```bash
flutter test
```

Testovací soubor ověřuje:

- že `hardComputation` vrací správné deterministické součty pro několik počtů
  iterací,
- že měřený výpočet spuštěný přes `runWithIsolate` vrací kladný čas,
- že widget `Screen` obsahuje obě tlačítka, počáteční text a správné typy
  tlačítek.
