import UIKit

class Bubble: UIView {
    
    let shape = CAShapeLayer()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpMask()
        self.backgroundColor = tintColor
        layer.mask = shape
    }
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var exerciseLabel: UILabel!
    
    func setUpMask() {
        let rect = self.bounds
        // Wipe out default animation actions
        var newActions = ["onOrderIn" : NSNull(),
            "sublayers" : NSNull(),
            "contents" : NSNull(),
            "bounds" : NSNull(),
            "position" : NSNull()]
        shape.actions = newActions
        shape.fillColor = self.tintColor.CGColor
        shape.strokeColor = self.tintColor.CGColor
        shape.lineWidth = 0.0
        shape.frame = rect
        let bezierPath = UIBezierPath(ovalInRect: shape.bounds)
        shape.path = bezierPath.CGPath
    }
    
    override func layoutSubviews() {
        setUpMask()
    }
    
}