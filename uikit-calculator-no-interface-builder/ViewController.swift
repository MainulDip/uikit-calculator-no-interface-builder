//
//  ViewController.swift
//  uikit-calculator-no-interface-builder
//
//  Created by Mainul Dip on 1/18/25.
//

import UIKit

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
    
    private lazy var dummyBtn: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
//        uiButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return uiButton
    }()
    
    private lazy var dummyBtn2: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
//        uiButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return uiButton
    }()
    
    private lazy var dummyBtn3: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
//        uiButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return uiButton
    }()
    
    private lazy var dummyBtn4: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
//        uiButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        uiButton.backgroundColor = .yellow
        return uiButton
    }()
    
    private lazy var dummyBtn5: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        uiButton.tintColor = .white
//        uiButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        uiButton.backgroundColor = .yellow
        return uiButton
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
        
        let leftHStackBtnHolder = UIStackView(arrangedSubviews: [dummyBtn, dummyBtn2, dummyBtn3])
        leftHStackBtnHolder.distribution = .equalSpacing
        leftHStackBtnHolder.backgroundColor = .orange
        
        let rightHStackBtnHolder = UIStackView(arrangedSubviews: [dummyBtn4, /*dummyBtn5*/])
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
    
    // specify all the button for 1st row
    private lazy var calcBtnC: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("C", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnParen: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("()", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnCPercent: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("%", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnDevide: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("/", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var CalcBtnStack1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calcBtnC, calcBtnParen, calcBtnCPercent, calcBtnDevide])
        stackView.axis = .horizontal
//        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    // specify all the button for 2st row
    private lazy var calcBtn7: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("7", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn8: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("8", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn9: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("9", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnMultiply: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("X", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var CalcBtnStack2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calcBtn7, calcBtn8, calcBtn9, calcBtnMultiply])
        stackView.axis = .horizontal
//        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    // specify all the button for 3rd row
    private lazy var calcBtn4: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("4", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn5: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("5", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn6: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("6", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnMinus: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("-", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var CalcBtnStack3: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calcBtn4, calcBtn5, calcBtn6, calcBtnMinus])
        stackView.axis = .horizontal
//        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    // specify all the button for 4th row
    private lazy var calcBtn1: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("1", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn2: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("2", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn3: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("3", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnPlus: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("+", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var CalcBtnStack4: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calcBtn1, calcBtn2, calcBtn3, calcBtnPlus])
        stackView.axis = .horizontal
//        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    // specify all the button for 4th row
    private lazy var calcBtnPlusMinus: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("+/-", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtn0: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("0", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnDot: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle(".", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var calcBtnEqual: UIButton = {
        let uiButton = UIButtonRound()
        uiButton.setTitle("=", for: .normal)
        uiButton.setTitleColor(.orange, for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 24)
//        uiButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        uiButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print(uiButton.layer.frame.width)
        uiButton.backgroundColor = .darkGray
        return uiButton
    }()
    
    private lazy var CalcBtnStack5: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [calcBtnPlusMinus, calcBtn0, calcBtnDot, calcBtnEqual])
        stackView.axis = .horizontal
//        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .red
        
        return stackView
    }()
    
    private lazy var buttonHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        
        // add a vertical UIStackView as container
        // place 5 horizontal UIStackView as containers subView
        // each horizontal one will hold 4 buttons with icons with proper spacing and styling
        let VStackViewContainer = UIStackView(arrangedSubviews: [CalcBtnStack1, CalcBtnStack2, CalcBtnStack3, CalcBtnStack4, CalcBtnStack5])
        VStackViewContainer.axis = .vertical
        VStackViewContainer.distribution = .fillEqually
        VStackViewContainer.spacing = 10
        VStackViewContainer.backgroundColor = .black
        
        view.addSubview(VStackViewContainer)
        VStackViewContainer.translatesAutoresizingMaskIntoConstraints = false
//        VStackViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        VStackViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        VStackViewContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        VStackViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        VStackViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        VStackViewContainer.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor).isActive = true
//        VStackViewContainer.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor).isActive = true
        
        return view
    }()
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        let isLandscape = size.width > size.height
        equationViewHeightConstraint.constant = isLandscape ? size.height * 0.24 : size.height * 0.15
        preEquationViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        controlsViewHeightConstraint.constant = isLandscape ? size.height * 0.1 : size.height * 0.1
        view.layoutIfNeeded()
//        setupLayout()
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

