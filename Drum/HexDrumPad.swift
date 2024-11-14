//
//  HexDrumPad.swift
//  Drum
//
//  Created by John Fowler on 11/13/24.
//
import SpriteKit

class HexDrumPad: HexagonSprite, DrumPad {
  private var padNote: DrumNote
  
  init(size: CGFloat, color: UIColor, note: DrumNote) {
    padNote = note
    super.init(size: size, fillColor: color)
  }
  
  func note() -> DrumNote {
    return padNote
  }
  
  @MainActor required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
