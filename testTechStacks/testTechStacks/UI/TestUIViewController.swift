//
//  TestUIViewController.swift
//  testTechStacks
//
//  Created by Jaehwi Kim on 2024/01/04.
//

import UIKit

class TestUIViewController: UIViewController {
    @IBOutlet weak var UIBezierPathView: UIView!
    @IBOutlet weak var CACornerMaskView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundCornerForUIBezierPath()
        setRoundCornerForCACornerMask()
    }
    
    func setRoundCornerForUIBezierPath() {
        UIBezierPathView.backgroundColor = .green
        let path = UIBezierPath(roundedRect: UIBezierPathView.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = UIBezierPathView.bounds
        maskLayer.path = path.cgPath
        UIBezierPathView.layer.mask = maskLayer
        UIBezierPathView.layer.masksToBounds = true
    }
    
    func setRoundCornerForCACornerMask() {
        CACornerMaskView.backgroundColor = .blue
        CACornerMaskView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CACornerMaskView.layer.cornerRadius = 15
        CACornerMaskView.layer.masksToBounds = true
    }
}
