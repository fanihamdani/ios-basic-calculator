//
//  ViewController.swift
//  BasicCalculator
//
//  Created by Fani Hamdani on 06/02/18.
//  Copyright © 2018 Fani Hamdani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        view = CalculatorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

class CalculatorView : UIView {
    
    let textField = UITextField()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
        self.backgroundColor = UIColor.black
        
        textField.backgroundColor = UIColor.lightGray
        textField.font = UIFont(name: "Arial", size: 30)
        textField.frame = CGRect(x: 0, y: 20, width: 500, height: 50)
        
        addSubview(textField)
        addSubview(NumberView(textField, CGRect(x: 0, y: 20 + textField.frame.height, width: self.frame.width, height: 500)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class NumberView : UIView {
    
    let buttonWidth: CGFloat = 100
    let buttonHeight: CGFloat = 100
    
    var textField: UITextField?
    var num1: String = "0", num2: String = ""
    var op: String = ""
    
    init(_ textField: UITextField, _ frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height))
        
        self.backgroundColor = UIColor.white
        self.textField = textField
        
        setupNumberPad()
        setupOperatorPad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButton(_ title: String) -> UIButton {
        
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.white
        b.setTitleColor(UIColor.black, for: .normal)
        b.setTitle(String(title), for: .normal)
        b.layer.borderWidth = 0.5
        b.layer.borderColor = UIColor.darkGray.cgColor
        return b
        
    }
    
    func setupNumberPad() -> Void {
        
        for i: Int in 1...9 {
            let b = createButton(String(i))
            b.frame = CGRect(x: calcXPos(i), y: calcYPos(i), width: buttonWidth, height: buttonHeight)
            b.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
            addSubview(b)
        }
        
        let zero = createButton(String(0))
        zero.frame = CGRect(x: 100, y: 300, width: buttonWidth, height: buttonHeight)
        zero.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
        addSubview(zero)
        
    }
    
    func calcXPos(_ index: Int) -> CGFloat {
        switch (index) {
        case 1, 4, 7:
            return 0
        case 2, 5, 8:
            return 100
        case 3, 6, 9:
            return 200
        default:
            return 0
        }
    }
    
    func calcYPos(_ index: Int) -> CGFloat {
        switch (index) {
        case 1...3:
            return 0
        case 4...6:
            return 100
        case 7...9:
            return 200
        default:
            return 0
        }
    }
    
    func numberButtonPressed(x: UIButton) -> Void {
        num2 = num2.appending(x.currentTitle!)
        textField?.text = num2
    }
    
    func setupOperatorPad() -> Void {
        
        for (i, o) in ["+", "-", "*", "/"].enumerated() {
            let b = createButton(o)
            b.frame = CGRect(x: CGFloat(300), y: CGFloat(i) * 100, width: buttonWidth, height: buttonHeight)
            b.addTarget(self, action: #selector(operatorButtonPressed), for: .touchUpInside)
            addSubview(b)
        }
        
        let equal = createButton("=")
        equal.frame = CGRect(x: 200, y: 300, width: buttonWidth, height: buttonHeight)
        equal.addTarget(self, action: #selector(operatorButtonPressed), for: .touchUpInside)
        addSubview(equal)
        
        let clear = createButton("AC")
        clear.frame = CGRect(x: 0, y: 300, width: buttonWidth, height: buttonHeight)
        clear.addTarget(self, action: #selector(operatorButtonPressed), for: .touchUpInside)
        addSubview(clear)
        
    }
    
    func operatorButtonPressed(x: UIButton) -> Void {
        if num2 != "" {
            switch op {
            case "+":
                num1 = String(Double(num1)?.adding(Double(num2) ?? 0) ?? 0)
            case "-":
                num1 = String(Double(num1)?.subtracting(Double(num2) ?? 0) ?? 0)
            case "*":
                num1 = String(Double(num1)?.multiplied(by: Double(num2) ?? 0) ?? 0)
            case "/":
                num1 = String(Double(num1)?.divided(by: Double(num2) ?? 0) ?? 0)
            case "=":
                break
            default:
                num1 = num2
            }
        }
        if num1 != num2 && op != "" {
            textField?.text = num1
        }
        op = x.currentTitle!
        num2 = ""
        if op == "AC" {
            num1 = "0"
            textField?.text = num1
        }
    }
    
}

