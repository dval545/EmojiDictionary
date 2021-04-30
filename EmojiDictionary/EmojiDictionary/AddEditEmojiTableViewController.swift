//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Admin1 on 25/8/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextView.text = emoji.description
        usageTextView.text = emoji.usage
        
        updateSaveButtonState()
    }
    
    // MARK: - Model:
    var emoji = Emoji(symbol: nil, name: nil, description: nil, usage: nil)
    
    // MARK: - Outlets
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var usageTextView: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - funcs
    func updateSaveButtonState(){
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextView.text ?? ""
        let usageText = usageTextView.text ?? ""
        saveButton.isEnabled = !symbolText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField){
        updateSaveButtonState()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwind"{
            let symbolText = symbolTextField.text ?? ""
            let nameText = nameTextField.text ?? ""
            let descriptionText = descriptionTextView.text ?? ""
            let usageText = usageTextView.text ?? ""
            
            emoji = Emoji(symbol: symbolText, name: nameText, description: descriptionText, usage: usageText)
            
        }
    }
    

}
