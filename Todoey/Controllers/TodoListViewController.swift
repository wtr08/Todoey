//
//  ViewController.swift
//  Todoey
//
//  Created by Wouter van Rijmenam on 19/02/2018.
//  Copyright © 2018 Stackmont. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {

    
    var todoItems: Results<Item>?
    let realm = try! Realm()
   
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    // Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            if (item.done) == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = "No items Added"
        }
        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
//                    item.done = !item.done
                    realm.delete(item)
                }
            } catch {
                print("error updateing done status \(error)")
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK - Add item button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            
        
            
            if let currentCategroty = self.selectedCategory {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategroty.items.append(newItem)
                        
                    }
                } catch {
                    print("Error saving new items realm \(error)")
                }
            }
        
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK - Model Manupulation Methods
//    func saveItems(item: Item) {
//        do {
//            try realm.write {
//                realm.add(item)
//            }
//        } catch {
//            print("Error saving context, \(error)")
//        }
//        tableView.reloadData()
//
//    }
//
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

    }
    

    
}

// MARK : - Search bar methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

        if (searchBar.text?.count == 0) {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }

}



