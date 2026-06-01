//
        //
    //  Project: Animations_SwiftUI
    //  File: KeyFrameDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Keyframe Animations
//
// `keyframeAnimator` gives you multi-step, choreographed animation sequences —
// think of it like a timeline editor where you place values at specific moments.
//
// How it works:
//   1. You define a VALUE TYPE (BounceValues) that holds all the animated properties.
//   2. `keyframeAnimator` drives that value through a series of keyframes.
//   3. Each `KeyframeTrack` controls ONE property on that value type independently.
//   4. Tracks run IN PARALLEL — scale, offset, and rotation all animate at once
//      but can have different durations and curves within their own track.
//   5. The `trigger` parameter re-starts the animation every time it changes.

import SwiftUI

struct KeyFrameDemo: View {

    // An integer trigger — incrementing it fires a new animation run.
    // Using Int instead of Bool lets you trigger the same animation multiple times in a row.
    @State private var trigger = 0

    var body: some View {

        Image(systemName: "star.fill")
            .font(.system(size: 60))
            .foregroundStyle(.yellow)

            // keyframeAnimator(initialValue:trigger:content:keyframes:)
            //   - initialValue: the starting state (all properties at their resting values)
            //   - trigger: re-runs the animation whenever this value changes
            //   - content: closure that applies the animated values to the view
            //   - keyframes: closure that defines each property's timeline
            .keyframeAnimator(initialValue: BounceValues(), trigger: trigger) { content, v in

                // `v` is a BounceValues instance whose properties are interpolated
                // by the keyframe engine on every animation frame.
                content
                    .scaleEffect(v.scale)
                    .offset(y: v.yOffset)
                    .rotationEffect(v.rotation)

            } keyframes: { _ in

                // MARK: Scale track — bouncy pop effect
                // Each keyframe specifies a TARGET VALUE and a DURATION to reach it.
                // The keyframe type controls the interpolation curve between steps.
                KeyframeTrack(\.scale) {
                    SpringKeyframe(1.6, duration: 0.25)  // overshoot: spring past the target
                    CubicKeyframe(0.9, duration: 0.15)   // squash: compress slightly below 1
                    CubicKeyframe(1.0, duration: 0.2)    // rest: settle back to normal size
                }

                // MARK: Vertical offset track — lift then land
                KeyframeTrack(\.yOffset) {
                    CubicKeyframe(-28, duration: 0.2)    // jump up 28 pts
                    CubicKeyframe(0, duration: 0.35)     // fall back to rest position
                }

                // MARK: Rotation track — wiggle left-right
                KeyframeTrack(\.rotation) {
                    CubicKeyframe(.degrees(-12), duration: 0.15)  // tilt left
                    CubicKeyframe(.degrees(8), duration: 0.2)     // tilt right
                    CubicKeyframe(.degrees(0), duration: 0.2)     // return upright
                }
            }

            .onTapGesture {
                // Incrementing trigger re-fires the keyframe animation.
                // If you used Bool, tapping twice without waiting would do nothing
                // the second time (true → true is no change). Int avoids that.
                trigger += 1
            }
    }
}

#Preview {
    KeyFrameDemo()
}


// MARK: - Animation Value Carrier
// This struct holds every property that the keyframe engine will animate.
// It MUST be a value type (struct) so SwiftUI can snapshot and interpolate it.
// All properties need sensible defaults — these are the "initial" / "resting" values.
struct BounceValues {
    var scale = 1.0          // CGFloat: 1.0 = normal size
    var yOffset = 0.0        // CGFloat: 0 = no vertical shift
    var rotation: Angle = .zero  // Angle: zero degrees = upright
}


// MARK: - Keyframe Type Reference
// Commented out so this file stays clean, but here's a quick reference
// for every keyframe interpolation type SwiftUI supports:

// LinearKeyframe(1.5, duration: 0.25)   // Constant velocity — no easing, mechanical feel
// CubicKeyframe(1.0, duration: 0.35)    // Smooth cubic Bézier easing — most common choice
// SpringKeyframe(1.5, duration: 0.25)   // Physics-based spring — overshoots the target value
// MoveKeyframe(0.0)                      // Instant jump — no duration, no interpolation
