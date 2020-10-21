//
//  InformationViewController.swift
//  HappyHour
//
//  Created by Macbook on 10/7/20.
//

import RealmSwift
import UIKit

class InformationViewController: UIViewController {
    
    public var item: HappyHourListItem?
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = item?.name
        addressLabel.text = item?.address
        timeLabel.text = item?.time
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else {
            return
        }
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapMapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "map") as! MapViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)        
        vc.addressTextField.text = addressLabel.text
    }

}
