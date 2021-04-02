//
//  OCRViewController.swift
//  CognitiveServices
//
//  Created by Vladimir Danila on 5/13/16.
//  Copyright © 2016 Vladimir Danila. All rights reserved.
//

import UIKit

class OCRViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    let ocr = CognitiveServices.sharedInstance.ocr

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        urlTextField.text = ""
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func textFromUrlDidPush(_ sender: UIButton) {
        
        print("urlField")
        let requestObject: OCRRequestObject = (resource: urlTextField.text!, language: .Automatic, detectOrientation: true)
        print("urlField1")
        do{try ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            if (response != nil){
                print("urlField2")
                let text = self.ocr.extractStringFromDictionary(response!)
                self.resultTextView.text = text
                print(text)
                print("text")
            }
        })}catch{
            print(Error.self)
        
        }
    }
 
    @IBAction func textFromImageDidPush(_ sender: UIButton) {
        print("imageselect field")
        let requestObject: OCRRequestObject = (resource: UIImage(named: "ocrDemo")!.pngData()!, language: .Automatic, detectOrientation: true)
        print("urlField1")
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            if (response != nil){
                print("urlField2")
                let text = self.ocr.extractStringFromDictionary(response!)
                self.resultTextView.text = text
                print("urlField3")
            }
        })

    }

    

}
