//
//  AddItemViewController.swift
//  Checklists
//
//  Created by James Slusser on 8/25/18.
//  Copyright © 2018 James Slusser. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViwControllerDidCancel(_ controller: AddItemViewController)
    func addItenViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
       weak var delegate: AddItemViewControllerDelegate?
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        delegate?.addItemViwControllerDidCancel(self)
    }
    
    @IBAction func done() {
//        navigationController?.popViewController(animated: true)
//        print("Contents of text field: \(textField.text)")
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItenViewController(self, didFinishAdding: item)
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

