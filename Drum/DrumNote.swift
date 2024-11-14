//
//  DrumNote.swift
//  Drum
//
//  Created by John Fowler on 11/11/24.
//

enum MidiDrumNote: UInt8 {
    case kickDrum = 36
    case snareDrum = 38
    case closedHiHat = 42
    case openHiHat = 46
    case crashCymbal = 49
    case rideCymbal = 51
    case highTom = 50
    case midTom = 47
    case lowTom = 43
}

class DrumNote {
  private var note: MidiDrumNote
  private var preferredVelocity: UInt8
  
  init(note: MidiDrumNote, preferredVelocity: UInt8) {
    self.note = note
    self.preferredVelocity = preferredVelocity
  }
  
  init(note: MidiDrumNote) {
    self.note = note
    self.preferredVelocity = 100
  }
  
  func midi() -> UInt8 {
    return self.note.rawValue
  }
  
  func velocity() -> UInt8 {
    return self.preferredVelocity
  }
  
  static var kickDrum = DrumNote(note: MidiDrumNote.kickDrum, preferredVelocity: 90)
  static var snareDrum = DrumNote(note: MidiDrumNote.snareDrum, preferredVelocity: 100)
  static var closedHiHat = DrumNote(note: MidiDrumNote.closedHiHat, preferredVelocity: 127)
  static var openHiHat = DrumNote(note: MidiDrumNote.openHiHat, preferredVelocity: 100)
  static var crashCymbal = DrumNote(note: MidiDrumNote.crashCymbal, preferredVelocity: 100)
  static var rideCymbal = DrumNote(note: MidiDrumNote.rideCymbal, preferredVelocity: 100)
  static var highTom = DrumNote(note: MidiDrumNote.highTom, preferredVelocity: 100)
  static var midTom = DrumNote(note: MidiDrumNote.midTom, preferredVelocity: 100)
  static var lowTom = DrumNote(note: MidiDrumNote.lowTom, preferredVelocity: 100)
}

