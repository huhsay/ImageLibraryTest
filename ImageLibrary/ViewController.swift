//
//  ViewController.swift
//  ImageLibrary
//
//  Created by theodore on 2022/02/27.
//

import UIKit
import SDWebImage
import Kingfisher
import Alamofire
import AlamofireImage
import ImageIO

class ViewController: UIViewController {
  
  var imageView : UIImageView? = UIImageView()
  @IBOutlet weak var closeButton: UIButton!
  var imageURLString = "https://pbs.twimg.com/media/Ex0biHtVIAQ-c56?format=jpg&name=large"
  var imageURL = URL(string: "https://pbs.twimg.com/media/Ex0biHtVIAQ-c56?format=jpg&name=large")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    closeButton.isHidden = true
  }
  
  @IBAction func kingfisherButtonDidTap(_ sender: Any) {
    addNewImageView()
    
    // 이미지 다운샘플링 하는 옵션
    let processor = DownsamplingImageProcessor(size: view.bounds.size)
    
    self.imageView?.kf.setImage(with: self.imageURL,
                                placeholder: nil,
                                options: [.processor(processor)],
                                completionHandler: nil)
  }
  
  @IBAction func sdImageWebView(_ sender: Any) {
    addNewImageView()
    
    imageView?.sd_setImage(with: imageURL, completed: nil)
  }
  
  @IBAction func alamofireButtonDidTap(_ sender: Any) {
    addNewImageView()
    
    AF.request(imageURLString).responseImage { response in
      debugPrint(response)

      print(response.request)
      print(response.response)
      debugPrint(response.result)

        if case .success(let image) = response.result {
          self.imageView?.image = image
        }
    }
  }
  
  @IBAction func nativeButtonDidTap(_ sender: Any) {
    addNewImageView()
    
    // let data = try? Data(contentsOf: imageURL!)
    // var image = UIImage(data: data!)
    
    // 이미지 리사이징
//    let imageSize = image?.size
//    let scale = 0.2
//    let size = CGSize(width: image!.size.width * scale, height: image!.size.height * scale)
//    let renderer = UIGraphicsImageRenderer(size: size)
//    let resizedImage = renderer.image { context in
//      image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//    }
    
    // ImagaeIO를 활용한 리사이징
    let imageSource = CGImageSourceCreateWithURL(imageURL! as CFURL, nil)
    let properties = CGImageSourceCopyPropertiesAtIndex(imageSource!, 0, nil)
    let options: [NSString: Any] = [
      kCGImageSourceThumbnailMaxPixelSize: 500,
      kCGImageSourceCreateThumbnailFromImageAlways: true
    ]

    let image2 = UIImage(cgImage: CGImageSourceCreateThumbnailAtIndex(imageSource!, 0, options as CFDictionary)!)
    
    if let currentImageView = imageView {
      currentImageView.image = image2
    }
  }
  
  @IBAction func closeButtonDidTap(_ sender: Any) {
    let subview = view.viewWithTag(1)
    imageView = nil
    subview?.removeFromSuperview()
    closeButton.isHidden = true
    
    //clear cash
    ImageCache.default.clearMemoryCache()
    SDImageCache.shared.clearMemory()
    AutoPurgingImageCache().removeAllImages()
  }
  
  func addNewImageView(handler: @escaping () -> Void) {
    
    if (imageView == nil) {
      imageView = UIImageView()
    }
    
    updateImageViewConstraint(handler: handler)
  }
  
  func updateImageViewConstraint(handler: @escaping () -> Void) {
    self.view.addSubview(imageView!)
    
    imageView?.translatesAutoresizingMaskIntoConstraints = false
    imageView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    imageView?.tag = 1
    
    
    closeButton.isHidden = false
    view.bringSubviewToFront(closeButton)
    
    handler()
  }
  
  func addNewImageView()
  {
    if (imageView == nil) {
      imageView = UIImageView()
    }
    
    updateImageViewConstraint()
  }
  
  func updateImageViewConstraint()
  {
    self.view.addSubview(imageView!)
    
    imageView?.translatesAutoresizingMaskIntoConstraints = false
    imageView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    imageView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    imageView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    imageView?.tag = 1
    
    
    closeButton.isHidden = false
    view.bringSubviewToFront(closeButton)
  }
  
  @IBAction func imageButtonDidTap(_ sender: Any) {
    
    if let button = sender as? UIButton {
      switch (button.tag) {
      case 100 :
        imageURLString = "https://user-images.githubusercontent.com/24218456/156476812-a650e721-ff88-4595-bf3e-6a0ce95d89cf.jpg"
        imageURL = URL(string: imageURLString)
      case 101 :
        imageURLString = "https://user-images.githubusercontent.com/24218456/156476808-94373374-8644-47cc-8527-c60990f293f8.jpg"
        imageURL = URL(string: imageURLString)
      case 102 :
        imageURLString = "https://user-images.githubusercontent.com/24218456/156476806-465eaf08-e073-4d7e-a358-5d721b072f8c.jpg"
        imageURL = URL(string: imageURLString)
      default:
        imageURLString = "https://pbs.twimg.com/media/Ex0biHtVIAQ-c56?format=jpg&name=large"
        imageURL = URL(string: imageURLString)
      }
    }
  }
}

