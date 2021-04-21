import AVFoundation
import UIKit
import Contacts

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var backButtonTap: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("scan")
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        view.bringSubviewToFront(backButtonTap)
        
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
            
            
        }
        
        //dismiss(animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        print("backTap")
        _ = navigationController?.popViewController(animated: true)

    }
    func saveVCardContacts (vCard : Data) { // assuming you have alreade permission to acces contacts
        
        if #available(iOS 9.0, *) {
            
            let contactStore = CNContactStore()
            
            do {
                
                let saveRequest = CNSaveRequest() // create saveRequests
                
                let contacts = try CNContactVCardSerialization.contacts(with: vCard) // get contacts array from vCard
                
                //  for person in contacts{
                let person = contacts.first
                print("person")
                print(person as Any)
                
                
                let mutableContact = person?.mutableCopy() as! CNMutableContact
                
                saveRequest.add(mutableContact, toContainerWithIdentifier: nil)
                
                
                
                
                try contactStore.execute(saveRequest) // save to contacts
                
                
                
                
                
                
            } catch  {
                
                print("Unable to show the new contact") // something went wrong
                
            }
            
        }else{
            
            print("CNContact not supported.") //
            
        }
        
        
        
    }
    
    
    
    
    func found(code: String) {
        print(code)
        if let data = code.data(using: .utf8) {
            
            
            
            
            // create the alert
            let alert = UIAlertController(title: "Add Contact", message: "Do you want to save Contact Details...", preferredStyle: UIAlertController.Style.alert)
            
            
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
                self.saveVCardContacts (vCard : data)
                
                print("person name1 ")
                
                
                
                
                
                let alert = UIAlertController(title: "Add Contact", message: "Contact Save Successfully.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    
                    self.dismiss(animated: true)
                    
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { action in
                
                self.dismiss(animated: true)
                
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
            
            do {
                let contacts = try CNContactVCardSerialization.contacts(with: data)
                let contact = contacts.first
                print("\(String(describing: contact?.familyName))")
                
            } catch {
                return
            }
            
            
            
            
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


