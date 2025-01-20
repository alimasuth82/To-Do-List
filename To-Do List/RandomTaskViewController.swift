//
//  RandomTaskViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/25/24.
//

import UIKit

class RandomTaskViewController: UIViewController {

    // Date
    @IBOutlet weak var date: UILabel!
    
    // Task Information
    @IBOutlet weak var taskName: UITextView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var taskPanel: UIView!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLevel: UILabel!
    
    var allTasks: [Task] = []

    func defaultSetup() {
        taskName.textAlignment = .center
        taskPanel.layer.cornerRadius = 10
        date.text = Date().formatted(.dateTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSetup()
        displayRandomTask()
    }
    
    func displayRandomTask() {
        // Check if there are tasks in the array
        if allTasks.isEmpty {
            taskName.textColor = .red
            taskName.text = "(No tasks to display.)"
            
            category.text = ""
            deadline.text = ""
            difficultyLabel.text = ""
            difficultyLevel.backgroundColor = .clear
        } else {
            if let randomTask = allTasks.randomElement() {
                taskName.textColor = .black
                taskName.text = randomTask.taskName
                category.text = randomTask.category
                deadline.text = randomTask.deadline
                difficultyLabel.text = "Difficulty"
                
                switch randomTask.difficulty {
                case "Easy":
                    difficultyLevel.backgroundColor = .green
                case "Moderate":
                    difficultyLevel.backgroundColor = .yellow
                case "Hard":
                    difficultyLevel.backgroundColor = .red
                default:
                    difficultyLevel.backgroundColor = .clear
                }
            }
        }
    }
    
    // Button to go back
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
