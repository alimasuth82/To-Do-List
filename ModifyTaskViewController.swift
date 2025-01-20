//
//  ModifyTaskViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/25/24.
//

import UIKit
import AVKit
import AVFoundation

class ModifyTaskViewController: UIViewController {

    @IBOutlet weak var taskNumberTextField: UITextField!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var deadlineField: UITextField!
    
    // Difficulty buttons
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var moderateButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var resultField: UITextView!
    
    // Closure to pass back the modified task
    var onTaskModified: ((Task, Int) -> Void)?
    
    // Variable to store the difficulty level
    var difficulty: String = "Easy"  // Default difficulty
    
    var allTasks: [Task] = []
    
    // Sound players
    var modifySound: AVAudioPlayer?
    var errorSound: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up sound players
        let modifySoundURL = Bundle.main.url(forResource: "check", withExtension: "mp3")
        modifySound = try? AVAudioPlayer(contentsOf: modifySoundURL!)
        
        let errorSoundURL = Bundle.main.url(forResource: "error", withExtension: "mp3")
        errorSound = try? AVAudioPlayer(contentsOf: errorSoundURL!)
    }
    
    @IBAction func difficultyButtonTapped(_ sender: UIButton) {
        switch sender {
        case easyButton:
            difficulty = "Easy"
            difficultyLabel.textColor = .green
        case moderateButton:
            difficulty = "Moderate"
            difficultyLabel.textColor = .yellow
        case hardButton:
            difficulty = "Hard"
            difficultyLabel.textColor = .red
        default:
            break
        }
        
        // Update the label to reflect the selected difficulty
        difficultyLabel.text = "\(difficulty)"
    }
    
    // Modify Task
    @IBAction func modifyTaskFunction(_ sender: Any) {
        let taskNumberText = taskNumberTextField.text ?? ""
        
        if let taskNumber = Int(taskNumberText), taskNumber > 0, taskNumber <= allTasks.count {
            let taskIndex = taskNumber - 1
            var modifiedTask = allTasks[taskIndex]
            
            if let taskName = taskNameField.text, !taskName.isEmpty {
                modifiedTask.taskName = taskName
            }
            
            if let category = categoryField.text, !category.isEmpty {
                modifiedTask.category = category
            }
            
            if let deadline = deadlineField.text, !deadline.isEmpty {
                if validateDateFormat(deadline) {
                    modifiedTask.deadline = deadline
                } else {
                    resultField.text = "Please enter the date in the correct format (MM/DD/YYYY)."
                    errorSound?.play()  // Play error sound on invalid date format
                    return
                }
            }
            
            modifiedTask.difficulty = difficulty
            onTaskModified?(modifiedTask, taskIndex)
            resultField.text = "Task modified successfully!"
            modifySound?.play()  // Play success sound on task modification
        } else {
            resultField.text = "Please enter a valid task number no greater than \(allTasks.count)."
            errorSound?.play()  // Play error sound on invalid task number
        }
    }
    
    // Helper function to validate date format
    func validateDateFormat(_ date: String) -> Bool {
        let dateComponents = date.split(separator: "/")
        if dateComponents.count == 3 {
            if let month = Int(dateComponents[0]), month >= 1 && month <= 12 {
                if let day = Int(dateComponents[1]), day >= 1 && day <= 31 {
                    if let year = Int(dateComponents[2]), year >= 1900 && year <= 2099 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // Button to go back
    @IBAction func cancelButton(_ sender: Any) {
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
}
