//
//  DrumScene.swift
//  Drum
//
//  Created by John Fowler on 11/11/24.
//
import SpriteKit
import GameplayKit

class DrumScene: SKScene {
  
  // Properties for drum nodes
  private var kickDrum: SKSpriteNode!
  private var snareDrum: SKSpriteNode!
  private var hitom: SKSpriteNode!
  private var midtom: SKSpriteNode!
  private var lowtom: SKSpriteNode!
  private var hiHatClosed: SKShapeNode!
  private var hiHatOpen: SKShapeNode!
  private var splash: SKShapeNode!
  private var ride: SKShapeNode!
  private var backButton: SKLabelNode!
  
  private let backButtonName = "back"
  
  let drumEngine = DrumSoundEngine()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(size: CGSize) {
    super.init(size: size)
  }
  
  let rootNode = SKNode()
  
  override func didMove(to view: SKView) {
    // Set up the scene
    backgroundColor = .black
    addChild(rootNode)
    setupDrumKit()
  }
  
  private func setupDrumKit() {
    // Get scene dimensions
    let sceneWidth = frame.width
    let sceneHeight = frame.height
    
    // kick drum
    kickDrum = createHexDrumPad(radius: 60, color: .white, note: DrumNote.kickDrum)
    kickDrum.position = CGPoint(x: sceneWidth * 0.5,
                                y: sceneHeight * 0.25)
    kickDrum.name = "kick"
    addChild(kickDrum)
    
    // snare drum
    snareDrum = createHexDrumPad(radius: 45, color: .white, note: DrumNote.snareDrum)
    snareDrum.position = CGPoint(x: sceneWidth * 0.36,
                                 y: sceneHeight * 0.4)
    snareDrum.name = "snare"
    addChild(snareDrum)
    
    // closed hi-hat
    hiHatClosed = createRectDrumPad(width: 75, height: 35, color: .clear, note: DrumNote.closedHiHat, imageName: "closedhihat")
    hiHatClosed.position = CGPoint(x: sceneWidth * 0.64,
                                   y: sceneHeight * 0.38)
    hiHatClosed.name = "hihatClosed"
    addChild(hiHatClosed)
    
    // Create and position open hi-hat (smaller circle on far right)
    hiHatOpen = createRectDrumPad(width: 75, height: 35, color: .clear, note: DrumNote.openHiHat, imageName: "openhihat")
    hiHatOpen.position = CGPoint(x: sceneWidth * 0.64,
                                 y: sceneHeight * 0.49)
    hiHatOpen.name = "hihatOpen"
    addChild(hiHatOpen)
    
    // Create and position splash
    splash = createCircularDrumPad(radius: 50, color: .clear, note: DrumNote.crashCymbal, imageName: "cymbal-tilt-right")
    splash.position = CGPoint(x: sceneWidth * 0.34,
                                 y: sceneHeight * 0.65)
    splash.name = "splash"
    addChild(splash)
    
    // Create and position splash
    ride = createCircularDrumPad(radius: 50, color: .clear, note: DrumNote.rideCymbal, imageName: "cymbal-tilt-left")
    ride.position = CGPoint(x: sceneWidth * 0.67,
                                 y: sceneHeight * 0.68)
    ride.name = "ride"
    addChild(ride)
    
    // Create and position hitom
    hitom = createHexDrumPad(radius: 30, color: .white, note: DrumNote.highTom)
    hitom.position = CGPoint(x: sceneWidth * 0.45,
                                 y: sceneHeight * 0.72)
    hitom.name = "hitom"
    addChild(hitom)
    
    
    // Create and position midtom
    midtom = createHexDrumPad(radius: 30, color: .white, note: DrumNote.midTom)
    midtom.position = CGPoint(x: sceneWidth * 0.52,
                                 y: sceneHeight * 0.64)
    midtom.name = "midtom"
    addChild(midtom)
    
    
    // Create and position lowtom
    lowtom = createHexDrumPad(radius: 30, color: .white, note: DrumNote.lowTom)
    lowtom.position = CGPoint(x: sceneWidth * 0.45,
                                 y: sceneHeight * 0.55)
    lowtom.name = "lowtom"
    addChild(lowtom)
    
    // Add labels to each drum pad
//    addLabelToDrumPad(drumPad: kickDrum, text: "KICK")
//    addLabelToDrumPad(drumPad: snareDrum, text: "SNARE")
//    addLabelToDrumPad(drumPad: hiHatClosed, text: "HH")
//    addLabelToDrumPad(drumPad: hiHatOpen, text: "HH OPEN")
  }
  
