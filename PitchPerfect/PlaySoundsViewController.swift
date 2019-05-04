//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Ahmed yasser on 3/29/19.
//  Copyright © 2019 Ahmed yasser. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: Properties
    // (6 UIButtons for 6 amazing sound effects)
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Class extension properites
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // An enumeration containg the 6 sound effects names places in order from 0 to 5
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Play Sound for button
    // This function handles playing back the sound file with different effects depending on the button tag
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
        
    }
    
    // MARK: stop audio
    // This function stops the audio file if it is playing
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // MARK: View is Loaded into memory
    // Audio is set up and resizing for all buttons is also set up
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
        handleResize(button: snailButton)
        handleResize(button: chipmunkButton)
        handleResize(button: rabbitButton)
        handleResize(button: vaderButton)
        handleResize(button: echoButton)
        handleResize(button: reverbButton)
        handleResize(button: stopButton)
        
    }
    
    // MARK: App is loaded into memory
    // Configures the UI to the not playing state by default
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    // MARK: Handle resizing
    // This function handles button images resizing on different screens
    func handleResize(button: UIButton){
        button.imageView?.contentMode = .scaleAspectFit
    }
}
