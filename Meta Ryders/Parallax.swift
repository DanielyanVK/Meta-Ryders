import UIKit

extension UIView {
    func addParallaxEffect(amount: CGFloat = 50) {
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        let group = UIMotionEffectGroup()
        
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount

        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        group.motionEffects = [horizontal, vertical]
        
        addMotionEffect(group)
    }
    
    func addShadowParallaxEffect(amount: CGFloat = 50) {
        let horizontalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.width",
            type: .tiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = amount
        horizontalEffect.maximumRelativeValue = -amount

        let verticalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.height",
            type: .tiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = amount
        verticalEffect.maximumRelativeValue = -amount

        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [ horizontalEffect,
                                      verticalEffect ]

        addMotionEffect(effectGroup)
    }
    
    func addRotationParallaxEffect(amount: CGFloat = 10) {
        let effect = ParallaxStyle(shiftHorizontal: amount, shiftVertical: amount, tiltHorizontal: amount, tiltVertical: amount).motionEffectGroup
        addMotionEffect(effect)
    }
}

// Represents the tilting & shifting parallax effect when you nudge your thumb slightly on a focused UIView
public struct ParallaxStyle {
    /// The max amount by which center.x will shift.
    /// Use a negative number for a reverse effect.
    let shiftHorizontal: Double

    /// The max amount by which center.y will shift.
    /// Use a negative number for a reverse effect.
    let shiftVertical: Double

    /// The max amount by which the view will rotate side-to-side, in radians.
    /// Use a negative number for a reverse effect.
    let tiltHorizontal: Double

    /// The max amount by which the view will rotate up-and-down, in radians.
    /// Use a negative number for a reverse effect.
    let tiltVertical: Double

    /// The focused appearance for a view
//    let focusStyle: FocusedStyle

    var motionEffectGroup: UIMotionEffectGroup {

        func toRadians(_ degrees: Double) -> Double {
            return degrees * M_PI_2 / 180;
        }

        let shiftX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        shiftX.minimumRelativeValue = -shiftHorizontal
        shiftX.maximumRelativeValue = shiftHorizontal

        let shiftY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        shiftY.minimumRelativeValue = -shiftVertical
        shiftY.maximumRelativeValue = shiftVertical

        let rotateX = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongHorizontalAxis)
        rotateX.minimumRelativeValue = toRadians(-tiltHorizontal)
        rotateX.maximumRelativeValue = toRadians(tiltHorizontal)

        let rotateY = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongVerticalAxis)
        rotateY.minimumRelativeValue = toRadians(-tiltVertical)
        rotateY.maximumRelativeValue = toRadians(tiltVertical)

        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [shiftX, shiftY, rotateX, rotateY]

        return motionGroup
    }
}
