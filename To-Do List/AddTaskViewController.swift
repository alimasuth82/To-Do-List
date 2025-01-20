//
//  AddTaskViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/25/24.
//

import UIKit
import AVKit
import AVFoundation

class AddTaskViewController: UIViewController {

    // Text Field Referencing Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    
    // Buttons for Difficulty Levels
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var moderateButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    // Message Referencing Outlet
    @IBOutlet weak var messageLabel: UITextView!

    // Closure to pass back the added task
    var onTaskAdded: ((Task) -> Void)?
    
    // Variable to store the difficulty level
    var difficulty: String = "Easy"  // Default difficulty

    // Sound players
    var completeSound: AVAudioPlayer?
    var errorSound: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up sound players without conditionals
        let completeSoundURL = Bundle.main.url(forResource: "check", withExtension: "mp3")
        completeSound = try? AVAudioPlayer(contentsOf: completeSoundURL!)
        
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

    @IBAction func addTaskFunction(_ sender: Any) {
        if taskNameTextField.text == "" || categoryTextField.text == "" || deadlineTextField.text == "" {
            messageLabel.text = "Please fill all the fields."
            errorSound?.play()
            return
        }
        
        let deadlineText = deadlineTextField.text ?? ""
        if !validateDateFormat(deadlineText) {
            messageLabel.text = "Please enter the date in the correct format (MM/DD/YYYY)."
            errorSound?.play()
            return
        }

        // If all checks pass, create a new task
        let newTask = Task()
        newTask.taskName = taskNameTextField.text ?? ""
        newTask.category = categoryTextField.text ?? ""
        newTask.deadline = deadlineText
        newTask.difficulty = difficulty  // Assign the selected difficulty

        onTaskAdded?(newTask)
        messageLabel.text = "Task added successfully!"
        completeSound?.play()
    }
    
    func validateDateFormat(_ date: String) -> Bool {
        let dateComponents = date.split(separator: "/")
        
        if date.count == 10, dateComponents.count == 3,
           let month = Int(dateComponents[0]), month >= 1 && month <= 12,
           let day = Int(dateComponents[1]), day >= 1 && day <= 31,
           let year = Int(dateComponents[2]), year >= 1900 && year <= 2099 {
            return true
        }
        return false
    }
    
    // Button to go back
    @IBAction func goingBackButton(_ sender: Any) {
        // Dismiss the current view controller
        dismiss(animated: true, completion: nil)
    }
}
