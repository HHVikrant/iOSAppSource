
import UIKit

class FirstViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {

    let picker = UIImagePickerController()
    var imgArray : NSMutableArray = NSMutableArray()
    
    class func initViewController() -> FirstViewController  {
        let controller = FirstViewController(nibName: "FirstViewController", bundle: nil)
        controller.title = "First"
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreActions))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        let touchPoint = touch .location(in: self.view)
        let fr = CGRect.init(x: touchPoint.x, y: touchPoint.y, width: 100, height: 100)
        let DynamicView = UIView(frame:fr)
        DynamicView.backgroundColor=UIColor.green
        DynamicView.layer.cornerRadius=25
        DynamicView.layer.borderWidth=2
        self.view.addSubview(DynamicView)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController,  didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgArray.add(chosenImage)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController( title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true,   completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
