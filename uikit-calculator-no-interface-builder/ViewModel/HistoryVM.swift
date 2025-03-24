//
//  HistoryVM.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 3/23/25.
//

import Foundation

protocol HistoryVMProtocol {
    var _historyState: [History] { get set }
    init () // populate data from NSCoder
    func dataDidRead() -> [History]
    func dataDidSet(newData: History, callBack: ([History]) -> Void)
    func dataDidDrop(oldData: History, callBack: ([History]) -> Void)
}


class HistoryVM {
    private var historyState: [History] = []
    
    init() {
        // populate from NSCoder, if NSCoder returns nil, the empty array will persist
        historyState = []
    }
    
    func dataDidSet(historyData: History, callBack: ([History]) -> Void) {
        // save the data into the NScoder
        
        callBack(historyState)
    }
    
    private func readHistoryDataFromNSCoder() -> [History] {
        return []
    }
    
    
}
