//
//  DrumScene.swift
//  Drum
//
//  Created by John Fowler on 11/11/24.
//
import SpriteKit

class HexagonSprite: SKSpriteNode {
  
  private var hexagonSize: CGFloat
  private var hexagonPath: CGPath
  
  init(size: CGFloat, fillColor: SKColor) {
    self.hexagonSize = size
    
    // Create the hexagon path
    let path = CGMutablePath()
    let points = HexagonSprite.calculateHexagonPoints(size: size)
    
    // Move to first point
    path.move(to: points[0])
    
    // Add lines to all other points
    for i in 1..<points.count {
      path.addLine(to: points[i])
    }
    
    // Close the path
    path.closeSubpath()
    self.hexagonPath = path
    
    let bounds = path.boundingBox
    let renderSize = CGSize(width: size * 2, height: size * 2)
    
    // Create the final image
    let renderer = UIGraphicsImageRenderer(size: renderSize)
    let finalImage = renderer.image { context in
        let cgContext = context.cgContext
        
        // Move to center
        cgContext.translateBy(x: renderSize.width/2, y: renderSize.height/2)
        
        // Create gradient
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: [UIColor.lightGray.cgColor, UIColor.blue.cgColor] as CFArray,
            locations: [0.0, 1.0]
        ) else { return }
        
        // Draw radial gradient within the path
        cgContext.addPath(path)
        cgContext.clip()
        
        cgContext.drawRadialGradient(
            gradient,
            startCenter: CGPoint.zero,
            startRadius: 0,
            endCenter: CGPoint.zero,
            endRadius: size*1.5,
            options: .drawsBeforeStartLocation
        )
    }
    
    // Create texture from the final image
    let texture = SKTexture(image: finalImage)
    

// orig fill
//    // Create shape node
//    let shape = SKShapeNode(path: path)
//    shape.fillColor = fillColor
//    shape.strokeColor = .clear
    
    // Create texture from shape
//    let texture = SKView().texture(from: shape)!
    super.init(texture: texture, color: .clear, size: texture.size())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private static func calculateHexagonPoints(size: CGFloat) -> [CGPoint] {
    var points: [CGPoint] = []
    let anglePerSide = CGFloat.pi / 3
    
    for i in 0...5 {
      let angle = CGFloat(i) * anglePerSide
      let x = size * cos(angle)
      let y = size * sin(angle)
      points.append(CGPoint(x: x, y: y))
    }
    
    return points
  }
  
  // Method to check if a point is within the hexagon
  override func contains(_ point: CGPoint) -> Bool {
    // Convert the point from scene coordinates to node coordinates
    let localPoint = self.convert(point, from: self.scene!)
    
    // Create a transform that accounts for the node's scale
    var transform = CGAffineTransform.identity
    transform = transform.scaledBy(x: xScale, y: yScale)
    
    // Apply the transform to the path
    let transformedPath = hexagonPath.copy(using: &transform)!
    
    // Check if the point is within the transformed path
    return transformedPath.contains(localPoint)
  }
}
