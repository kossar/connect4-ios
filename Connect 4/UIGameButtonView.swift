//
//  UIGameButtonView.swift
//  Connect 4
//
//  Created by Eliise Timusk on 21.11.2020.
//

import UIKit

@IBDesignable
class UIGameButtonView: UIView {

    
    // MAke the property modifiable via storyboard editor
    @IBInspectable
    // 0 - empty, 1 - red, 2 - yellow, 3 - win combination
    var showElement: Int = 1 { didSet{setNeedsDisplay()}}
    
    @IBInspectable
    var colorGray: UIColor = UIColor.systemGray4 { didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    var colorRed: UIColor = UIColor.systemRed { didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    var colorYellow: UIColor = UIColor.systemYellow { didSet{ setNeedsDisplay() } }
    
    @IBInspectable
    var colorGreen: UIColor = UIColor.systemGreen { didSet {setNeedsDisplay() } }
    
    // Catch the resizing and redraw
    override var bounds: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        switch showElement {
        case 0:
            colorGray.set()
        case 1:
            colorRed.set()
            
        case 2:
            colorYellow.set()
        case 3:
            colorGreen.set()
        default:
            break;
        }
        let tile = pathForCircle()
        tile.stroke()

        
    }
    func pathForCircle() -> UIBezierPath{
        //let layer = CAGradientLayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                radius: CGFloat(min(bounds.midX, bounds.midY) * 0.8), startAngle: CGFloat(0), endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.lineWidth = CGFloat(4)
        path.fill()
        
        //layer.frame = path.bounds
        //layer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
        
        return path
    }
    func pathForCross() -> UIBezierPath{
            let path = UIBezierPath()
    
        path.lineWidth = CGFloat(10)
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        path.move(to: CGPoint(x: bounds.maxX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: bounds.maxY))
        
        print("maxX \(bounds.maxX) maxy \(bounds.maxY)")
        
        return path
    }
    

}
