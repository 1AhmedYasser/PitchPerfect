//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Ahmed yasser on 3/28/19.
//  Copyright © 2019 Ahmed yasser. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: Properties
    // Define an object of type AVAudioRecorder
    var audioRecorder: AVAudioRecorder!
    
    // defines 2 UIbuttons and 1 UILabel and connects them to the UI using IBOutlet
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: View is Loaded into memory
    // Disables the stop recording button after the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: App is loaded into memory
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: App is appearing on Screen
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Mark: Record Audio
    /* This function handles ui changes when the record record button is pressed
     and saves the recorded audio to the full file path and then sets up an audio session
     and creates an audio recorder and pass the file path to it and begin recording
     */
    @IBAction func recordAudio(_ sender: Any) {
        configureUIChanges(state: true)
        
        /* gets the document directory path to save the audio file there , and then
         set a name for the recorded audio and then combine them to get the full path
         */
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    // MARK: Stop Recording Audio
    /* This function handles ui changes when the stop record button is pressed
     and stop the audio recorder and set the shared AVAudio session to inactive
     */
    @IBAction func stopRecording(_ sender: Any) {
        configureUIChanges(state: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: Recording finished
    // This function is used to call the stop recording segue to move to the audio playback screen
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            // Calls the stop recording segue and sends to it the path where the recorded file is located
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Saving audio was not successful")
        }
    }
    
    // Mark: Change recording states
    // This function handles UIChanges when the record or stop record buttons are pressed
    func configureUIChanges(state: Bool){
        if state {
            recordingLabel.text = "Recording In Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }else{
            recordingLabel.text = "Tap to record"
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }
    
    // MARK: Prepare for segue
    /* Checks the segue identifier and grab the destination view Contoller and
     then grab the recorded audio URL and then we set the recordedAudioURL in
     the PlaySoundsViewController to the sender URL
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

