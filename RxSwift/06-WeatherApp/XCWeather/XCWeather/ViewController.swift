//
//  ViewController.swift
//  XCWeather
//
//  Created by caijinzhu on 2018/3/14.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let viewmodel = ViewModel()
//    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Person>>(configureCell: { _,tv,path,item in
//
//        let cell = tv.dequeueReusableCell(withIdentifier: "home-cell", for: path) as! HomeCell
//        cell.person = item
//        return cell
//    })
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewmodel.Persons.bind(to: tableView.rx.items(cellIdentifier: "home-cell", cellType: HomeCell.self)){ (row, element, cell) in
            cell.person = element

        }.disposed(by: disposeBag)

//        viewmodel.getPersons().bind(to:tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
//        tableView.rx.itemSelected.map { indexPath in
//            return (indexPath,self.dataSource[indexPath])
//            }.subscribe(onNext: { indexPath, model in
//
//            }).disposed(by: disposeBag)
        
//
//        tableView.rx.itemSelected.map{
//            return ($0, self.dataSource[$0])
//            }.subscribe(onNext: {
//                print("$0 \($0)")
//            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Person.self).subscribe(onNext: {
            print("select \($0.name)")
        }).disposed(by: disposeBag)
      
    }

}

