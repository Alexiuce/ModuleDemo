//
//  ViewController.swift
//  03-RxSwiftMac
//
//  Created by caijinzhu on 2018/3/8.
//  Copyright © 2018年 alexiuce.github.io. All rights reserved.
//

import Cocoa
import RxSwift
import Quartz
import AVFoundation

class ViewController: NSViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let images = Variable<NSImage?>(nil)
    fileprivate var imageIndex = 1
    
    @IBOutlet weak var clearButton: NSButton!
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        images.asObservable().subscribe(onNext: { [weak self]  (photos) in
            self?.imageView.image = photos
            self?.clearButton.isEnabled = photos != nil
        }).disposed(by: disposeBag)
        
        
    }

    @IBAction func updateImage(_ sender: NSButton) {
        
        if imageIndex > 5 { imageIndex = 1}
        guard let image = NSImage(named: NSImage.Name("image0\(imageIndex)")) else {return}
        images.value = image
        imageIndex += 1
        
        /** 独立窗口   */
//        IKPictureTaker.pictureTaker().begin(withDelegate: self, didEnd: #selector(pictureTakerDidEnd(pictureTaker:returnCode:contextInfo:)), contextInfo: nil)
        /** 嵌入在当前窗口  */
//        IKPictureTaker.pictureTaker().beginSheet(for: view.window!, withDelegate: self, didEnd: #selector(pictureTakerDidEnd(pictureTaker:returnCode:contextInfo:)), contextInfo: nil)
        
        
    }

    
    @IBAction func clearImage(_ sender: Any) {
        
        images.value = nil
        
    }
    
}

//extension ViewController {
//
//     @objc func pictureTakerDidEnd(pictureTaker: IKPictureTaker, returnCode: Int, contextInfo: Any?)  {
//        print("picture select end.....")
//        images.value = pictureTaker.outputImage()
//    }
//
//}



