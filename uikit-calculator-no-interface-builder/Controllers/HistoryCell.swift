//
//  HistoryCell.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 3/1/25.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    static let reuseIdentifier = "HistoryCell"
    
    // FIXME: Convert this to single UITextView
//    var equation: String = ""
//    var result: String = ""
    private let historyView: UITextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLayout()
//        guard let equationC = equation, let resultC = resut else { return }
//        print("equation = \(equationC) and resut = \(resultC)")
        
    }
    
    private func setupCellLayout() {
        contentView.backgroundColor = .black
        contentView.addSubview(historyView)
        historyView.backgroundColor = .black
        historyView.textColor = .white
        historyView.isEditable = false
        historyView.isScrollEnabled = false
        historyView.textAlignment = .right
        
        // set auto layout for historyView
        historyView.translatesAutoresizingMaskIntoConstraints = false
        historyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        historyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        historyView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        historyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        // TODO: Text align right
        // TODO: Chat like ui, scroll from down to top
        
    }
    
    
    // populate the cell with data from enclosing tableview
    func setData(equation: String, result: String) {
        // FIXME: (fixed) Move this to TableViewVC and inject from there to the view
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        
        let equationAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24), .paragraphStyle: paragraphStyle]
        let resultAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 17), .paragraphStyle: paragraphStyle]
        
        let equationAttributedString = NSMutableAttributedString(string: "\(equation)\n", attributes: equationAttributes)
        let resultAttributedString = NSMutableAttributedString(string: "\(result)", attributes: resultAttributes)
        equationAttributedString.append(resultAttributedString)
        historyView.attributedText = equationAttributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
