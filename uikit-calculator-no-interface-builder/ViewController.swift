//
//  ViewController.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 1/18/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var equationViewHeightConstraint = NSLayoutConstraint()
    var preEquationViewHeightConstraint = NSLayoutConstraint()
    var controlsViewHeightConstraint = NSLayoutConstraint()
    // var buttonHoderViewHeightConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
    }
    var fontSize: CGFloat {
        UIScreen.main.bounds.height > UIScreen.main.bounds.width ? 36 : 24
    }
    
    private let calcBtnValArr = [
        ["C", "()", "%", "/"],
        ["7", "8", "9", "X"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "4"],
        ["+/-", "0", ".", "="]
    ]
    
    private lazy var calcBtnGenerator: [UIButton] = {
        var btns: [UIButton] = []
        for row in calcBtnValArr {
            for val in row {
                let btn = UIButtonRound(type: .system)
                btn.setTitle(val, for: .normal)
                btn.titleLabel?.font = .systemFont(ofSize: fontSize)
            }
        }
        return btns
    }()
    
    private func makeColumns()  -> UIStackView {
        //delete previous vertical stack
        
        //make vertial stack
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
//        VStackViewContainer.spacing = 10
        verticalStack.backgroundColor = .orange
        
        for row in calcBtnValArr {
            //make horizontal row stack
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            for buttonTitle in row {
                //create calc button
                let button = UIButtonRound()
                button.setTitle(buttonTitle, for: .normal)
                button.setTitleColor(.orange, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 24)
                button.backgroundColor = .darkGray
                //add button to row
                horizontalStack.addArrangedSubview(button)
                horizontalStack.axis = .horizontal
                horizontalStack.distribution = .fillEqually
                horizontalStack.alignment = .center
                horizontalStack.spacing = 12
                horizontalStack.backgroundColor = .red
                
            }
            
            //Add row to vertical stack
            verticalStack.addArrangedSubview(horizontalStack)
        }
        return verticalStack
    }
    
    private lazy var equationView: (container: UIView, textView: UITextView) = {
        let view = UIView()
        view.backgroundColor = .red
        let isLandscape = self.view.frame.width > self.view.frame.height
        self.equationViewHeightConstraint = view.heightAnchor.constraint(equalToConstant:  self.view.frame.height * 0.15)
        equationViewHeightConstraint.isActive = true
        
        // inner UITextView setup
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .purple
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        textView.textColor = .white
        textView.text = "123,456+301"
        textView.font = .systemFont(ofSize: 40, weight: .bold)
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return (view, textView)
    }()
    
    private lazy var preEquationView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.backgroundColor = .lightGray
        self.preEquationViewHeightConstraint =  view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.09)
        self.preEquationViewHeightConstraint.isActive = true
        
        // inner UITextView setup
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .purple
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        textView.textColor = .lightGray
        textView.text = "123,757"
        textView.font = .systemFont(ofSize: 24, weight: .bold)
        
        view.addSubview(textView)
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }()
    
    private lazy var controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        self.controlsViewHeightConstraint = view.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.09)
        self.controlsViewHeightConstraint.isActive = true
        
        
        // add horizontal UIStackView as container
        // place 2 horizontal UIStackView as containers subView
        // add 3 button containing icons to the left
        // add 1 button containing icon to the right
        
        let leftHStackBtnHolder = UIStackView(arrangedSubviews: [])
        leftHStackBtnHolder.distribution = .equalSpacing
        leftHStackBtnHolder.backgroundColor = .orange
        
        let rightHStackBtnHolder = UIStackView(arrangedSubviews: [])
        rightHStackBtnHolder.backgroundColor = .black
        rightHStackBtnHolder.alignment = .trailing
        rightHStackBtnHolder.axis = .vertical
        
        let horizontalStackViewContainer = UIStackView(arrangedSubviews: [leftHStackBtnHolder, rightHStackBtnHolder])
        horizontalStackViewContainer.axis = .horizontal
        horizontalStackViewContainer.distribution = .fillEqually
        
        view.addSubview(horizontalStackViewContainer
        )
        
        horizontalStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        horizontalStackViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        horizontalStackViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        horizontalStackViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        return view
    }()
   
    private lazy var buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        
        // add a vertical UIStackView as container
        // place 5 horizontal UIStackView as containers subView
        // each horizontal one will hold 4 buttons with icons with proper spacing and styling
        let VStackViewContainer = makeColumns()
      
        view.addSubview(VStackViewContainer)
        VStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        VStackViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        VStackViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        VStackViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        VStackViewContainer.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        VStackViewContainer.isLayoutMarginsRelativeArrangement = true
        
        return view
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        let isLandscape = size.width > size.height
        equationViewHeightConstraint.constant = isLandscape ? size.height * 0.24 : size.height * 0.15
        preEquationViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        controlsViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
//        let stack = buttonHolderView.subviews.first as? UIStackView
//        stack?.arrangedSubviews.map { $0 as? UIStackView }.forEach({ stack in
//            stack?.arrangedSubviews.map { $0 as? UIButton }.forEach({ button in
//
//            })
//        })
//        setFonts()
        view.layoutIfNeeded() // deffered recomposition
    }
    
    private func setFonts() {
//        [calcBtn0, calcBtn1, calcBtn2, calcBtn3, calcBtn4, calcBtn5, calcBtn6, calcBtn7].forEach { button in
//            let title = button.title(for: .normal) ?? ""
//            button.setAttributedTitle(.init(string: title, attributes: [.font: UIFont.systemFont(ofSize: fontSize)]), for: .normal)
//        }
    }
    
    private func setupLayout() {
        let containerView = UIView()
        view.addSubview(containerView)
        view.backgroundColor = .yellow
        containerView.backgroundColor = .blue
        // containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        // auto layout impl
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [equationView.container, preEquationView, controlsView, buttonHolderView])
        
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
        stackView.autoresizesSubviews = false
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
    }


}