  private func createHexDrumPad(radius: CGFloat, color: UIColor, note: DrumNote) -> HexagonSprite {
    let drumPad = HexDrumPad(size: radius, color: color, note: note)
    drumPad.alpha = 0.7
    return drumPad
  }
  
  private func createCircularDrumPad(radius: CGFloat, color: UIColor, note: DrumNote, imageName: String) -> SKShapeNode {
    let drumPad = CircleDrumPad(radius: radius, color: color, note: note, imageName: imageName)
    return drumPad
  }
  
  private func createRectDrumPad(width: CGFloat, height: CGFloat, color: UIColor, note: DrumNote, imageName: String) -> SKShapeNode {
    let drumPad = RectDrumPad(width: width, height: height, color: color, note: note, imageName: imageName)
    return drumPad
  }
  
  private func createDrumPad(radius: CGFloat, color: UIColor, imageName: String) -> SKShapeNode {
    let drumPad = SKShapeNode(circleOfRadius: radius )
    drumPad.fillColor = color
    drumPad.strokeColor = .gray
    drumPad.lineWidth = 2
    drumPad.alpha = 0.7
    
    let texture = SKTexture(imageNamed: imageName)
    let imageNode = SKSpriteNode(texture: texture)
    // Scale the image to fit inside the circle
    let scaleFactor = (radius * 2) / max(texture.size().width, texture.size().height)
    imageNode.setScale(scaleFactor)
    
    // Make the image node slightly smaller than the circle
    imageNode.setScale(imageNode.xScale * 0.9)
    
    // Add the image as a child of the shape node
    drumPad.addChild(imageNode)
    
    return drumPad
  }
  
  private func addLabelToDrumPad(drumPad: SKShapeNode, text: String) {
    let label = SKLabelNode(text: text)
    label.fontSize = 14
    label.fontName = "Arial-Bold"
    label.fontColor = .black
    label.verticalAlignmentMode = .center
    label.horizontalAlignmentMode = .center
    drumPad.addChild(label)
  }
  
  // Handle touches
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let location = touch.location(in: self)
      let touchedNodes = nodes(at: location)
      
      for node in touchedNodes {
        if let drumPad = node as? (SKNode & DrumPad) {
          handleDrumHit(drumPad)
        }
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//    for touch in touches {
//      let location = touch.location(in: self)
//      let touchedNodes = nodes(at: location)
//      
//      for node in touchedNodes {
//        if let drumPad = node as? SKNode {
//        }
//      }
//    }
  }
  
  private func handleDrumHit(_ drumPad: SKNode & DrumPad) {
    // Visual feedback - brighten and scale up the pad
    let scaleUp = SKAction.scale(to: 1.1, duration: 0.1)
    let brighten = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
    let delay = SKAction.wait(forDuration: 0.1)
    let scaleDown = SKAction.scale(to: 1.0, duration: 0.1)
    let fadeBack = SKAction.fadeAlpha(to: 0.7, duration: 1)
    
    let initialGroup = SKAction.group([scaleUp, brighten])
    let sequence = SKAction.sequence([initialGroup, delay, scaleDown, fadeBack])
    
    drumPad.run(sequence)
    
    print("\(drumPad.name!) hit")
    drumEngine.playDrum(note: drumPad.note().midi(), velocity: drumPad.note().velocity())
    
  }
  
  private func resetDrumPad(_ drumPad: SKNode) {
    // Reset the drum pad to its original state
    let scaleDown = SKAction.scale(to: 1.0, duration: 0.1)
    let fadeBack = SKAction.fadeAlpha(to: 0.7, duration: 0.1)
    let group = SKAction.group([scaleDown, fadeBack])
    
    drumPad.run(group)
  }
  
  // Called when touches move
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    
    // Handle touch movement
  }
  
  // Called when touches are cancelled
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Handle cancelled touches
  }
  
  
}

