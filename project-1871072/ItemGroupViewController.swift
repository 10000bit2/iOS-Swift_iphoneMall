//
//  ViewController.swift
//  project-1871072
//
//  Created by 10000bit on 2021/05/20.
//

import UIKit

class ItemGroupViewController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    var itemGroup: ItemGroup!
}

extension ItemGroupViewController{
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        if let indexPath = itemTableView.indexPathForSelectedRow{
            itemTableView.reloadRows(at: [indexPath], with: .automatic)
            itemTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            itemTableView.cellForRow(at: indexPath)?.backgroundColor = .lightGray
        }
    }
}

extension ItemGroupViewController{
    
    @IBAction func editTable1(_ sender: UIBarButtonItem) {
        if itemTableView.isEditing == true{
            itemTableView.isEditing = false
            //sender.setTitle("Edit", for: .normal)
            sender.title = "Edit"
        } else{
            itemTableView.isEditing = true
            //sender.setTitle("Done", for: .normal)
            sender.title = "Done"
        }
    }
}

extension ItemGroupViewController{
    @IBAction func addItem1(_ sender: UIBarButtonItem) {
        let item = Item(random: true)
        itemGroup.addItem(item: item)
        let indexPath = IndexPath(row: itemGroup.count()-1, section: 0)
        itemTableView.insertRows(at: [indexPath], with: .automatic)
    }
}

extension ItemGroupViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemGroup = ItemGroup()
        itemGroup.testData()
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        //editing mode 원하면 true
        //itemTableView.isEditing = true
        self.navigationItem.title = "Item Group"
    }
}

extension ItemGroupViewController{
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = itemTableView.indexPathForSelectedRow{
            itemTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ItemGroupViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemGroup.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell")!
        
        let item = itemGroup.items[indexPath.row]
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = item.user
        //cell.accessibilityLabel!.text = item.price
        cell.backgroundColor = .white
        
        return cell
    }
}

extension ItemGroupViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .lightGray
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}

extension ItemGroupViewController{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = itemGroup.items[indexPath.row]
            let title = "Delete \(item.name)"
            let message = "Are you sure ..."
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Sure", style: .destructive){
                (action) in
                self.itemGroup.removeItem(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true)
        }
    }
}

extension ItemGroupViewController{
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let from = itemGroup.items[sourceIndexPath.row]
        let to = itemGroup.items[sourceIndexPath.row]
        itemGroup.modifyItem(item: from, index: destinationIndexPath.row)
        itemGroup.modifyItem(item: to, index: sourceIndexPath.row)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension ItemGroupViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailViewController = segue.destination as! ItemDetailViewController
        if let row = itemTableView.indexPathForSelectedRow?.row{
            itemDetailViewController.item = itemGroup.items[row]
        }
    }
}
