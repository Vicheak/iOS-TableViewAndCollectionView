//
//  NoteTemplateViewController.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit


class NoteTemplateViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let mainView = UIView()
    let titleTextField = UITextField()
    let detailTextView = UITextView()
    let saveButton = UIButton()
    var bottomConstraint: NSLayoutConstraint!
    
    var keyboardUtil: KeyboardUtil!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = ""
        
        setUpViews()
        
        titleTextField.delegate = self
        detailTextView.delegate = self
        
        keyboardUtil = KeyboardUtil(viewController: self, view: view, bottomConstraint: bottomConstraint)
        keyboardUtil.keyboardNotification()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(sender: UIButton){
   
    }
 
    private func setUpViews(){
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = NSLayoutConstraint(item: view.safeAreaLayoutGuide, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0),
            bottomConstraint,
        ])
        
        scrollView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let mainViewHeightConstraint = NSLayoutConstraint(item: mainView, attribute: .height, relatedBy: .equal, toItem: scrollView.frameLayoutGuide, attribute: .height, multiplier: 1, constant: 0)
        mainViewHeightConstraint.isActive = true
        mainViewHeightConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: mainView, attribute: .top, relatedBy: .equal, toItem: scrollView.contentLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: mainView, attribute: .leading, relatedBy: .equal, toItem: scrollView.contentLayoutGuide, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: scrollView.contentLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: scrollView.contentLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: mainView, attribute: .width, relatedBy: .equal, toItem: scrollView.frameLayoutGuide, attribute: .width, multiplier: 1, constant: 0)
        ])
        
        mainView.addSubview(titleTextField)
        titleTextField.font = UIFont(name: "HelveticaNeue", size: 17)
        titleTextField.placeholder = "Enter note title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleTextField, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: titleTextField, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: titleTextField, attribute: .trailing, multiplier: 1, constant: 10)
        ])
        
        mainView.addSubview(detailTextView)
        detailTextView.font = UIFont(name: "HelveticaNeue", size: 17)
        detailTextView.text = "Enter note detail"
        detailTextView.textColor = .lightGray
        detailTextView.layer.borderWidth = 0.4
        detailTextView.layer.borderColor = UIColor.lightGray.cgColor
        detailTextView.layer.cornerRadius = 5
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: detailTextView, attribute: .top, relatedBy: .equal, toItem: titleTextField, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: detailTextView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: mainView, attribute: .trailing, relatedBy: .equal, toItem: detailTextView, attribute: .trailing, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: detailTextView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        ])
        
        mainView.addSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: saveButton, attribute: .top, relatedBy: .equal, toItem: detailTextView, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainView, attribute: .bottom, relatedBy: .equal, toItem: saveButton, attribute: .bottom, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: saveButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: saveButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        ])
        
        let tapGuestureRecognizer = UITapGestureRecognizer()
        mainView.addGestureRecognizer(tapGuestureRecognizer)
        tapGuestureRecognizer.addTarget(self, action: #selector(viewEndEdit))
    }
    
    @objc func viewEndEdit(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let previousTraitCollection = previousTraitCollection else { return }
        
        if previousTraitCollection.verticalSizeClass == .regular &&
            previousTraitCollection.horizontalSizeClass == .compact {
            //portrait
        } else if previousTraitCollection.verticalSizeClass == .compact &&
                    previousTraitCollection.horizontalSizeClass == .regular {
            //landscape iPhone 15 pro max
        } else if previousTraitCollection.verticalSizeClass == .compact &&
                    previousTraitCollection.horizontalSizeClass == .compact {
            //landscape iPhone 15 and iPhone SE series
        } else {
            //iPad trait
        }
    }
    
}

extension NoteTemplateViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            detailTextView.becomeFirstResponder()
        }
        return true
    }
   
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter note detail" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
}
