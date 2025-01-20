//
//  SearchTaskViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/26/24.
//

import UIKit
import AVKit
import AVFoundation

class SearchTaskViewController: UIViewController {
    
    // Text Field
    @IBOutlet weak var searchTextField: UITextField!
    
    // Result Elements
    @IBOutlet weak var resultHeading: UILabel!
    @IBOutlet weak var taskPanel: UIView!
    @IBOutlet weak var taskName: UITextView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLevel: UILabel!
    
    // All Tasks Array
    var allTasks = [Task]()
    
    // Sound players
    var taskFoundSound: AVAudioPlayer?
    var noTaskSound: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
        
        // Set up sound players
        let taskFoundSoundURL = Bundle.main.url(forResource: "check", withExtension: "mp3")
        taskFoundSound = try? AVAudioPlayer(contentsOf: taskFoundSoundURL!)
        
        let noTaskSoundURL = Bundle.main.url(forResource: "error", withExtension: "mp3")
        noTaskSound = try? AVAudioPlayer(contentsOf: noTaskSoundURL!)
    }
    
    // Search Task
    @IBAction func searchButton(_ sender: Any) {
        searchTask()
    }
    
    // Cancel
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Search Task Function
    func searchTask() {
        let searchText = searchTextField.text ?? ""
        
        if searchText.isEmpty {
            taskPanel.isHidden = true
            resultHeading.text = "Please enter a search term."
        } else {
            var taskFound = false
            
            for task in allTasks {
                if task.taskName.lowercased().contains(searchText.lowercased()) {
                    taskPanel.isHidden = false
                    resultHeading.text = "Search Result for \"\(searchText)\""
                    taskName.text = task.taskName
                    category.text = task.category
                    deadline.text = task.deadline
                    difficultyLabel.text = "Difficulty"
                    
                    switch task.difficulty {
                    case "Easy":
                        difficultyLevel.backgroundColor = .green
                    case "Moderate":
                        difficultyLevel.backgroundColor = .yellow
                    case "Hard":
                        difficultyLevel.backgroundColor = .red
                    default:
                        difficultyLevel.backgroundColor = .black
                    }
                    
                    taskFound = true
                    taskFoundSound?.play()  // Play success sound when a task is found
                    break
                }
            }

            if !taskFound {
                taskPanel.isHidden = false
                resultHeading.text = "Search Result for \"\(searchText)\""
                taskName.text = "No results found for \(searchText)."
                category.text = ""
                deadline.text = ""
                difficultyLabel.text = ""
                difficultyLevel.backgroundColor = .clear
                noTaskSound?.play()  // Play error sound if no task is found
            }
        }
    }
    
    // Default view
    func defaultView() {
        resultHeading.text = ""
        taskPanel.layer.cornerRadius = 10
        taskPanel.isHidden = true
        taskName.textAlignment = .center
    }
}
