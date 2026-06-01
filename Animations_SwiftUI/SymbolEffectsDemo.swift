//
        //
    //  Project: Animations_SwiftUI
    //  File: SymbolEffectsDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - SF Symbol Effects & Content Transitions
//
// iOS 17+ introduced `.symbolEffect()` — a dedicated animation system for SF Symbols
// that uses the symbol's built-in animation metadata to produce natural-looking motion.
//
// There are two behavioral modes:
//
//   VALUE-BASED (discrete trigger):
//     .symbolEffect(.bounce, value: someValue)
//     — plays the effect ONCE each time `someValue` changes.
//     — Use for: reactions, confirmations, one-shot feedback.
//
//   CONTINUOUS (on/off toggle):
//     .symbolEffect(.pulse, isActive: someBoolean)
//     — plays the effect IN A LOOP while `isActive` is true.
//     — Use for: loading indicators, live activity, "broadcasting" state.
//
// `.contentTransition` is separate — it animates the SWAP between two symbol/text states:
//   .symbolEffect(.replace.downUp) — morphs between two different symbol names
//   .numericText(countsDown:)       — slides digits up/down when a number changes

import SwiftUI

struct SymbolEffectsDemo: View {
    @State private var count = 0
    @State private var isActive = false
    @State private var isMuted = false

    var body: some View {

        // MARK: .bounce (value-based) — commented out to avoid conflicting with .pulse demo
        // Uncomment to see: the heart bounces once each time you tap it (once per count increment).
        // Both .bounce and .pulse are active-type effects; stacking them on the same symbol
        // can produce unpredictable results, so only one is shown at a time here.
        //
        // .symbolEffect(.bounce, value: count)  ← fires once per tap, then stops
        Image(systemName: "heart.fill")
            .font(.system(size: 100))
            .foregroundStyle(.red)
            // .symbolEffect(.bounce, value: count)  // uncomment to enable bounce on tap
            .onTapGesture {
                count += 1
            }

        // MARK: .pulse (continuous) — loops while isActive is true
        // The wifi symbol gently fades in and out in a loop while `isActive` is true.
        // Tap once to start, tap again to stop.
        Image(systemName: "wifi")
            .font(.system(size: 100))
            .foregroundStyle(.green)
            .symbolEffect(.pulse, isActive: isActive)
            .onTapGesture {
                isActive.toggle()
            }

        // MARK: .contentTransition(.symbolEffect(.replace)) — morph between symbol variants
        // When `isMuted` changes, the symbol name changes and SwiftUI animates
        // the transition between the two glyphs using the `.replace.downUp` effect.
        // `.replace` is a "content transition" effect — it applies when the symbol IDENTITY changes,
        // not as a continuous loop. The `.downUp` suffix controls direction of the morph.
        // Requires `.animation()` on the same view to define the timing curve.
        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.3.fill")
            .font(.system(size: 100))
            .foregroundStyle(.black)
            .contentTransition(.symbolEffect(.replace.downUp))
            .animation(.snappy, value: isMuted)   // timing for the replace transition
            .onTapGesture {
                isMuted.toggle()
            }

        // MARK: .contentTransition(.numericText) — animated digit counter
        // When `count` changes, individual digit characters slide up (counting up) or
        // down (counting down) independently rather than the whole label cross-fading.
        // `countsDown: false` means digits slide upward, which looks like incrementing.
        Text("\(count)")
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .contentTransition(.numericText(countsDown: false))
            .animation(.snappy, value: count)

        Button("Add") { count += 1 }
            .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SymbolEffectsDemo()
}
