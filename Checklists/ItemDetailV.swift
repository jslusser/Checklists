//
//  AddItemViewController.swift
//  Checklists
//
//  Created by James Slusser on 8/25/18.
//  Copyright © 2018 James Slusser. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailV)
    func itemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: ChecklistItem)
    func ItemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: ChecklistItem)
}

class ItemDetailV: UITableViewController, UITextFieldDelegate {

    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
       weak var delegate: ItemDetailViewControllerDelegate?
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
//        navigationController?.popViewController(animated: true)
//        print("Contents of text field: \(textField.text)")
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.ItemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    

    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
    
}

