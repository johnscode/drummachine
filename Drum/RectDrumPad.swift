//
//  RectDrumPad.swift
//  Drum
//
//  Created by John Fowler on 11/13/24.
//

import SpriteKit

class RectDrumPad: SKShapeNode, DrumPad {
  
  private var padNote: DrumNote
  private var width: CGFloat
  private var height: CGFloat
  
  init(width: CGFloat, height: CGFloat, color: UIColor, note: DrumNote, imageName: String) {
    self.padNote = note
    self.width = width
    self.height = height
    super.init()
    
    let texture = SKTexture(imageNamed: imageName)
    
    let circlePath = CGPath(roundedRect: CGRect(x: -width/2, y: -height/2, width: width, height: height), cornerWidth: 1, cornerHeight: 1, transform: nil)// CGPath(ellipseIn: CGRect(x: -radius/2, y: -radius/2, width: radius, height: radius), transform: nil)
    self.path = circlePath
    self.strokeColor = .clear
    self.fillColor = color
    self.lineWidth = 2
    self.alpha = 0.7
    
    
    let imageNode = SKSpriteNode(texture: texture)
    // Scale the image to fit inside the circle
    let scaleFactor = (width) / max(texture.size().width, texture.size().height)
    imageNode.setScale(scaleFactor)
    // Make the image node slightly smaller than the circle
//    imageNode.setScale(imageNode.xScale * 0.9)
    
    // Add the image as a child of the shape node
    addChild(imageNode)
  }
  
  func note() -> DrumNote {
    return self.padNote
  }
  
//  override func contains(_ point: CGPoint) -> Bool {
//    // Get the position of the circle's center
//    let center = self.position
//    
//    // Calculate the distance between the point and the center using the distance formula
//    let distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2))
//    
//    // Check if the distance is less than or equal to the radius
//    return distance <= self.radius/2
//  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
