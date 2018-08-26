//
//  ViewController.swift
//  Checklists
//
//  Created by James Slusser on 8/23/18.
//  Copyright © 2018 James Slusser. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViwControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }

    var items:[ChecklistItem]
    
//    var row0Item: ChecklistItem
//    var row1Item: ChecklistItem
//    var row2Item: ChecklistItem
//    var row3Item: ChecklistItem
//    var row4Item: ChecklistItem
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        // print("added item")
        var titles = ["new row title A","new row title B","new row title C","new row title D","new row title E"]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        let title = titles[Int(randomNumber)]
        
        let newRowIndex = items.count
        let item = ChecklistItem()
        item.text = title
        item.checked = true
        
        items.append(item)
        
        
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0Item = ChecklistItem()
        row0Item.text = "Walk the dog"
        row0Item.checked = false
        items.append(row0Item)
        
        let row1Item = ChecklistItem()
        row1Item.text = "Brush teeth"
        row1Item.checked = false
        items.append(row1Item)
        
        let row2Item = ChecklistItem()
        row2Item.text = "Learn iOS development"
        row2Item.checked = false
        items.append(row2Item)
        
        let row3Item = ChecklistItem()
        row3Item.text = "Soccer practice"
        row3Item.checked = false
        items.append(row3Item)
        
        let row4Item = ChecklistItem()
        row4Item.text = "Eat ice cream"
        row4Item.checked = false
        items.append(row4Item)
        
        let row5Item = ChecklistItem()
        row5Item.text = "Watch Hulu"
        row5Item.checked = false
        items.append(row5Item)
        
        let row6Item = ChecklistItem()
        row6Item.text = "Swim laps"
        row6Item.checked = false
        items.append(row6Item)
        
        let row7Item = ChecklistItem()
        row7Item.text = "Buy groceries"
        row7Item.checked = false
        items.append(row7Item)
        
        
        super.init(coder: aDecoder)
        
    }
        
//    let row0text = "Walk the dog"
//    let row1text = "Brush teeth"
//    let row2text = "Learn iOS development"
//    let row3text = "Soccer practice"
//    let row4text = "Eat ice cream"
//    var row0Checked = false
//    var row1Checked = false
//    var row2Checked = false
//    var row3Checked = false
//    var row4Checked = false
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        //let indexPaths = [indexPath]
        //tableView.deleteRows(at: indexPaths, with: .automatic)
    tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            //item.checked = !item.checked
            item.toggleChecked()
            
//            if indexPath.row == 0 {
//                row0Item.checked = !row0Item.checked
//                //row0Checked = !row0Checked
//            }
//            if indexPath.row == 1 {
//                row1Item.checked = !row1Item.checked
//                //row1Checked = !row1Checked
//            }
//            if indexPath.row == 2 {
//                row2Item.checked = !row2Item.checked
//                //row2Checked = !row2Checked
//            }
//            if indexPath.row == 3 {
//                row3Item.checked = !row3Item.checked
//                //row3Checked = !row3Checked
//            }
//            if indexPath.row == 4 {
//                row4Item.checked = !row4Item.checked
//                //row4Checked = !row4Checked
//            }
            
            //configureCheckmark(for: cell, at: indexPath)
            configureCheckmark(for: cell, with: item)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        //let label = cell.viewWithTag(1000) as! UILabel
        
        let item = items[indexPath.row]
        //label.text = item.text
        
//        if indexPath.row == 0 {
//            label.text = row0Item.text
//            //label.text = row0text
//        } else if indexPath.row == 1 {
//            label.text = row1Item.text
//            //label.text = row1text
//        } else if indexPath.row == 2 {
//           label.text = row2Item.text
//            //label.text = row2text
//        } else if indexPath.row == 3 {
//           label.text = row3Item.text
//            //label.text = row3text
//        } else if indexPath.row == 4 {
//            label.text = row4Item.text
//            //label.text = row4text
//        }
        
        configureText(for: cell, with: item)
        
        //configureCheckmark(for: cell, at: indexPath)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
    }
   // func configureCheckmark(for cell: UITableViewCell, at indexPath: IndexPath) {
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
      //  var isChecked = false
      
        //let item = items[indexPath.row]
        
        
        
//        if indexPath.row == 0 {
//            isChecked = row0Item.checked
//        } else if indexPath.row == 1 {
//            isChecked = row1Item.checked
//        } else if indexPath.row == 2 {
//            isChecked = row2Item.checked
//        } else if indexPath.row == 3 {
//            isChecked = row3Item.checked
//        } else if indexPath.row == 4 {
//            isChecked = row4Item.checked
//        }
        
        //if isChecked {
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            //cell.accessoryType = .checkmark
            label.text = "√"
        } else {
            //cell.accessoryType = .none
            label.text = ""
        }
        
    }
    
    
    
    
    
    
    
}

