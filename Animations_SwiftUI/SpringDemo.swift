//
        //
    //  Project: Animations_SwiftUI
    //  File: SpringDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Spring Animations
//
// Springs are physics-based animations — instead of a fixed timing curve, they
// simulate a mass attached to a spring. This produces motion that naturally
// overshoots and oscillates before settling, which feels much more alive than easing.
//
// SwiftUI provides four convenience presets plus a fully configurable `.spring()`:
//
//   .smooth    — critically damped, no overshoot. Fluid and calm.
//   .snappy    — slightly underdamped, minimal bounce. Quick and responsive.
//   .bouncy    — underdamped with visible overshoot. Playful and energetic.
//   .spring(duration:bounce:) — explicit control over both parameters.
//
// Key parameters:
//   duration  — how long the spring takes to settle (approx. in seconds)
//   bounce    — 0 = no overshoot (critically damped), 1 = maximum oscillation
//   extraBounce — adds additional bounce on top of a preset's default amount

import SwiftUI

struct SpringDemo: View {
    @State private var isActive = false

    var body: some View {

        HStack {

            // MARK: .smooth — no bounce, fluid motion
            // Critically damped: the view slides to its destination without overshooting.
            // `extraBounce: 0.70` adds a noticeable oscillation on top of smooth's
            // normally zero-bounce baseline — showing you can push any preset further.
            // Best for: large layout changes, background panels, content that shouldn't feel "bouncy".
            Circle()
                .fill(.blue)
                .frame(width: 100)
                .offset(y: isActive ? -100 : 100)
                .animation(.smooth(duration: 1.0, extraBounce: 0.70), value: isActive)

            // MARK: .snappy — quick, with a subtle bounce
            // Slightly underdamped: settles fast with just a hint of overshoot.
            // Best for: interactive controls, buttons, small UI feedback — feels responsive.
            Circle()
                .fill(.green)
                .frame(width: 100)
                .offset(y: isActive ? -100 : 100)
                .animation(.snappy(duration: 1.0), value: isActive)

            // MARK: .bouncy — visible overshoot, playful feel
            // More underdamped than .snappy. `extraBounce: 0.3` pushes it further.
            // Best for: fun apps, onboarding, game-like interactions, celebratory moments.
            Circle()
                .fill(.orange)
                .frame(width: 100)
                .offset(y: isActive ? -100 : 100)
                .animation(.bouncy(duration: 2.0, extraBounce: 0.3), value: isActive)

            // MARK: .spring(duration:bounce:) — explicit control
            // duration: 1.0 — roughly how long until the spring settles
            // bounce: 0.4   — moderate overshoot (range is 0.0 to ~1.0)
            // Use this when the presets don't give you quite the feel you want.
            Circle()
                .fill(.yellow)
                .frame(width: 100)
                .offset(y: isActive ? -100 : 100)
                .animation(.spring(duration: 1.0, bounce: 0.4), value: isActive)
        }
        .padding(.bottom, 100)

        Button("Animate") {
            isActive.toggle()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SpringDemo()
}
