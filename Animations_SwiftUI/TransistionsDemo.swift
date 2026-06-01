//
        //
    //  Project: Animations_SwiftUI
    //  File: TransistionsDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Transitions
//
// Transitions define HOW a view enters or leaves the hierarchy — they are NOT
// for animating properties on a view that always exists.
//
// A transition fires when a view is INSERTED or REMOVED inside a `withAnimation` block.
// Conditional `if` statements are the most common trigger:
//   if isShowing { SomeView() }   ← SomeView is inserted/removed from the hierarchy
//
// Key built-in transitions:
//   .opacity                    — simple cross-fade in/out
//   .scale                      — grows in / shrinks out from the view's center
//   .move(edge:)                — slides in/out from a screen edge
//   .push(from:)                — slides in from an edge, pushing existing content
//   .slide                      — shorthand for move from the leading edge
//   .blurReplace                — blurs while scaling (iOS 17+)
//
// Combining transitions:
//   .combined(with:)             — applies BOTH transitions simultaneously
//   .asymmetric(insertion:removal:) — different transitions for appear vs disappear

import SwiftUI

struct TransistionsDemo: View {
    @State private var isShowing = false

    // MARK: Accessibility — Reduce Motion
    // Reading `\.accessibilityReduceMotion` from the environment gives you the system
    // "Reduce Motion" setting (Settings → Accessibility → Motion → Reduce Motion).
    // Always honour this: replace large spatial animations with simpler fades or
    // shorter durations so users with vestibular disorders aren't affected.
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {

        if isShowing {
            RoundedRectangle(cornerRadius: 12)
                .fill(.orange.gradient)
                .frame(height: 100)

                // MARK: Alternative transition (commented out) — combined move + fade
                // .move(edge: .bottom) slides the view in from the bottom edge.
                // .combined(with: .opacity) layers a cross-fade on top.
                // Both transitions fire simultaneously on insert AND remove.
                // .transition(.move(edge: .bottom).combined(with: .opacity))

                // MARK: Active transition — asymmetric insert/remove
                // .asymmetric lets you use DIFFERENT transitions for insertion and removal,
                // which is common in polished apps (e.g. slide in from top, scale out).
                //
                //   insertion: .push(from: .top)
                //     The view slides DOWN from the top edge, shifting existing content.
                //     `.push` is distinct from `.move` — move slides the view off-screen,
                //     push actually moves other views out of the way.
                //
                //   removal: .scale
                //     The view shrinks to nothing from its center point when dismissed.
                .transition(.asymmetric(insertion: .push(from: .top), removal: .scale))
        }

        Button("Toggle") {
            // withAnimation picks the curve based on the accessibility setting.
            // A short easeIn is used when reduce motion is on — still animated,
            // but without large-scale spatial movement that could cause discomfort.
            withAnimation(reduceMotion ? .easeIn(duration: 0.25) : .bouncy) {
                isShowing.toggle()
            }
        }
        .buttonStyle(.borderedProminent)
    }

    // MARK: Computed animation — clean extraction of the conditional
    // Pulling the animation choice into a computed property keeps the button's
    // action closure readable and makes the logic easy to test or reuse.
    private var motionAnimation: Animation {
        reduceMotion ? .easeIn(duration: 0.25) : .bouncy
    }
}

#Preview {
    TransistionsDemo()
}
