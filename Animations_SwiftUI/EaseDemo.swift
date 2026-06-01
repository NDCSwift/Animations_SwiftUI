//
        //
    //  Project: Animations_SwiftUI
    //  File: EaseDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Easing Curves
//
// An easing curve defines HOW an animation moves through time.
// All four circles travel the same distance (200 pts) in the same duration (0.5s),
// but the velocity profile — acceleration and deceleration — differs for each.
//
// Timing curve cheat-sheet:
//
//  .easeIn      — starts slow, ends fast.   Good for: exits, things leaving the screen.
//  .easeOut     — starts fast, ends slow.   Good for: entrances, things arriving on screen.
//  .easeInOut   — slow at both ends.        Good for: in-place moves, feels most natural.
//  .linear      — constant speed.           Good for: looping animations, progress bars.
//
// Rule of thumb: objects from the physical world decelerate before stopping (.easeOut / .easeInOut).
// Pure .linear motion looks robotic for most UI interactions.

import SwiftUI

struct EaseDemo: View {
    @State private var isActive = false

    var body: some View {

        // MARK: .easeIn — accelerates into the destination
        // The animation starts slowly and finishes at full speed.
        // Notice this circle "lags" at the beginning but arrives sharply.
        Circle()
            .fill(.blue)
            .frame(width: 100)
            .offset(x: isActive ? 100 : -100)
            .animation(.easeIn(duration: 0.5), value: isActive) // slow start, fast finish

        // MARK: .easeOut — decelerates into the destination
        // The animation starts at full speed and gently slows to a stop.
        // This is the most natural-feeling curve for things appearing on screen.
        Circle()
            .fill(.green)
            .frame(width: 100)
            .offset(x: isActive ? 100 : -100)
            .animation(.easeOut(duration: 0.5), value: isActive) // fast start, slow finish

        // MARK: .easeInOut — decelerates at both ends
        // Combines easeIn + easeOut. The most commonly used curve for UI motion
        // because it mimics how physical objects naturally move.
        Circle()
            .fill(.orange)
            .frame(width: 100)
            .offset(x: isActive ? 100 : -100)
            .animation(.easeInOut(duration: 0.5), value: isActive) // slow at both ends

        // MARK: .linear — constant speed throughout
        // The animation moves at a perfectly steady rate from start to finish.
        // Useful for things like rotating loading spinners or progress indicators
        // where consistent motion matters more than natural feel.
        Circle()
            .fill(.yellow)
            .frame(width: 100)
            .offset(x: isActive ? 100 : -100)
            .animation(.linear(duration: 0.5), value: isActive) // constant speed

        // MARK: Note: .animation(_:value:) vs .animation(_:)
        // The `value:` parameter scopes the animation to changes in `isActive` only.
        // Without it, ANY state change on this view would trigger the animation,
        // which can cause unexpected animations elsewhere. Always prefer the `value:` form.
        Button("Animate") {
            isActive.toggle()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    EaseDemo()
}
