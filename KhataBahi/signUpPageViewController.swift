//
//  signUpPageViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/27/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import Photos

class signUpPageViewController: UIViewController,UINavigationControllerDelegate,XMLParserDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var buttonCountrySelect: UIButton!
    var picker1:UIImagePickerController? = UIImagePickerController()
    var popover1: UIPopoverController? = nil
    var countries1:[countries]=[]
    var states123:[states]=[]
    var ename:String=String()
    var countryId:String=String()
    var globalCountryId:String=String()
    var countryName:String=String()
    var stateId:String=String()
    var stateIds:[String]=[String]()
    var stateNames:[String]=[String]()
    var stateName:String=String()
    var countryNames=[String]()
    var countryIds=[String]()
    var imageView:UIImage!
    var selection:Int=0
    var selectStateCondition=0
    @IBOutlet weak var countryTableView: UITableView!
    
    var globalCompanyName=String()
    var globalImageString=String()
    var globalEmailID=String()
    var globalSetPassword=String()
    var globalMobileNumber=String()
    var globalLandLineNumber=String()
    var globalPostalAddress=String()
    var globalCountryName=String()
    var globalStateName=String()
    var globalCityname=String()
    var globalGSTINNo=String()
    var base64String=String()
    var imageView1:UIImageView!
   /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // save your image here into Document Directory
        saveImage(tempImage, path: fileInDocumentsDirectory("tempImage"))
        
    }
   // Here is the helper functions:
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData.writeToFile(path, atomically: true)
        
        return result
        
    }
    
    // Get the documents Directory
    
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        return documentsFolderPath
    }
    // Get path for a file in the directory
    
    func fileInDocumentsDirectory(filename: String) -> String {
        return documentsDirectory().stringByAppendingPathComponent(filename)
    }
    And this way you can retrieve that image from Document Directory:
 
    @IBAction func setImage(sender: AnyObject) {
        
        imageV.image = loadImageFromPath(fileInDocumentsDirectory("tempImage"))
    }
    //And here is the helper function:
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            println("missing image at: (path)")
        }
        println("\(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.separatorStyle = .none
        stateTableView.separatorStyle = .none
        buttonCountrySelect.backgroundColor=UIColor.white
        countryTableView.isHidden=true
        // Do any additional setup after loading the view.
        stateTableView.isHidden=true
        companyNameText.delegate=self
        emailIdText.delegate=self
        setPassword.delegate=self
        mobileNo.delegate=self
        landlineNo.delegate=self
        postalAddress.delegate=self
        cityNameText.delegate=self
        
        gettingCountryList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
  /*  @IBAction func ChoosePic(_ sender: UIButton) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
            
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
        }
        
        // Add the actions
        picker1?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        picker1?.modalPresentationStyle = .popover
        //picker1?.popoverPresentationController?.butt=sender
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            popover1 = UIPopoverController(contentViewController: alert)
            
        }
        
        
        
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
       /* print(info)
        guard let imageId = info["UIImagePickerControllerReferenceURL"] else {
            return
        }
        print(imageId,"******************************")*/
        
        
        let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
        let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
        let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
       
        base64String=trimmedString
         print("******\(base64String)**********")
        self.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker1!.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker1!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    func openGallary()
    {
        picker1!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(picker1!, animated: true, completion: nil)
        }
        else
        {
            popover1 = UIPopoverController(contentViewController: picker1!)
            
        }
    }
    
    @IBAction func chooseCountry(_ sender: UIButton) {
        if countryTableView.isHidden == true
        {
            countryTableView.isHidden=false
        }
        else{
            countryTableView.isHidden=true
        }
    }
    
    
    
    func gettingCountryList()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCountriesArray xmlns=\"http://tempuri.org/\"><SecurityKey>#111000$</SecurityKey></GetCountriesArray></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = "http://sale.khatabahi.com/SBNaradService.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("sale.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetCountriesArray", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            DispatchQueue.main.async {
                //self.countryTableView.delegate=self as! UITableViewDelegate
                //self.countryTableView.dataSource=self as! UITableViewDataSource
                self.countryTableView.reloadData()
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
    }
    func gettingStateList()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStatesArray xmlns=\"http://tempuri.org/\"><CountryID>\(globalCountryId)</CountryID><SecurityKey>#111000$</SecurityKey></GetStatesArray></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = "http://sale.khatabahi.com/SBNaradService.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("sale.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetStatesArray", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            DispatchQueue.main.async {
                //self.countryTableView.delegate=self as! UITableViewDelegate
                //self.countryTableView.dataSource=self as! UITableViewDataSource
                self.stateTableView.reloadData()
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
    }
    func generateOTP()
    {UserDefaults.standard.set(globalMobileNumber, forKey: "mobileNumberForOTP")
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GenerateOTP xmlns=\"http://tempuri.org/\"><Mobile>\(globalMobileNumber)</Mobile><SecurityKey>KBRE@#4321</SecurityKey></GenerateOTP></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = "http://wservice.khatabahi.online/WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.khatabahi.online", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GenerateOTP", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
    }
    var elementValue: String?
    var status:String!
    var otpResult:String!
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        ename=elementName
        if elementName == "GetCountriesArrayResult" {
            countryId=String()
            countryName=String()
            selection=0
            
        }
        if elementName == "GetStatesArrayResult" {
            stateId=String()
            stateName=String()
            selection=1
            
            
        }
        if elementName == "CreateNewCompanyResult"
        {
            status=String()
            selection = 2        }
        if elementName == "GenerateOTPResult"
        {
            otpResult=String()
            selection = 3        }
        
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        var data=string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) && selection==0{
            
            if ename == "CountryID" {
                countryId += data
                print(countryId)
              countryIds.append(data)
                
            } else if ename == "CountryName" {
                countryName += data
                print(countryName)
                countryNames.append(data)
            }
            
        }
        if (!data.isEmpty) && selection==1{
            
            if ename == "StateID" {
                stateId += data
                print(countryId)
                stateIds.append(data)
                
            } else if ename == "StateName" {
                countryName += data
                print(countryName)
                stateNames.append(data)
            }
            
        }
        if (!data.isEmpty) && selection==2{
            
            status=string
            print(status!,"BVSP ROCK *************************")
        
            
            
            
            DispatchQueue.main.async {
                if self.status! == "1"
                {
                    UserDefaults.standard.set(self.globalEmailID, forKey: "loginUsername")
                     UserDefaults.standard.set(self.globalSetPassword, forKey: "loginPassword")
                  //  UserDefaults.standard.set(nil, forKey: "logoutStatus")
                   /* var oKaction:Int=7
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
Your are Succcessfully
Completed Sign Up!
Welcome To Khata Bahi! .....
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                     
                    */
                    /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "login") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)*/
                    self.generateOTP()
                    
                }
                else
                {
                    
                    
                    DispatchQueue.main.async {
                        self.imageView1.isHidden=true
                    }
                    
                    
                    
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
\(self.status!)
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
            
            
        }
        if (!data.isEmpty) && selection==3{
            
            otpResult=string
            print(otpResult)
            DispatchQueue.main.async {
                self.imageView1.isHidden=true
            }
            
            
            
            
            DispatchQueue.main.async {
                if self.otpResult! == "1"
                {
                   /* UserDefaults.standard.set(self.globalEmailID, forKey: "loginUsername")
                    UserDefaults.standard.set(self.globalSetPassword, forKey: "loginPassword")
                    UserDefaults.standard.set(nil, forKey: "logoutStatus")*/
                    /* var oKaction:Int=7
                     UserDefaults.standard.set(oKaction, forKey: "oKaction")
                     var messageDescription="""
                     Your are Succcessfully
                     Completed Sign Up!
                     Welcome To Khata Bahi! .....
                     """
                     UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                     self.present(vc, animated: true, completion: nil)
                     
                     */
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "OTP") as! UIViewController
                     UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                   
                    
                }
                else
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
                    \(self.otpResult!)
                    """
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
            
            
        }
        
        
        
        
    }
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "GetCountriesArrayResult" {
               
                    
                    let book = countries()
                    book.countryId = countryId
                    book.countryName = countryName
                    
                    countries1.append(book)
                print(countries1)
                selection=0
            }
            if elementName == "GetStatesArrayResult" {
                
                let book = states()
                book.stateId = stateId
                book.stateName = stateName
                
                states123.append(book)
                print(states123)
                
                selection=1
            }
            if elementName == "CreateNewCompanyResult"
            {
                status=String()
                selection = 2        }
            if elementName == "GenerateOTPResult"
            {
                otpResult=String()
                selection = 3        }
        }
        
        func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
            print("parseErrorOccurred: \(parseError)")
        }
        
    @IBOutlet weak var stateSelectButtonLabel: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==countryTableView
        {
        return countryIds.count
        }
        else
        {print(stateIds.count,"***********")
            return stateIds.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==countryTableView
        {
    let cell=countryTableView.dequeueReusableCell(withIdentifier: "cell")
   
        cell!.textLabel?.text = countryNames[indexPath.row]
  
        return cell!
    
        }
        else
        {
            let cell=stateTableView.dequeueReusableCell(withIdentifier: "cell")
            cell!.textLabel?.text=stateNames[indexPath.row]
             return cell!
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView ==  countryTableView
        {
        buttonCountrySelect.setTitle("\(countryNames[indexPath.row])", for: .normal)
        globalCountryId=countryIds[indexPath.row]
        countryTableView.isHidden=true
        selectStateCondition=1
            stateSelectButtonLabel.setTitle("Select State", for: .normal)
        gettingStateList()
        }
        else
        { stateSelectButtonLabel.setTitle("\(stateNames[indexPath.row])", for: .normal)
           
            stateTableView.isHidden=true
           
            
        }
    }
    
    @IBOutlet weak var companyNameText: UITextField!
    @IBOutlet weak var stateTableView: UITableView!
    
    @IBOutlet weak var emailIdText: UITextField!
    
    @IBOutlet weak var setPassword: UITextField!
    
    
    @IBOutlet weak var mobileNo: UITextField!
    
    @IBOutlet weak var landlineNo: UITextField!
    
    @IBOutlet weak var postalAddress: UITextField!
    
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var cityNameText: UITextField!
    
    
    @IBOutlet weak var GSTIN: UITextField!
    
    @IBAction func stateSelect(_ sender: UIButton) {

        if selectStateCondition == 1
        {
        if stateTableView.isHidden == true
        {
            stateTableView.isHidden=false
        }
        else{
            stateTableView.isHidden=true
        }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        companyNameText.resignFirstResponder()
        emailIdText.resignFirstResponder()
        setPassword.resignFirstResponder()
        mobileNo.resignFirstResponder()
        landlineNo.resignFirstResponder()
        postalAddress.resignFirstResponder()
        cityNameText.resignFirstResponder()
        
        return true
    }
    
   
    @IBAction func signUp(_ sender: UIButton) {
        
        globalCompanyName=self.companyNameText.text!
        globalEmailID=self.emailIdText.text!
        globalSetPassword=self.setPassword.text!
        globalMobileNumber=self.mobileNo.text!
        globalLandLineNumber=self.landlineNo.text!
        globalPostalAddress=self.postalAddress.text!
        globalCountryName=(self.buttonCountrySelect.titleLabel?.text)!
        print(globalCountryName)
        if self.stateSelectButtonLabel.titleLabel?.text != nil
        {
        globalStateName=(self.stateSelectButtonLabel.titleLabel?.text)!
        }
        globalCityname=self.cityNameText.text!
       
        
         let valid = validateEmail(candidate: globalEmailID as String)
        if globalCompanyName.isEmpty==true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter Company name
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
       /* if base64String.isEmpty==true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Choose Your Profile Picture
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }*/
       else if valid != true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter Valid Email ID
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
       else if globalSetPassword.isEmpty==true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter The Password
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
       else if globalMobileNumber.isEmpty==true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter The Mobile Number
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else if globalMobileNumber.count != 10
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
 Mobile Number should be 10 digits
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
       else if globalPostalAddress.isEmpty==true
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter The Postal Address
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
      else if globalCountryName.isEmpty==true || globalCountryName == "     Select Country" || globalCountryName == "Select Country"
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Select Country
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
       else if globalStateName.isEmpty==true || globalStateName == "Select State"
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Select State
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            
            let jeremyGif = UIImage.gifImageWithName("abc1234")
            imageView1 = UIImageView(image: jeremyGif)
            
            imageView1.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
            self.view.addSubview(imageView1)
            //createNewCompany()
            setValuesForCreateCompany()
            self.generateOTP()
        }
    }
    
    func createNewCompany(){
        UserDefaults.standard.set(globalMobileNumber, forKey: "mobileNumberForOTP")
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CreateNewCompany xmlns=\"http://tempuri.org/\"><CompanyName>\(globalCompanyName)</CompanyName><TelephoneNo>\(globalLandLineNumber)</TelephoneNo><Address>\(globalPostalAddress)</Address><Country>\(globalCountryName)</Country><State>\(globalStateName)</State><City>\(globalCityname)</City><Email>\(globalEmailID)</Email><Mobile>\(globalMobileNumber)</Mobile><GSTIN></GSTIN><pass>\(globalSetPassword)</pass><Logo_str></Logo_str><SecurityKey>KBRE@#4321</SecurityKey></CreateNewCompany></soap:Body></soap:Envelope>"
        let is_URL: String = "http://wservice.khatabahi.online/WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        
        lobj_Request.addValue("wservice.khatabahi.online", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/CreateNewCompany", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if response != nil
            {
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                //XMLparser.shouldResolveExternalEntities = true
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                    
                }
            }
        })
        task.resume()
    }
    func setValuesForCreateCompany()
    {
         UserDefaults.standard.set(globalMobileNumber, forKey: "mobileNumberForOTP")
        let globalValues:String="\(globalCompanyName)^\(globalLandLineNumber)^\(globalPostalAddress)^\(globalCountryName)^\(globalStateName)^\(globalCityname)^\(globalEmailID)^\(globalMobileNumber)^\(globalSetPassword)"
        print(globalValues)
        UserDefaults.standard.set(globalValues, forKey: "globalValues")
    }
    
}

class countries
{
    var countryId:String=String()
    var countryName:String=String()
}
class states
{
    var stateId:String=String()
    var stateName:String=String()
}

