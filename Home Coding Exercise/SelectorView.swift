
import UIKit

struct SelectorItem {
    
    let id: String
    let title: String
    
}

class SelectorView: UIView {
    
    var items: [SelectorItem] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedItem: SelectorItem? {
        guard self.items.count > 0 else {
            return nil
        }
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        return self.items[selectedRow]
    }
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect.zero)
        self.addSubview(pickerView)
        
        pickerView.layoutInFullSizeOnSuper()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        return pickerView
    }()
    
}

extension SelectorView: UIPickerViewDelegate {
 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].title
    }
    
}

extension SelectorView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
}
