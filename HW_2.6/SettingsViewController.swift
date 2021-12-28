//
//  SettingsViewController.swift
//  HW_2.6
//
//  Created by Артем Черненко on 24.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redColorSliderTF: UITextField!
    @IBOutlet weak var greenColorSliderTF: UITextField!
    @IBOutlet weak var bluColorSliderTF: UITextField!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var delegate: SettingsViewControllerDelegate!
    var colorForView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 25
        colorView.backgroundColor = colorForView
        setSliderPosition(for: redSlider, greenSlider, blueSlider)
        setValueLB(for: redLabel, greenLabel, blueLabel)
        setValueTF(for: redColorSliderTF, greenColorSliderTF, bluColorSliderTF)
        
    }

    @IBAction func sliderChangeValue(_ sender: UISlider) {
        setViewColor(for: colorView)
        
        switch sender {
        case redSlider:
            setValueLB(for: redLabel)
            setValueTF(for: redColorSliderTF)
        case greenSlider:
            setValueLB(for: greenLabel)
            setValueTF(for: greenColorSliderTF)
        default:
            setValueLB(for: blueLabel)
            setValueTF(for: bluColorSliderTF)
        }
    }
    
    @IBAction func endEditingTF(_ sender: UITextField) {
        guard let stringValue = sender.text else { return }
        guard let floatValue = Float (stringValue) else {
            showMessage(title: "Ошибка", message: "Значение должно быть числовым")
            return
        }
        
        
        switch sender {
        case redColorSliderTF:
            redSlider.setValue(floatValue, animated: true)
            sliderChangeValue(redSlider)
        case greenColorSliderTF:
            greenSlider.setValue(floatValue, animated: true)
            sliderChangeValue(greenSlider)
        default:
            blueSlider.setValue(floatValue, animated: true)
            sliderChangeValue(blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate?.updateColor(setColor: colorView.backgroundColor ?? .red)
        dismiss(animated: true)
    }


    private func setViewColor (for view: UIView) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                       green: CGFloat(greenSlider.value),
                                       blue: CGFloat(blueSlider.value),
                                       alpha: 1)
    }
    
    
    private func setValueLB(for labels: UILabel... ) {
        for label in labels {
            switch label {
            case redLabel:
                label.text = formatString(from: redSlider)
            case greenLabel:
                label.text = formatString(from: greenSlider)
            default:
                label.text = formatString(from: blueSlider)
            }
        }
    }
    
    private func setValueTF(for textFields: UITextField... ) {
        for textField in textFields {
            switch textField {
            case redColorSliderTF:
                textField.text = formatString(from: redSlider)
            case greenColorSliderTF:
                textField.text = formatString(from: greenSlider)
            default:
                textField.text = formatString(from: blueSlider)
            }
        }
    }
    
    private func setSliderPosition(for sliders: UISlider... ){
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        colorForView.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        for slider in sliders {
            switch slider {
            case redSlider:
                slider.setValue(Float(red), animated: false)
            case greenSlider:
                slider.setValue(Float(green), animated: false)
            default:
                slider.setValue(Float(blue), animated: false)
            }
        }
    }
}
//MARK: - Private methods

private func formatString(from slider: UISlider) -> String {
    String(format: "%.2f", slider.value)
}


extension SettingsViewController {
    private func showMessage(title: String, message: String) {
        let message = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        message.addAction(okButton)
        present(message, animated: true)
    }
}
