//
//  SettingsViewController.swift
//  HW_2.6
//
//  Created by Артем Черненко on 24.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redColorSliderValueTF: UITextField!
    @IBOutlet weak var greenColorSliderTF: UITextField!
    @IBOutlet weak var bluColorSliderTF: UITextField!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var settingsColor: (CGFloat, CGFloat, CGFloat) = (0, 0, 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 25
        setViewColor(for: colorView)
        setValue(for: redLabel, greenLabel, blueLabel)
    }

    @IBAction func sliderChangeValue(_ sender: UISlider) {
        setViewColor(for: colorView)
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
        case greenSlider:
            setValue(for: greenLabel)
        default:
            setValue(for: blueLabel)
        }
    }

    private func setViewColor (for view: UIView) {
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                       green: CGFloat(greenSlider.value),
                                       blue: CGFloat(blueSlider.value),
                                       alpha: 1)
    }
    
    
    private func setValue(for labels: UIView... ) {
        for label in labels {
            guard let result = label as? UILabel else { return }
            switch result {
            case redLabel:
                result.text = formatString(from: redSlider)
            case greenLabel:
                result.text = formatString(from: greenSlider)
            default:
                result.text = formatString(from: blueSlider)
            }
            
        }
    }
        
    
    @IBAction func endEditingTF(_ sender: UITextField) {
        guard let stringValue = sender.text else { return }
        guard let floatValue = Float (stringValue) else { return }
        
        switch sender {
        case redColorSliderValueTF:
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
    
}



//MARK: - Private methods

private func getColorValue(forSlider sender: UISlider, FloatValue value: Float) -> CGFloat {
    switch sender.tag {
    case 1:
        return (CGFloat(sender.value))
    case 2:
        return (CGFloat(sender.value))
    default:
        return (CGFloat(sender.value))
    }
}

private func formatString(from slider: UISlider) -> String {
    String(format: "%.2f", slider.value)
}


