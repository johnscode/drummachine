//
//  GameViewController.swift
//  Drum
//
//  Created by John Fowler on 11/11/24.
//

import UIKit
import SpriteKit
import SceneKit

class GameViewController: UIViewController {
  
  override func loadView() {
    self.view = SKView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // create scene
      let scene = DrumScene(size: view.bounds.size)
      scene.scaleMode = .aspectFill
      
      
      // configure the view
      view.backgroundColor = UIColor.black
      
      
      view.presentScene(scene)
    }
  }
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .landscape
    } else {
      return .all
    }
  }
  
}
