import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CarPageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let darkPurple = UIColor(red: 17.0/255.0, green: 29.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    let lightPurple = UIColor(red: 48.0/255.0, green: 59.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    let lightPurple1 = UIColor(red: 75.0/255.0, green: 102.0/255.0, blue: 160.0/255.0, alpha: 1.0)
    let middle =  UIColor(red: 90.0/255.0, green: 132.0/255.0, blue: 182.0/255.0, alpha: 1.0)
    let blue1 =  UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 202.0/255.0, alpha: 1.0)
    let darkBlue = UIColor(red: 125.0/255.0, green: 203.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    let userID = Auth.auth().currentUser?.uid
    
    
    
    @IBOutlet weak var makeField: UITextField!
    @IBOutlet weak var modelField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    var makePicker = UIPickerView()
    var modelPicker = UIPickerView()
    var yearPicker = UIPickerView()
    
    let ref = Database.database().reference()
    let rref = fire
    
    let makes = ["Acura", "Alfa Romeo", "Aston Martin", "Audi", "BMW", "Bentley", "Bugatti", "Buick", "Cadillac", "Chevrolet", "Chrysler", "Dodge", "Ferrari", "Fiat", "Ford", "GMC", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Jaguar", "Jeep", "Kia", "Lamborghini", "Land Rover", "Lexus", "Lincoln", "Lotus", "MINI", "Maserati", "Maybach", "Mazda", "Mercedes-Benz", "Mercury", "Mitsubishi", "Nissan", "Oldsmobile", "Peugeot", "Plymouth", "Pontiac", "Porsche", "Ram", "Rolls-Royce", "Roush Performance", "Saab", "Saturn", "Scion", "Spyker", "Subaru", "Suzuki", "Tesla", "Toyota", "Volkswagen", "Volvo", "smart"]

    var models : [String]? = []
    var years : [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newLayer = CAGradientLayer()
        newLayer.colors = [darkPurple.cgColor, lightPurple.cgColor, lightPurple1.cgColor, middle.cgColor  ,blue1.cgColor ,darkBlue.cgColor]
        newLayer.frame = self.view.frame
        view.layer.insertSublayer(newLayer, at: 0)
        
        
        makePicker.delegate = self
        makePicker.dataSource = self
        
        modelPicker.delegate = self
        modelPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self

        makeField.inputView = makePicker
        modelField.inputView = modelPicker
        yearField.inputView = yearPicker
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == makePicker{
            return makes.count
        }
        else if pickerView == modelPicker{
            return models!.count
        }
        else{
            return years!.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == makePicker{
            return makes[row]
        }
        else if pickerView == modelPicker{
            if makeField.text != nil{
                return models![row]
            }
        }
        else{
            if modelField.text != nil{
                return years![row]
            }
            
        }
        return "Temp"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == makePicker{
            var makeText = makes[row]
            var path = "makes".
            
            
            makeField.text = makeText
            makeField.endEditing(true)
            
            modelField.text = nil
            yearField.text = nil
            years? = []
            
            
            years? = []
        }
        else if pickerView == modelPicker{
            var modelString = models![row]
            modelField.text = modelString
            modelField.endEditing(true)
            
            print("I am here!")
            modelString = modelString.replacingOccurrences(of: "/", with: "")
            modelString = modelString.replacingOccurrences(of: ".", with: "")
            
            print(modelString)
            print(modelString.hashValue)
            print(modelString.hash)
            
            if models![row].contains("e"){
                years? = ["butts","grapes","bees"]
            } else {
                years? = ["i","have","no","e's"]
            }
            yearField.text = nil
        }
        else{
            yearField.text = years![row]
            yearField.endEditing(true)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func getPlaceHolderText(text:String) -> NSAttributedString{
        let attrPlaceholder = NSMutableAttributedString(string: text)
        attrPlaceholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, text.count))
        let placholderTxt = NSAttributedString(attributedString: attrPlaceholder)
        return placholderTxt
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CarPageViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.becomeFirstResponder()
        return true
    }
    
    
}
