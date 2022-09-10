//
//  DatePickerView.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import UIKit

protocol DatePickerDelegate: NSObjectProtocol {
    func doneButtonTapped(date: Date)
}

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    private let identifier = "DatePickerView"
    var contentView:UIView?
    weak var delegate: DatePickerDelegate?
    
    // MARK: Init Methods
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // MARK: Private Methods
    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        datePicker.maximumDate = Date()
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: identifier, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: Action DatePickerDelegate
    @IBAction func cancelButtonTapped(_ sender: Any) {
        isHidden = true
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        isHidden = true
        delegate?.doneButtonTapped(date: datePicker.date)
    }
}
