//
//  DeleteTaskViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/25/24.
//

import UIKit
import AVKit
import AVFoundation

class DeleteTaskViewController: UIViewController {

    @IBOutlet weak var resultLabel: UITextView!
    @IBOutlet weak var deleteTextField: UITextField!
    
    // Array of tasks passed from the main view controller
    var allTasks: [Task] = []
    
    // Closure to pass back the deleted task index
    var onTaskDeleted: ((Int) -> Void)?
    
    // Sound players
    var deleteSound: AVAudioPlayer?
    var errorSound: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up sound players
        let deleteSoundURL = Bundle.main.url(forResource: "check", withExtension: "mp3")
        deleteSound = try? AVAudioPlayer(contentsOf: deleteSoundURL!)
        
        let errorSoundURL = Bundle.main.url(forResource: "error", withExtension: "mp3")
        errorSound = try? AVAudioPlayer(contentsOf: errorSoundURL!)
    }
    
    @IBAction func deleteFunction(_ sender: Any) {
        let taskNumberText = deleteTextField.text ?? ""
        
        if let taskNumber = Int(taskNumberText), taskNumber > 0, taskNumber <= allTasks.count {
            let taskIndex = taskNumber - 1
            allTasks.remove(at: taskIndex)
            onTaskDeleted?(taskIndex)
            resultLabel.text = "Task Deleted!"
            deleteSound?.play()  // Play delete sound on success
        } else {
            resultLabel.text = "Invalid task number. Please try again."
            errorSound?.play()  // Play error sound on failure
        }
    }
    
    @IBAction func goingBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
