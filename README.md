# 🎬 Animations SwiftUI
A hands-on SwiftUI animation playground covering every major animation API in one project.

---

## 🤔 What this is
This project is a collection of focused SwiftUI animation demos — springs, keyframes, phase animators, symbol effects, matched geometry transitions, and more — all in a single navigable app. Each file isolates one animation concept so you can read, run, and remix it without digging through unrelated code. It was built as the companion project for a YouTube tutorial on mastering SwiftUI animations.

## ✅ Why you'd use it
- **Side-by-side demos** — every animation type (ease, spring, keyframe, phase, transitions, symbol effects, matched geometry, navigation zoom) lives in its own file so comparisons are instant
- **Copy-paste ready** — each demo is self-contained, making it trivial to lift a pattern directly into your own app
- **Visual feedback** — interactive controls let you tweak parameters and see changes in real time, building intuition faster than reading docs alone

## 📺 Watch on YouTube
[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtube.com/watch?v=PLACEHOLDER)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/NDCSwift/Animations_SwiftUI.git
```

### 2. Open in Xcode
```
Animations_SwiftUI.xcodeproj
```

### 3. Set your Team
In the project navigator select the **Animations_SwiftUI** target → **Signing & Capabilities** → set **Team** to your Apple developer account.

### 4. Set your Bundle ID
Change `com.yourname.Animations-SwiftUI` to a bundle ID unique to your account, then run on Simulator or a real device.

---

## 🛠️ Notes
- **EaseDemo** — linear, easeIn, easeOut, easeInOut curves with live comparison
- **SpringDemo** — bouncy, snappy, smooth, and custom spring parameters
- **KeyFrameDemo** — multi-property keyframe sequences with `KeyframeAnimator`
- **PhaseDemo** — discrete animation phases with `PhaseAnimator`
- **TransistionsDemo** — built-in and custom `AnyTransition` insertions/removals
- **MatchedGeoDemo** — hero transitions with `matchedGeometryEffect`
- **NavigationZoomDemo** — zoom navigation transition (iOS 18+)
- **SymbolEffectsDemo** — SF Symbol effects (bounce, pulse, rotate, wiggle, breathe)

## 📦 Requirements
| | |
|---|---|
| Xcode | 16.0+ |
| iOS | 18.0+ |
| Swift | 6.0+ |

---

📺 [Watch the guide on YouTube](https://youtube.com/watch?v=PLACEHOLDER)
