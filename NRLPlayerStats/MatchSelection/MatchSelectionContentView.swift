//
//  MatchSelectionContentView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol MatchSelectionContentViewDelegate: class {
    func matchSelectionContentView(_ contentView: MatchSelectionContentView, didSelectMatch match: MatchSelectionViewController.Match)
}

class MatchSelectionContentView: UIView {
    @IBOutlet var roundPicker: UIPickerView! {
        didSet {
            roundPicker.dataSource = self
            roundPicker.delegate = self
        }
    }
    
    @IBOutlet var matchPicker: UIPickerView! {
        didSet {
            matchPicker.dataSource = self
            matchPicker.delegate = self
        }
    }
    
    @IBOutlet private var goButton: UIButton! {
        didSet {
            goButton.layer.cornerRadius = 5
            goButton.layer.masksToBounds = true
        }
    }
    
    weak var delegate: MatchSelectionContentViewDelegate?
    
    private let year: Int = 2017
    private var round: Int = 1
    private var match: Int = 1
    
    @IBAction func go(_ sender: UIButton) {
        let match: MatchSelectionViewController.Match = .init(year: year, round: round, match: self.match)
        delegate?.matchSelectionContentView(self, didSelectMatch: match)
    }
}

extension MatchSelectionContentView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case roundPicker:
            return 26
        case matchPicker:
            return 8
        default:
            return 0
        }
    }
}

extension MatchSelectionContentView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case roundPicker:
            round = row + 1
        case matchPicker:
            match = row + 1
        default:
            break
        }
    }
}

