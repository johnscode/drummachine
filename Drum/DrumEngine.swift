//
//  DrumEngine.swift
//  Drum
//
//  Created by John Fowler on 11/11/24.
//
import AVFoundation
import AudioToolbox

class DrumSoundEngine {
    private var audioEngine: AVAudioEngine!
    private var sampler: AVAudioUnitSampler!
    
    init() {
        setupAudioEngine()
    }
    
    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        sampler = AVAudioUnitSampler()
        
        // Connect sampler to audio engine
        audioEngine.attach(sampler)
        audioEngine.connect(sampler, to: audioEngine.mainMixerNode, format: nil)
        
        // Start the audio engine
        do {
            try audioEngine.start()
        } catch {
            print("Could not start audio engine: \(error.localizedDescription)")
        }
        
        // Load the SoundFont
        loadSoundFont()
    }
    
    private func loadSoundFont() {
        guard let soundFontURL = Bundle.main.url(forResource: "GeneralUser GS MuseScore v1.442", withExtension: "sf2") else {
            print("Could not find soundfont file")
            return
        }
        
        do {
            try sampler.loadSoundBankInstrument(at: soundFontURL,
                                              program: 0,
                                              bankMSB: UInt8(kAUSampler_DefaultPercussionBankMSB),
                                              bankLSB: 0)
        } catch {
            print("Could not load sound font: \(error.localizedDescription)")
        }
    }
    
    // Play a drum note
    func playDrum(note: UInt8, velocity: UInt8) {
        sampler.startNote(note, withVelocity: velocity, onChannel: 9) // Channel 10 (9 in zero-based) is typically for drums
    }
    
    // Stop a drum note
    func stopDrum(note: UInt8) {
        sampler.stopNote(note, onChannel: 9)
    }
}
