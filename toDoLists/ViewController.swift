//
//  ViewController.swift
//  toDoList
//
//  Created by Lucas Mudo de Araujo on 7/12/19.
//  Copyright © 2019 Lucas Mudo de Araujo. All rights reserved.
// THIS IS THE SIMPLE TO DO

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var rewardTextLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
}

class ViewController: UITableViewController {
    
    //private var todoItems = ToDoItem.getMockData()
    private var activeQuests = [Quests]()
    private var completedQuests = [Quests]()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func segmentedChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch (segmentControl.selectedSegmentIndex) {
        case 0:
            return activeQuests.count
        case 1:
            return completedQuests.count
        default:
            break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath) as! HeadlineTableViewCell
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            if indexPath.row < activeQuests.count{
                let item = activeQuests[indexPath.row]
                cell.titleTextLabel?.text = item.title
                let rwd = String(item.reward)
                cell.rewardTextLabel?.text = rwd
                cell.iconImageView?.image = UIImage(named: "green_circle")
                
                let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
                cell.accessoryType = accessory
            }
            return cell
        case 1:
            if indexPath.row < completedQuests.count{
                let item = completedQuests[indexPath.row]
                cell.titleTextLabel?.text = item.title
                let rwd = String(item.reward)
                cell.rewardTextLabel?.text = rwd
                cell.iconImageView?.image = UIImage(named: "green_circle")
                
                let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .checkmark
                cell.accessoryType = accessory
            }
            return cell
        default:
            break
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        if segmentControl.selectedSegmentIndex == 0{
            if indexPath.row < activeQuests.count{
                let item = activeQuests[indexPath.row]
                item.done = !item.done
                //tableView.reloadRows(at: [indexPath], with: .automatic)
                switchQuestStatus(index: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem){
        // Create an alert
        let alert = UIAlertController(
            title: "New quest",
            message: "Insert the title and reward of a new Quest:",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Title"
            textField.clearButtonMode = .whileEditing
        }
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Reward"
            textField.clearButtonMode = .whileEditing
        } 
        // Add a "cancel" button to the alert. This one doesn't need a handler
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let title = alert.textFields?[0].text, let reward = alert.textFields?[1].text
            {
                self.addNewToDoItem(title: title,reward: reward)
            }
        }))
        
        // Present the alert to the user
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewToDoItem(title: String,reward:String){
        // The index of the new item will be the current item count
        let newIndex = activeQuests.count
        
        // Create new item and add it to the todo items list
        activeQuests.append(Quests(title: title,reward: reward))
        
        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row < activeQuests.count
        {
            activeQuests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    //HELPERS
    func switchQuestStatus(index:Int){
        var swapQuest:Quests = activeQuests[index]
        completedQuests.append(swapQuest)
        activeQuests.remove(at: index)
    }
    
}


