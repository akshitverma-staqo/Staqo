//
//  BusinessVC.swift
//  Staqo
//
//  Created by SHAILY on 06/03/21.
//

import UIKit
import VisionKit
import Vision

class BusinessVC: BaseVC {
    let ocr = CognitiveServices.sharedInstance.ocr
    
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var scanBtnOutlet: UIButton!
    @IBOutlet weak var businessBtnOutlet: UIButton!
    @IBOutlet weak var searchShadowView: UIView!
    @IBOutlet weak var scanShadowView: UIView!
    @IBOutlet weak var businessShadowView: UIView!
    
    var viewModal: BusinessViewModal!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        businessShadowView.dropShadow()
        scanShadowView.dropShadow()
        searchShadowView.dropShadow()
        businessBtnOutlet.layer.cornerRadius = 11
        searchBtnOutlet.layer.cornerRadius = 11
        scanBtnOutlet.layer.cornerRadius = 11
        businessBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        searchBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        scanBtnOutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        self.navigationController?.isNavigationBarHidden = true
        viewModal = BusinessViewModal(dataSource: BusinessDataSource())
        viewModal.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSVTapped(_ sender: UIButton) {
        let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kBusinessCardVC, type: BusinessCardVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBCVTapped(_ sender: UIButton) {
        let vc = VNDocumentCameraViewController()
        vc.navigationController?.setNavigationBarHidden(true, animated: false)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
       // present(documentCameraViewController, animated: true)
        
    }
    @IBAction func btnSVCTapped(_ sender: UIButton) {
        let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kVisitorListVC, type: VisitorListVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: true)
    }
   
    func processImage(image: UIImage) {
        guard let cgImage = image.cgImage else {
            
            print("Failed to get cgimage from input image")
            return
        }
        
        //       let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        //        do {
        //            try handler.perform([textRecognitionRequest])
        
        let image = UIImage(cgImage: cgImage).jpegData(compressionQuality: 0.7)
        print("imageselect field")
        print(image as Any)
        startLoader()
        let requestObject: OCRRequestObject = (resource: image as Any, language: .Automatic, detectOrientation: true)
        print("urlField1")
        do { try ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            if (response != nil){
                print("urlField2")
                let text = self.ocr.extractStringFromDictionary(response!)
                print("This is Text" + text)
                
                //self.resultTextView.text = text
                print("urlField3")
                //self.scannedText = text
                
                DispatchQueue.main.async {
                    self.viewModal.getTextReader(value:text)
                }
                
            }
        })
        
        }catch let error {
            print(error)
        }
    }
}
extension BusinessVC: ViewModelDelegate{
    func willLoadData() {
        startLoader()
    }
    
    func didLoadData() {
        dismiss(animated: true, completion: nil)
        let vc = Constant.getViewController(storyboard: Constant.kBusinessStoryboard, identifier: Constant.kVisitingCardDataVC, type: VisitingCardData.self)
        vc.docData = viewModal.docData
        self.navigationController?.pushViewController(vc, animated: true)
        stopLoader()
    }
    
    func didFail(error: CustomError) {
        
        showErrorMessage(title: "Error", error: error) { (action) in
            if error.localizedDescription.contains("401 Unauthorized") {
                print("401")
                self.showMessage(title: "", message: CustomError.Logout.localizedDescription, btnConfirmTitle:"YES", btnCancelTitle: "NO") { (isYes, action) in
                    if isYes {
                        let vc = Constant.getViewController(storyboard: Constant.kMainStoryboard, identifier: Constant.kLoginVC, type: LoginVC.self)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
           
        }
        stopLoader()
    }
    
    
}
extension BusinessVC: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
      startLoader()
        //self.activityIndicator.startAnimating()
        controller.dismiss(animated: true) {
            DispatchQueue.global(qos: .userInitiated).async {
                for pageNumber in 0 ..< scan.pageCount {
                    let image = scan.imageOfPage(at: pageNumber)
                    self.processImage(image: image)
                    
                }
                
                
            }
        }
    }
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        self.navigationController?.popViewController(animated: true)
    }
}

