//
//  ViewController.swift
//  To-Do List
//
//  Created by Shijan Ali Masuth on 10/26/24.
//
//  This app is developed as an educational project. If any copyrighted
//  materials are included in accordance with the multimedia fair use guidelines, a notice should be added
//  stating that “certain materials are included under the fair use exemption of the U.S. Copyright Law
//  and have been prepared according to the multimedia fair use guidelines and are restricted from further use.”


import UIKit

class ViewController: UIViewController {

    // All referencing outlets to display a task
    @IBOutlet weak var taskNumberLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var taskPanel: UIView!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyLevel: UILabel!
    
    // Array object of all tasks
    var allTasks = [Task]()
    
    // Button to display the next task
    @IBAction func displayNextTaskButton(_ sender: Any) {
        // Ensure we display the correct task first
        displayNextTask()

        // Increment the index for the next task
        currentTaskIndex += 1
                
        // If we've reached the end of the task list, reset the index to 0
        if currentTaskIndex >= allTasks.count {
            currentTaskIndex = 0
        }
    }
    
    // Display the next task after clicking the "Display Next Task" button
    var currentTaskIndex = 0 // This keeps track of the current task index.

    func defaultView() {
        taskNumberLabel.text = ""
        taskNameLabel.textAlignment = .center
        categoryLabel.text = ""
        deadlineLabel.text = ""
        difficultyLabel.text = ""
        difficultyLevel.backgroundColor = .clear
        
        taskPanel.layer.cornerRadius = 10
    }
    
    func displayNextTask() {
        // Check if there are any tasks to display
        if allTasks.isEmpty {
            taskNumberLabel.text = ""
            categoryLabel.text = ""
            deadlineLabel.text = ""
            difficultyLabel.text = ""
            difficultyLevel.backgroundColor = .clear
            
            taskNameLabel.textColor = .red
            taskNameLabel.text = "(No tasks to display.)"
        }
        else {
            taskNameLabel.textColor = .black
            
            // Get the task at the current index
            let task = allTasks[currentTaskIndex]
            
            // Update the labels with the task details
            taskNumberLabel.text = "Task \(currentTaskIndex + 1):"
            taskNameLabel.text = task.taskName
            categoryLabel.text = task.category
            deadlineLabel.text = task.deadline
            
            difficultyLabel.text = "Difficulty"
            switch task.difficulty {
            case "Easy":
                difficultyLevel.backgroundColor = UIColor.green
            case "Moderate":
                difficultyLevel.backgroundColor = UIColor.yellow
            case "Hard":
                difficultyLevel.backgroundColor = UIColor.red
            default:
                difficultyLevel.text = ""
            }
        }
    }

    @IBAction func aboutUsButton(_ sender: Any) {
        let browserApp = UIApplication.shared
        let url = URL(string: "https://mason.gmu.edu/~smasuth/aboutUs.html")!
        browserApp.open(url)
    }
    
    @IBAction func disclaimerButton(_ sender: Any) {
        let browserApp = UIApplication.shared
        let url = URL(string: "https://mason.gmu.edu/~smasuth/disclaimer.html")!
        browserApp.open(url)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultView()
        // Initial setup
    }
    
    // Prepare for segue to set the closure and pass allTasks to DeleteTaskViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addTaskVC = segue.destination as? AddTaskViewController {
            addTaskVC.onTaskAdded = { [weak self] newTask in
                self?.allTasks.append(newTask)
            }
        }
        
        if let deleteTaskVC = segue.destination as? DeleteTaskViewController {
            deleteTaskVC.allTasks = allTasks

            deleteTaskVC.onTaskDeleted = { [weak self] taskIndex in
                self?.allTasks.remove(at: taskIndex)
            }
        }

        if let modifyTaskVC = segue.destination as? ModifyTaskViewController {
            modifyTaskVC.allTasks = allTasks

            modifyTaskVC.onTaskModified = { [weak self] modifiedTask, taskIndex in
                self?.allTasks[taskIndex] = modifiedTask
            }
        }

        if let randomTaskVC = segue.destination as? RandomTaskViewController {
            randomTaskVC.allTasks = allTasks
        }
        
        if let searchTaskVC = segue.destination as? SearchTaskViewController {
            searchTaskVC.allTasks = allTasks
        }
    }
}
