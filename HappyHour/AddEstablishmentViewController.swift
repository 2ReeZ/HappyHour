//
//  AddEstablishmentViewController.swift
//  HappyHour
//
//  Created by Macbook on 10/7/20.
//

import RealmSwift
import UIKit

class AddEstablishmentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var timeField: UITextField!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.becomeFirstResponder()
        nameField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func didTapSaveButton() {
        if let name = nameField.text, !name.isEmpty {
            let address = addressField.text
            let time = timeField.text
            
            realm.beginWrite()
            
            let newItem = HappyHourListItem()
            newItem.address = address!
            newItem.name = name
            newItem.time = time!
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("Add something")
        }
    }

}
