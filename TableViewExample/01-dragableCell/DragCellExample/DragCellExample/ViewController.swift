//
//  ViewController.swift
//  DragCellExample
//
//  Created by caijinzhu on 2018/4/4.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var sectionArray = ["One","Two","Three","Four","Five","Six"]
    fileprivate var itemArray = ["name","job","fav","age"]
    fileprivate var currentSelectedGroupIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionFooterHeight = 0
       
    }
}


extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "drag", for: indexPath)
        
        cell.textLabel?.text = "Group \(sectionArray[indexPath.section]) - index \(itemArray[indexPath.row])"
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(sectionArray[section])"
    }

    
}

extension ViewController: UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sectionArray.swapAt(sourceIndexPath.section, destinationIndexPath.section)
        itemArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedGroupIndex = indexPath.section
        tableView.isEditing = true
        
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.section == sourceIndexPath.section {
            return proposedDestinationIndexPath
        }
        return sourceIndexPath
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       
        return indexPath.section == currentSelectedGroupIndex
    }
  
    
    
}
