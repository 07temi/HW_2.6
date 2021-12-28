//
//  ViewController.swift
//  HW_2.6
//
//  Created by Артем Черненко on 24.12.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func updateColor(setColor color: UIColor)
}

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.colorForView = view.backgroundColor
    }
}

extension ViewController: SettingsViewControllerDelegate {
    func updateColor(setColor color: UIColor) {
        view.backgroundColor = color
        
        }
    }



