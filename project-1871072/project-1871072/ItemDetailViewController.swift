//
//  ItemDetailViewController.swift
//  project-1871072
//
//  Created by 10000bit on 2021/05/20.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController{
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    
    var item: Item?
}

extension ItemDetailViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        item = item ?? Item(random: true)
        itemPriceLabel.text = item!.price
        nameTextField.text = item!.user
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        navigationItem.title = "\(item!.name)"
    }
}

extension ItemDetailViewController{
    @objc func dismissKeyBoard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension ItemDetailViewController{
    override func viewWillDisappear(_ animated: Bool) {
        item!.user = nameTextField.text!
        
    }
}
