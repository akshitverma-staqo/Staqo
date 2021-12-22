//
//  ImagePicker.swift
//  Staqo
//
//  Created by SHAILY on 10/04/21.


import Foundation
import AVFoundation
import Photos
import UIKit

protocol ImagePickerDelegate: class {
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker ,imageName:String , btn:UIButton)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

class ImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil
    var btn:UIButton!
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType , sender:UIButton) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        btn = sender
        DispatchQueue.main.async {

           
            if #available(iOS 13.0, *) {
              // self.controller!.isModalInPresentation = true
                self.controller!.modalPresentationStyle = .fullScreen
            } else {
                // Fallback on earlier versions
            }
        viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }

}

extension ImagePicker {
    
    private func showAlert(targetName: String, completion: @escaping (Bool)->()) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                message: "Please provide access to your \(targetName)",
                preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingsUrl) else { completion(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) {
                    [weak self] _ in self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion(false) }))
            UIApplication.shared.delegate?.window??.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func cameraAsscessRequest() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            delegate?.imagePickerDelegate(canUseCamera: true, delegatedForm: self)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.delegate?.imagePickerDelegate(canUseCamera: granted, delegatedForm: self)
                } else {
                    self.showAlert(targetName: "camera") { self.delegate?.imagePickerDelegate(canUseCamera: $0, delegatedForm: self) }
                }
            }
        }
    }
    
    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePickerDelegate(canUseGallery: result == .authorized, delegatedForm: self)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePickerDelegate(canUseCamera: $0, delegatedForm: self) }
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
             print ( info[.phAsset].debugDescription )
            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self , imageName:fileUrl.lastPathComponent, btn:btn)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
          print ( info[.phAsset].debugDescription )
            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
                  print(fileUrl.lastPathComponent)
            delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self , imageName:fileUrl.lastPathComponent, btn:btn)
        } else {
            print("Other source")
        }
        
      
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }
}
