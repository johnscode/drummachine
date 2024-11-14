//
//  EllipticDrumPad.swift
//  Drum
//
//  Created by John Fowler on 11/13/24.
//

import SpriteKit

class EllipticDrumPad: SKShapeNode, DrumPad {
  
  private var padNote: DrumNote
  private var radius: CGFloat
  
  init(radius: CGFloat, color: UIColor, note: DrumNote) {
    self.padNote = note
    self.radius = radius
    super.init()
    let angle = 15 * CGFloat.pi / 180
    var rotationTransform = CGAffineTransform(rotationAngle: angle)
    let circlePath = CGPath(ellipseIn: CGRect(x: -radius/2, y: -radius/2, width: radius, height: radius/3), transform: &rotationTransform)
    self.path = circlePath
    self.fillColor = color
  }
  
  func note() -> DrumNote {
    return self.padNote
  }
  
  override func contains(_ point: CGPoint) -> Bool {
    // Get the position of the circle's center
    let center = self.position
    
    // Calculate the distance between the point and the center using the distance formula
    let distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2))
    
    // Check if the distance is less than or equal to the radius
    return distance <= self.radius/2
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
