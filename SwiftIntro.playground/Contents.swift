
/**

UCD Computer Science Club, iOS Workshops, Part 0 - A SWIFT INTRODUCTION

Eddie Kaiger
October 20, 2015

The code below demonstrates basic concepts in Swift as well as a peek into UIKit.
The target audience is beginner and intermediate programmers with little to no knowledge of Swift and iOS Development. The rest of this lesson can be found here:

    https://github.com/eddiekaiger/swift-intro/
*/


import UIKit
import XCPlayground


/** Simple protocol for animating a view */
protocol ViewAnimating {
    
    var animDuration: NSTimeInterval { get }
    
    func animateEntrance()

    func animateExit()
}


class SquareView: UIView {
    
    private var width: CGFloat
    
    init(width: CGFloat) {
        self.width = width
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleView: SquareView {
    
    override init(width: CGFloat) {
        super.init(width: width)
        layer.cornerRadius = width / 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SquareView: ViewAnimating {

    var animDuration: NSTimeInterval {
        return 2.0
    }
    
    func animateEntrance() {
        
        transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(
            animDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func animateExit() {
        UIView.animateWithDuration(
            animDuration,
            delay: animDuration,
            options: .CurveEaseIn,
            animations: {
                self.transform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(CGFloat(M_PI)), 0, -300)
                self.alpha = 0
            }, completion: nil)
    }
}

extension CircleView {
    
    override func animateEntrance() {
        
        transform = CGAffineTransformMakeScale(5, 0.5)
        
        UIView.animateWithDuration(
            animDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0,
            options: .CurveEaseIn,
            animations: {
                self.transform  = CGAffineTransformIdentity
            }, completion: nil)
    }
}

func animateView(view: UIView, loop: Bool = true) {
    
    let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
    containerView.backgroundColor = UIColor.whiteColor()
    
    view.center = containerView.center
    containerView.addSubview(view)
    
    if let animatingView = view as? ViewAnimating {
        animatingView.animateEntrance()
        animatingView.animateExit()
    }
    
    XCPShowView("containerView", view: containerView)
}

let circle = CircleView(width: 200)
circle.backgroundColor = UIColor.redColor()

let square = SquareView(width: 300)
square.backgroundColor = UIColor.greenColor()

animateView(square)






