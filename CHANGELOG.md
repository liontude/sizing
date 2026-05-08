## 2.0.0

**Breaking change — complete redesign. See migration notes below.**

### New features

- New scaling algorithm: compares short-side to short-side and long-side to long-side, making calculations orientation-agnostic. Rotating the device no longer breaks the layout.
- `baseSize` can be passed in any orientation — `Size(390, 850)` and `Size(850, 390)` produce identical results.
- Three scaling models:
  - `.s` — Power (default): `size × ratio^factor`. Grows fast for small ratios and flattens naturally on large screens (tablets).
  - `.l` — Linear: `size × (1 + (ratio − 1) × factor)`. Constant growth, useful for hero images and illustrations.
  - `.c` — Custom: developer-defined `CustomScaleFunction`.
- `.f(double newFactor)` — inline factor override for a single element, without touching global state.
- `.w` / `.h` — screen width and height percentages (replaces `.sw` / `.sh`).
- `SizingBuilder` now accepts `respectSystemFontScale`, `scaleLayoutWithFont`, `factor`, and `customScale`.
- Full control of `textScaler` via `MediaQuery` override: the package takes responsibility for accessibility scaling, eliminating the double-scaling bug present in v1.
- Dart SDK updated to `>=3.0.0`.

### Removed (breaking)

| v1 | v2 replacement |
|----|----------------|
| `.ss` | `.s` |
| `.fs` | `.s` |
| `.fss` | `.s` |
| `.vs` | `.s` (short/long ratio approach replaces axis distinction) |
| `.sw` | `.w` |
| `.sh` | `.h` |
| `.self(bool)` | `respectSystemFontScale` on `SizingBuilder` |
| `differentFactor()` | `.s.f(newFactor)` |
| `selfFontScale()` | removed |
| `systemFontScale` (builder param) | `respectSystemFontScale` |

### Migration quick-reference

```dart
// Before
SizingBuilder(systemFontScale: true, builder: () => ...)
16.fss   →  16.s
100.ss   →  100.s
100.vs   →  100.s
0.5.sw   →  0.5.w
0.5.sh   →  0.5.h
16.fss.f(0.8)  →  16.s.f(0.8)
```

---

## 1.1.2

* Upgrade packages and fix linter warnings.
* Fix sizing builder not providing base size to Sizing init function (43e103a)

## 1.1.1

* Update README information.

## 1.1.0

* Upgrade to Dart 2.17.

## 1.0.0

* First released. The basic options for the use of the package are implemented.
