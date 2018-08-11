//
//  BankStatementViewController.swift
//  KhataBahi
//
//  Created by Apple on 20/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class BankStatementViewController:UIViewController,UITextFieldDelegate,XMLParserDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource {
    let borderColor=UIColor(red: CGFloat(158) / 255.0, green: CGFloat(155) / 255.0, blue: CGFloat(155) / 255.0, alpha: CGFloat(1))
    var posSRNO=String()
    var posName=String()
    var serverUrl=String()
    var db_name=String()
    var dashBoardElementValueForFn=String()
    var dashBoardCompanyName1=String()
    var byValue=String()
    var byAmount=String()
    var toValue=String()
    var toAmount=String()
    var loginUsername123=String()
    var ByID=String()
    var ToID=String()
    var CashPaymentSubmitResult=String()
    var CashPaymentSubmitFinalResult=String()
    var selection:Int=0
    var result=String()
    var result1=String()
    var imageview=UIImageView()
    var BillByBillStatus=String()
    var GetStartEndDteOfFnYearResult=String()
    var endDate=String()
    var startDate=String()
    // var db_name=String()
    var paymentModeArray=["CHEQUE","NEFT","RTGS","IMPS","CASH"]
    
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var posNameLabel: UITextField!
    
    @IBOutlet weak var paymentModeTableView: UITableView!
    @IBOutlet weak var paymentMode: UITextField!
    
    @IBOutlet weak var paymentModeReference: UITextField!
    
    @IBOutlet weak var debit2: UILabel!
    
    @IBOutlet weak var debitTotal: UILabel!
    
    @IBOutlet weak var credit2: UILabel!
    
    @IBOutlet weak var creditTotal: UILabel!
    @IBOutlet weak var byAmounttext: UILabel!
    
    @IBOutlet weak var toAmountText: UILabel!
    
    @IBOutlet weak var narrationBackGroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        by.becomeFirstResponder()
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(PaymentcashViewController.handleTap1(_:)))
        tapGR1.delegate = self
        tapGR1.numberOfTapsRequired = 1
       by.addGestureRecognizer(tapGR1)
        let tapGR2 = UITapGestureRecognizer(target: self, action: #selector(PaymentcashViewController.handleTap2(_:)))
        tapGR1.delegate = self
        tapGR1.numberOfTapsRequired = 1
    to.addGestureRecognizer(tapGR2)
        enterAmmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // by.addTarget(self, action: #selector(myTargetFunction), for: UIControlEvents.touchDragEnter)
        /// by.resignFirstResponder()
        
        paymentModeTableView.delegate=self
        paymentModeTableView.dataSource=self
        paymentModeTableView.isHidden=true
        paymentModeTableView.separatorStyle = .none
        
        
        if UserDefaults.standard.object(forKey: "byValue") != nil
        {   byValue=UserDefaults.standard.object(forKey: "byValue") as! String
            byAmount=UserDefaults.standard.object(forKey: "byAmount") as! String
            ByID=UserDefaults.standard.object(forKey: "ByID") as! String
            
            print(byAmount,"123456")
            by.text=byValue
            by.textColor=UIColor.black
            byAmounttext.text=byAmount
            by.resignFirstResponder()
            byTextViewBackGround.backgroundColor=UIColor.clear
            totextViewBackGround.backgroundColor=UIColor.clear
            enterAmountView.backgroundColor=UIColor.clear
            narrationBackGroundView.backgroundColor=UIColor.clear
            narration1.textColor=UIColor.black
            by.textColor=UIColor.black
            to.textColor=UIColor.black
            enterAmmount.textColor=UIColor.black
            to.becomeFirstResponder()
            
        }
        else
        {
            by.becomeFirstResponder()
        }
        if UserDefaults.standard.object(forKey: "toValue") != nil
        {   toValue=UserDefaults.standard.object(forKey: "toValue") as! String
            toAmount=UserDefaults.standard.object(forKey: "toAmount") as! String
            ToID=UserDefaults.standard.object(forKey: "ToID") as! String
            print(toAmount,"123456")
            to.text=toValue
            to.textColor=UIColor.black
            toAmountText.text=toAmount
            to.resignFirstResponder()
            byTextViewBackGround.backgroundColor=UIColor.clear
            totextViewBackGround.backgroundColor=UIColor.clear
            enterAmountView.backgroundColor=UIColor.clear
            by.textColor=UIColor.black
            to.textColor=UIColor.black
            narrationBackGroundView.backgroundColor=UIColor.clear
            narration1.textColor=UIColor.black
            enterAmmount.textColor=UIColor.black
            enterAmmount.becomeFirstResponder()
        }
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        
        dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        loginUsername123=UserDefaults.standard.object(forKey: "loginUsername123") as! String
        // by.becomeFirstResponder()
       /* let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let formatter1 = DateFormatter()
        formatter1.dateFormat="dd-MM-yyyy"
        result1 = formatter1.string(from: date)
        result = formatter.string(from: date)
        
        datefield123.text=result
        formatter.dateFormat = "EEEE"
        let dayInWeek = formatter.string(from: date)
        
        let first3:String = dayInWeek.substring(to:dayInWeek.index(dayInWeek.startIndex, offsetBy: 3))
        datefield123.text="\(result) (\(first3))"
        createDatePicker()*/
        voucherView.clipsToBounds=true
        voucherView.layer.borderWidth=1
        voucherView.layer.borderColor=borderColor.cgColor
        /*
         voucher1View.clipsToBounds=true
         voucher1View.layer.borderWidth=1
         voucher1View.layer.borderColor=borderColor.cgColor
         */
        particularsView.clipsToBounds=true
        particularsView.layer.borderWidth=1
        particularsView.layer.borderColor=borderColor.cgColor
        
        
        /*  toView.clipsToBounds=true
         toView.layer.borderWidth=1
         toView.layer.borderColor=borderColor.cgColor
         
         */
        debitCreditTitleView.clipsToBounds=true
        debitCreditTitleView.layer.borderWidth=1
        debitCreditTitleView.layer.borderColor=borderColor.cgColor
        
        debitView.clipsToBounds=true
        debitView.layer.borderWidth=0.6
        debitView.layer.borderColor=borderColor.cgColor
        
        creditView.clipsToBounds=true
        creditView.layer.borderWidth=0.6
        creditView.layer.borderColor=borderColor.cgColor
        
        /*  debitCreditTotalView.clipsToBounds=true
         debitCreditTotalView.layer.borderWidth=1
         debitCreditTotalView.layer.borderColor=borderColor.cgColor
         */
        
        narrationView.clipsToBounds=true
        narrationView.layer.borderWidth=1
        narrationView.layer.borderColor=borderColor.cgColor
        narration1.clipsToBounds=true
        narration1.layer.borderWidth=0.6
        narration1.layer.borderColor=borderColor.cgColor
        // Do any additional setup after loading the view.
        by.delegate=self
        to.delegate=self
        narration1.delegate=self
        enterAmmount.delegate=self
    }
    @objc func textFieldDidChange(_:UITextField){
        // debit2.text=enterAmmount.text
        credit2.text=enterAmmount.text
        debitTotal.text=enterAmmount.text
        creditTotal.text=enterAmmount.text
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField==by
        { UserDefaults.standard.set(2, forKey: "CashPaymentCondition")
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "byListShow")
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            
        }
        if textField==to
        {
            UserDefaults.standard.set(2, forKey: "CashPaymentCondition")
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "toListShow")
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        return true
    }
    @objc func handleTap1(_ gesture: UITapGestureRecognizer){
        UserDefaults.standard.set(2, forKey: "CashPaymentCondition")
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "byListShow")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        
    }
    @objc func handleTap2(_ gesture: UITapGestureRecognizer){
        
        UserDefaults.standard.set(2, forKey: "CashPaymentCondition")
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "toListShow")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        
    }
    @objc func myTargetFunction(textField: UITextField) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        posName=UserDefaults.standard.object(forKey: "posSingleName") as! String
        posSRNO=UserDefaults.standard.object(forKey: "posSingleSrno") as! String
        posNameLabel.text="Bank Payment(\(posName))"
        print("Payment Cash (\(posName))*********bvsp")
        getVoucherNumber()
    }
    @IBOutlet weak var narrationView: UIView!
    @IBOutlet weak var debitCreditTotalView: UIView!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var debitView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var voucherView: UIView!
    
    @IBOutlet weak var voucher1View: UIView!
    
    @IBOutlet weak var enterAmountView: UIView!
    @IBOutlet weak var debitCreditTitleView: UIView!
    
    @IBOutlet weak var particularsView: UIView!
    
    @IBAction func close(_ sender: UIButton) {
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "dashBoard")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        // dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var by: UITextField!
    @IBOutlet weak var to: UITextField!
    
    @IBOutlet weak var narration1: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        byTextViewBackGround.backgroundColor=UIColor.clear
        totextViewBackGround.backgroundColor=UIColor.clear
        enterAmountView.backgroundColor=UIColor.clear
        by.textColor=UIColor.black
        to.textColor=UIColor.black
        narrationBackGroundView.backgroundColor=UIColor.clear
        narration1.textColor=UIColor.black
        enterAmmount.textColor=UIColor.black
        if by.resignFirstResponder() == true
        {by.resignFirstResponder()
            to.becomeFirstResponder()
            
        }
        else if to.resignFirstResponder() == true
        {to.resignFirstResponder()
            enterAmmount.becomeFirstResponder()
            
        }
        else if enterAmmount.resignFirstResponder() == true
        {enterAmmount.resignFirstResponder()
            paymentModeTableView.isHidden=false
            self.view.endEditing(true)
            
        }
        else if paymentModeReference.resignFirstResponder() == true
        {paymentModeReference.resignFirstResponder()
             scrollView1.setContentOffset(CGPoint(x: 0, y: 170), animated: true)
            narration1.becomeFirstResponder()
            
        }
        else
        {narration1.resignFirstResponder()
            
            
        }
        //  to.resignFirstResponder()
        //narration1.resignFirstResponder()
        //  enterAmmount.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var byTextViewBackGround: UIView!
    
    @IBOutlet weak var totextViewBackGround: UIView!
    @IBOutlet weak var datefield123: UITextField!
    
    
    var picker=UIDatePicker()
    func createDatePicker()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar11.setItems([done], animated: false)
        
        datefield123.inputAccessoryView=toolBar11
        datefield123.inputView=picker
        picker.datePickerMode = .date
        var calendar=Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        var startDateArray=startDate.components(separatedBy: "/")
        if startDateArray.count==3
        {
            minDateComponent.day = Int(startDateArray[0])
            minDateComponent.month = Int(startDateArray[1])
            minDateComponent.year = Int(startDateArray[2])
            let minDate = calendar.date(from: minDateComponent)
            print(" min date : \(String(describing: minDate))")
            picker.minimumDate = minDate! as Date
        }
        
        
        
        
        
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        var endDateArray=endDate.components(separatedBy: "/")
        if startDateArray.count==3
        {
            maxDateComponent.day = Int(endDateArray[0])
            maxDateComponent.month = Int(endDateArray[1])
            maxDateComponent.year = Int(endDateArray[2])
            let maxDate = calendar.date(from: maxDateComponent)
            print("max date : \(String(describing: maxDate))")
            
            
            picker.maximumDate =  maxDate! as Date
        }
        
        
        
    }
    @objc func donePressed()
    {
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        let formatter4 = DateFormatter()
        formatter4.dateFormat="dd-MM-yyyy"
        result1 = formatter1.string(from: picker.date)
        
        result = formatter.string(from: picker.date)
        
        datefield123.text=result
        formatter.dateFormat = "EEEE"
        let dayInWeek = formatter.string(from: picker.date)
        
        let first3:String = dayInWeek.substring(to:dayInWeek.index(dayInWeek.startIndex, offsetBy: 3))
        datefield123.text="\(result) (\(first3))"
        
        
        // datefield123.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    
    @IBOutlet weak var enterAmmount: UITextField!
    
    @IBOutlet weak var voucherText: UILabel!
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        byTextViewBackGround.backgroundColor=UIColor.clear
        totextViewBackGround.backgroundColor=UIColor.clear
        enterAmountView.backgroundColor=UIColor.clear
        narrationBackGroundView.backgroundColor=UIColor.clear
        paymentModeTableView.isHidden=true
        if by.isEditing==true
        {
            by.textColor=UIColor.white
            
            byTextViewBackGround.backgroundColor=UIColor.black
            
        }
        if to.isEditing==true
        {
            to.textColor=UIColor.white
            
            totextViewBackGround.backgroundColor=UIColor.black
        }
        if enterAmmount.isEditing==true
        {enterAmmount.textColor=UIColor.white
            enterAmountView.backgroundColor=UIColor.black
        }
        if paymentModeReference.isEditing==true
        {
            paymentModeReference.textColor=UIColor.white
            paymentModeReference.backgroundColor=UIColor.black
           scrollView1.setContentOffset(CGPoint(x: 0, y: 130), animated: true)
        }
        if narration1.isEditing==true
        {
            narration1.textColor=UIColor.white
            narrationBackGroundView.backgroundColor=UIColor.black
            scrollView1.setContentOffset(CGPoint(x: 0, y: 170), animated: true)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField==paymentModeReference
        {
            paymentModeReference.textColor=UIColor.black
            paymentModeReference.backgroundColor=UIColor.clear
        }
        narration1.textColor=UIColor.black
        return true
    }
    
    
    
    
    
    
    func getVoucherNumber()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetVoucherNo xmlns=\"http://tempuri.org/\"><MethodName>BankPaymentVoucher</MethodName><pos>\(posSRNO)</pos><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetVoucherNo></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetVoucherNo", forHTTPHeaderField: "SOAPAction")
        
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
            
            DispatchQueue.main.async {
                self.voucherText.text=self.GetVoucherNoResult
                self.selection=2
                self.abc1()
            }
        })
        task.resume()
        
    }
    func submitCashPayment()
    {
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(day!) + "-" + String(month!) + "-" + String(year!)
        let today_time=String(hour!)  + ":" + String(minute!)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm"
        
        let date1 = dateFormatter1.date(from: today_time)
        dateFormatter1.dateFormat = "hh:mma"
        let Date12 = dateFormatter1.string(from: date1!)
        let dateString:String="\(Date12)"
        print("12 hour formatted Date:",Date12)
        var paymentReferenceNUmber=String()
        print("\(today_string)")
        
        if paymentModeReference.text?.isEmpty==true
        {
            paymentReferenceNUmber=""
        }
        else
        {
            paymentReferenceNUmber=paymentModeReference.text!
        }
        
        
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SubmitBP_Voucher xmlns=\"http://tempuri.org/\"><VoucherNo>\(GetVoucherNoResult)</VoucherNo><from_lgr>\(ByID)</from_lgr><to_lgr>\(ToID)</to_lgr><tra_dte>\(result1)</tra_dte><Total>\(enterAmmount.text!)</Total><remark>\(narration1.text!)</remark><pos>\(posSRNO)</pos><BilByBillDetails>No</BilByBillDetails><PaymentMode>\(paymentMode.text!)</PaymentMode><Ref_no>\(paymentReferenceNUmber)</Ref_no><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><user_id>\(loginUsername123)</user_id><SecurityKey>KBRE@#4321</SecurityKey></SubmitBP_Voucher></soap:Body></soap:Envelope>"
        
        
        
        
        // var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SubmitCP_Voucher xmlns=\"http://tempuri.org/\"><VoucherNo>\(GetVoucherNoResult)</VoucherNo><from_lgr>string</from_lgr><to_lgr>string</to_lgr><tra_dte>string</tra_dte><Total>\(enterAmmount.text!)</Total><remark>ffjkj</remark><pos>\(posSRNO)</pos><BilByBillDetails></BilByBillDetails><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></SubmitCP_Voucher></soap:Body></soap:Envelope>"
        
        
        print(is_SoapMessage,"08/06/18")
        // let is_URL: String = "http://wservice.senoverp.com/WSKhataBahiOnline.asmx"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        // lobj_Request.addValue("wservice.senoverp.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/SubmitBP_Voucher", forHTTPHeaderField: "SOAPAction")
        
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
            DispatchQueue.main.async {
                self.by.text=""
                self.by.resignFirstResponder()
                self.to.text=""
                self.enterAmmount.text=""
                self.narration1.text=""
                
                UserDefaults.standard.set(nil, forKey: "byValue")
                UserDefaults.standard.set(nil, forKey: "toValue")
                let alert=UIAlertController(title: "Alert", message: "\(self.CashPaymentSubmitFinalResult)", preferredStyle: .alert)
                let action=UIAlertAction(title: "Ok", style: .cancel, handler: { (ACTION) in
                    let st=UIStoryboard(name: "Main", bundle: nil)
                    let vc=st.instantiateViewController(withIdentifier: "Bank Statement") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                self.imageview.isHidden=true
                self.view.isUserInteractionEnabled=true
            }
            
        })
        
        task.resume()
        
    }
    
    
    var elementValue: String?
    var GetVoucherNoResult=String()
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetVoucherNoResult" {
            selection==0
            elementValue = String()
            
        }
        if elementName == "SubmitBP_VoucherResult" {
            selection==1
            CashPaymentSubmitResult = String()
            
        }
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=2
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection==0 {
            elementValue! += string
            GetVoucherNoResult=elementValue!
        }
        if CashPaymentSubmitResult != nil && selection==1 {
            CashPaymentSubmitResult += string
            CashPaymentSubmitFinalResult=CashPaymentSubmitResult
            print(CashPaymentSubmitFinalResult,"08/06/18*")
        }
        if elementValue != nil && selection==2{
            elementValue! += string
            
            GetStartEndDteOfFnYearResult=elementValue!
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetVoucherNoResult" {
            selection=0
            elementValue = String()
            
        }
        if elementName == "SubmitBP_VoucherResult" {
            selection=1
            CashPaymentSubmitResult = String()
            
        }
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=2
        }
       
        
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageview = UIImageView(image: jeremyGif)
        
        imageview.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageview)
        self.view.isUserInteractionEnabled=false
        if by.text?.isEmpty==true
        {let alert=UIAlertController(title: "Alert", message: "'By' Option should not be Empty", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            by.becomeFirstResponder()
            imageview.isHidden=true
            self.view.isUserInteractionEnabled=true
            
        }
        else if to.text?.isEmpty==true
        {let alert=UIAlertController(title: "Alert", message: " 'To' Option should not be Empty", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            to.becomeFirstResponder()
            imageview.isHidden=true
            self.view.isUserInteractionEnabled=true
        }
        else  if enterAmmount.text?.isEmpty==true
        {let alert=UIAlertController(title: "Alert", message: "Amount Field should not be Empty", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            enterAmmount.becomeFirstResponder()
            imageview.isHidden=true
            self.view.isUserInteractionEnabled=true
        }
        else  if paymentMode.text?.isEmpty==true
        {let alert=UIAlertController(title: "Alert", message: "paymentMode should not be Empty", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
           paymentModeTableView.isHidden=false
            imageview.isHidden=true
            self.view.isUserInteractionEnabled=true
        }
        else  if paymentModeReference.text?.isEmpty==true
        {if paymentMode.text! != "CASH"
        {
            let alert=UIAlertController(title: "Alert", message: "Please enter reference number", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            paymentModeReference.becomeFirstResponder()
            imageview.isHidden=true
            self.view.isUserInteractionEnabled=true
            }
        else
        {
            submitCashPayment()
            selection=1
            }
        }
        else
        {
           submitCashPayment()
            selection=1
        }
    }
    
    
    
    @IBAction func clear(_ sender: UIButton) {
        by.text=""
        by.resignFirstResponder()
        to.text=""
        enterAmmount.text=""
        narration1.text=""
        
        UserDefaults.standard.set(nil, forKey: "byValue")
        UserDefaults.standard.set(nil, forKey: "toValue")
        by.becomeFirstResponder()
    }
    func abc1()
    {selection=2
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStartEndDteOfFnYear xmlns=\"http://tempuri.org/\"><FnYear>\(dashBoardElementValueForFn)</FnYear><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetStartEndDteOfFnYear></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetStartEndDteOfFnYear", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            if data != nil
            {
                DispatchQueue.main.async {
                    //print(self.GetStartEndDteOfFnYearResult,"11/06/18")
                    var dummy:[String]=self.GetStartEndDteOfFnYearResult.components(separatedBy: "^")
                    if dummy.count==2
                    {
                        self.startDate=dummy[0]
                        self.endDate=dummy[1]
                        self.result1=dummy[1]
                        // self.fromTextField.text=dummy[0]
                        self.datefield123.text=dummy[1]
                        
                        
                        self.createDatePicker()
                        /// self.selection=2
                        
                    }
                    
                }
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentModeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=paymentModeTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.textLabel?.text=paymentModeArray[indexPath.row]
        return cell
    }
    @IBAction func selectPymentMode(_ sender: UIButton) {
        if paymentModeTableView.isHidden==true
        {
            paymentModeTableView.isHidden=false
                    self.view.endEditing(true)
        }
        else{
            
            paymentModeTableView.isHidden=true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paymentMode.text=paymentModeArray[indexPath.row]
        paymentModeTableView.isHidden=true
        scrollView1.setContentOffset(CGPoint(x: 0, y: 130), animated: true)
        if paymentModeArray[indexPath.row] != "CASH"
        {
        paymentModeReference.becomeFirstResponder()
            
        }
        else
        {
            narration1.becomeFirstResponder()
        }
    }
    
    
}
