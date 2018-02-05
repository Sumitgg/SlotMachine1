/*
 * ViewController.swift
 * Project: Assignment 1 - Swift Slot Machine
 * Students:
 *          Sumit Ganju                  300959971
 *          Ling Bao                     300901785
 *          Azeez adefarati Alaba        300971562
 *
 * Date: Feb 05, 2018
 * Version: 0.1
 */

import UIKit
extension String {
    
    // Convert the emojis we copy into a String to a UIImage
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    // OUTLETS
    @IBOutlet weak var winMoney: UILabel!
    @IBOutlet weak var ownMoney: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    var imageArray:[UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
        
        // REEL IMAGES
        imageArray = ["🍎".emojiToImage()!,
                      "😍".emojiToImage()!,
                      "🐮".emojiToImage()!,
                      "🐼".emojiToImage()!,
                      "🐔".emojiToImage()!,
                      "🎅".emojiToImage()!,
                      "🚍".emojiToImage()!,
                      "💖".emojiToImage()!,
                      "👑".emojiToImage()!,
                      "👻".emojiToImage()!]

        resultLabel.text = ""
        winMoney.text = "0"
        ownMoney.text = "5000"
        
        // Function to seed the random number generator
        arc4random_stir()
        pickerView.delegate = self
        pickerView.dataSource = self
    
    }
    

    // ACTIONS
    // The Spin() method executes when the user taps the Spin button
       @IBAction func buttonClicked(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        var winnedMoney = Int(winMoney.text!)!
        var ownnedMoney = Int(ownMoney.text!)!
        if ownnedMoney>0{
        for i in 0..<5{
            let newValue = Int(arc4random_uniform(UInt32(imageArray.count)))
            if newValue == lastVal{
            numInRow += 1
        }else {
            numInRow = 1
        }
        lastVal = newValue
        
            pickerView.selectRow(newValue, inComponent: i, animated: true)
            pickerView.reloadComponent(i)
            ownnedMoney = ownnedMoney - 40
            ownMoney.text = String(ownnedMoney)
            if numInRow >= 3{
                winnedMoney = winnedMoney + 1000
                ownnedMoney = ownnedMoney + 1000
                winMoney.text = String(winnedMoney)
                ownMoney.text = String(ownnedMoney)
                win = true
            }
    }
            
        resultLabel.text = win ? "WINNER!!!!" : ""
        if ownnedMoney == 0{
            resultLabel.text = "You Lose!"
        }
    }
}
    
    // Picker Data Source Methods
    // function which returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return	5
    }
    
    
    // function which returns the number of rows in each component..
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageArray.count
    }
    // Setting the Width of your picker's components
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 32
    }
    
    // Picker Delegate Methods
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 32
    }
    
    // This Method returns one UIImageView object initialized with one of the images for the symbols
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = imageArray[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    

    

    


}

