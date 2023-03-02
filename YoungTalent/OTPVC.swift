//
//  OTPVC.swift
//  YoungTalent
//
//  Created by admin on 1.03.2023.
//

import UIKit

class OTPVC: UIViewController{
    //MARK: - Properties
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextFields()
    }
    
    //MARK: - Handlers
    func setupTextFields(){
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        textField1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func setupView(){
        // keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        // backButton for navigationController
        let backButton = UIButton(frame: .init(x: 30, y: 50, width: 20, height: 60))
        backButton.setBackgroundImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor(named: "Blue-Dark")
        backButton.contentMode = .scaleToFill
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc func handleBackButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard(){
        textField1.endEditing(true)
        textField2.endEditing(true)
        textField3.endEditing(true)
        textField4.endEditing(true)
    }
    @objc func textDidChange(_ textField: UITextField){
        
        if textField.text!.count == 1{
            switch textField{
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField4.resignFirstResponder()
            default:
                break
            }
        }else{
            switch textField{
            case textField4:
                textField3.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField1:
                textField1.resignFirstResponder()
            default:
                break
            }
        }
    }
}

//MARK: - TextFieldDelegate
extension OTPVC: UITextFieldDelegate{
    
    
}
