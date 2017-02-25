
import UIKit

class SignatureViewController: UIViewController , YPSignatureDelegate {
    @IBOutlet weak var signView: YPDrawSignatureView!

    var isCustomer : Bool = false;
    
    class func initViewController() -> SignatureViewController {
        let controller = SignatureViewController(nibName: "SignatureViewController", bundle: nil)
        controller.title = "Sign"
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signView.delegate = self
    }

    @IBAction func saveClicked(_ sender: Any) {
        
        if let signatureImage = signView.getSignature(scale: 10) {
            if isCustomer {
                custSign = signatureImage;
            } else {
                driverSign = signatureImage;
            }
            signView.clear()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        self.signView.clear()

    }
    
    // The delegate methods gives feedback to the instanciating class
    func finishedDrawing() {
        print("Finished")
    }
    
    func startedDrawing() {
        print("Started")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
