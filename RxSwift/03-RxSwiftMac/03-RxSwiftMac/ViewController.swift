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
import EventKit

class ViewController: NSViewController {

    
    fileprivate let eventStore = EKEventStore()
    fileprivate  var isAuthor = false
    
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
        
        
        let speach = NSSpeechSynthesizer()
        speach.delegate = self
        let result = speach.setVoice(NSSpeechSynthesizer.VoiceName.init(rawValue: "com.apple.speech.synthesis.voice.damayanti"))
        if result {
            print("success")
        }else{
            print("failure")
        }
//        for voiceName in NSSpeechSynthesizer.availableVoices {
//            print(voiceName)
//        }
        speach.startSpeaking("Hello world")
        remindme()

        
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


extension ViewController{
    fileprivate func remindme(){
       
        let authorStatus = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
       
        switch authorStatus {
        case .authorized:
            isAuthor = true
        case .notDetermined:
            eventStore.requestAccess(to: .reminder, completion: { [weak self] (granted, error) in
                guard let strongSelf = self else {return}
                if granted {
                    DispatchQueue.main.async {
                        strongSelf.isAuthor = granted
                        strongSelf.createRemind()
                    }
                }
            })
        case .denied,.restricted:
            print("user deny ")
        }
        
        if !isAuthor {return}
        createRemind()
    }
    
    fileprivate func createRemind(){
        let reminder = EKReminder(eventStore: eventStore)
        reminder.calendar = eventStore.defaultCalendarForNewReminders()
        reminder.title = "remide title"
        let alarmDate = Date(timeInterval: 15, since: Date())
        let alarm = EKAlarm(absoluteDate: alarmDate)
        reminder.addAlarm(alarm)
        do {
            try  eventStore.save(reminder, commit: true)
        } catch  {
            print("save failure: \(error.localizedDescription)")
        }
    }
}


extension ViewController: NSSpeechSynthesizerDelegate{
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, willSpeakWord characterRange: NSRange, of string: String) {
        print("will speaKWord \(string) \(characterRange)")
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, willSpeakPhoneme phonemeOpcode: Int16) {
        print("will speakPhoneme \(phonemeOpcode)")
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didEncounterSyncMessage message: String) {
        print("did encounter message \(message)")
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        print("did finishedSpeaking ")
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didEncounterErrorAt characterIndex: Int, of string: String, message: String) {
        print("did error \(string)")
    }
}


