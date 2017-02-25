
import UIKit

class CarrierViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var carView: UIView!
    @IBOutlet weak var tblViewMain: UITableView!
    @IBOutlet weak var btnSeePhotos: UIButton!

    @IBOutlet weak var driverSignView: UIImageView!
    @IBOutlet weak var custSignView: UIImageView!

    
    let picker = UIImagePickerController()
    var touchPoint : CGPoint = CGPoint()

    class func initViewController() -> CarrierViewController  {
        let controller = CarrierViewController(nibName: "CarrierViewController", bundle: nil)
        controller.title = "Carrier"
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewMain.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblViewMain.tableFooterView = UIView()
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
//        if driverSign != nil {
            driverSignView.image = driverSign
//        }
        
//        if custSign != nil {
            custSignView.image = custSign;
//        }
        
        tblViewMain.layer.borderWidth = 10
        tblViewMain.layer.borderColor =  UIColor.init(colorLiteralRed: 0.6235, green: 0.419, blue: 0.874, alpha: 1).cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreActions))
        tap.numberOfTapsRequired = 1
        carView.addGestureRecognizer(tap)
    }

    @IBAction func seePhotosClicked(_ sender: Any) {
        let controller = PhotosViewController.initViewController()
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        for viewA in carView.subviews {
            if viewA.tag != 1 {
                viewA.removeFromSuperview()
            }
        }
    }
    
    
    @IBAction func addPhotosClicked(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgArray.add(chosenImage)
        let aString = "See Photos \((imgArray.count))"
        btnSeePhotos.setTitle(aString, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController( title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction( title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present( alertVC, animated: true,   completion: nil)
    }
    
    
    func showMoreActions(touch: UITapGestureRecognizer) {
        touchPoint = touch .location(in: carView)
        tblViewMain.isHidden = false;
    }
    
    //TableViewDelegate DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tblViewMain.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = "S - Scratched";
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "D - Dent";
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "CR - Cracked";
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "PC - Paint Chip";
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "R - Rubbed";
        }
        cell.selectionStyle = .none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblViewMain.isHidden = true;
        let fr = CGRect.init(x: touchPoint.x-10, y: touchPoint.y-10, width: 30, height: 30)
        let DynamicView = UIView(frame:fr)
        DynamicView.backgroundColor=UIColor.green
        DynamicView.layer.cornerRadius=DynamicView.layer.frame.size.width / 2;
        DynamicView.layer.borderWidth=2
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.textAlignment = .center
        if indexPath.row == 0 {
            label.text = "S";
            damagesArray.add("Scratched")
        } else if indexPath.row == 1 {
            label.text = "D"
            damagesArray.add("Dent")
        } else if indexPath.row == 2 {
            label.text = "CR"
            damagesArray.add("Cracked")
        } else if indexPath.row == 3 {
            label.text = "PC"
            damagesArray.add("Pain Chip")
        } else if indexPath.row == 4 {
            label.text = "R"
            damagesArray.add("Rubbed")
        }
        DynamicView.addSubview(label)
        carView.addSubview(DynamicView)
    }
        
    @IBAction func signCustClicked(_ sender: Any) {
        let controller = SignatureViewController.initViewController()
        controller.isCustomer = true;
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signDriverClicked(_ sender: Any) {
        let controller = SignatureViewController.initViewController()
        controller.isCustomer = false;
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
