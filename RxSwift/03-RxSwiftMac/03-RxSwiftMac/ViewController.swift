//
//  ViewController.swift
//  03-RxSwiftMac
//
//  Created by caijinzhu on 2018/3/8.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let images = Variable<NSImage>(NSImage())
    fileprivate var imageIndex = 1
    
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        images.asObservable().subscribe(onNext: { [weak self]  (photos) in
            self?.imageView.image = photos
        }).disposed(by: disposeBag)
    }

    @IBAction func updateImage(_ sender: NSButton) {
        
        if imageIndex > 5 { imageIndex = 1}
        guard let image = NSImage(named: NSImage.Name("image0\(imageIndex)")) else {return}
        images.value = image
        imageIndex += 1
        
    }

    
    @IBAction func clearImage(_ sender: Any) {
        
        images.value = NSImage()
        
    }
    
    
    
    
}

