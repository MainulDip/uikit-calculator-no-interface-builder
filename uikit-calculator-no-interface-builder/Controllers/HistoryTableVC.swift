//
//  HistoryTableVC.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 2/28/25.
//

import UIKit
import Combine
class HistoryTableVC: UITableViewController {
    
    // Constants
    // data to feed tableview
    var historyData: [(equation: String, result: String)] = [
        ("1234 + 3","1237"),
        ("7 x 7", "49"),
        ("1234 + 3","1237"),
        ("7 x 7", "49"),
        ("1234 + 3","1237"),
        ("7 x 7", "49"),
        ("1234 + 3","1237"),
        ("7 x 7", "49"),
        ("1234 + 3","1237"),
        ("7 x 7", "49"),
        ("1234 + 3","1237"),
        ("last x last", "last")
        
    ]
    var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
//        historyData.publisher.sink { [weak self] latestHistory in
//            print(latestHistory)
//            self?.tableView.reloadData()
//        }.store(in: &cancellables)
        
        view.backgroundColor = .green
        tableView.backgroundColor = .orange
        
        
        // register a cell
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseIdentifier)
//        tableView.scrollToRow(at: IndexPath(row: historyData.count - 1, section: 0), at: .bottom, animated: false)
        
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("viewWillAppear called")
//        scrollToLast()
//        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseIdentifier, for: indexPath) as! HistoryCell
        
        let equationData = historyData[indexPath.row].equation
        let resultData = historyData[indexPath.row].result
        
        cell.setData(equation: equationData, result: resultData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    
    
}

// MARK: - Custom Functions
extension HistoryTableVC {
    func scrollToLast() {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        // TODO: - Complete this
        let lastRowIndexPath = IndexPath(row: lastRow, section: lastSection)
        tableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: false)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        scrollToLast()
    }
}
