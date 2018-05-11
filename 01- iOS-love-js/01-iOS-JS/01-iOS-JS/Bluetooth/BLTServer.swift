//
//
// BLTServer.swift
// Created by Alex on 2018/5/11
// Copyright © 2018年 alexiuce.github.io. All rights reserved.

//

import Foundation
import CoreBluetooth


class BLTServer: NSObject {
    
    var devices = [CBPeripheral]()
    lazy var  centerManager: CBCentralManager = {
      return  CBCentralManager(delegate: self, queue: nil)
    }()
    
    func starScan()  {
        if centerManager.isScanning || centerManager.state != .poweredOn {return}
        print("scan")
        centerManager.scanForPeripherals(withServices: nil, options: nil)
    }
}

// MARK: - CBCentralManagerDelegate
extension BLTServer: CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("power off")
        case .poweredOn:
            print("power on")
            centerManager.scanForPeripherals(withServices: nil, options: nil)
            
        default:
            print("other...")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("find device....")
        if devices.contains(peripheral){return}
        devices.append(peripheral)
        print(peripheral.name ?? "no name" )
    }
    
    
}
