	//
//  DashBoardViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/31/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import Charts
import AnimatableReload
    
class DashBoardViewController: UIViewController,UIGestureRecognizerDelegate,XMLParserDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ChartViewDelegate{
    var animateUpAndDown=0
    var posSRNo=[String]()
    var posNames=[String]()
    var posSelectionGo=Int()
    @IBOutlet weak var accountingView: UIView!
    @IBOutlet weak var mastersView: UIView!  
    
    @IBOutlet weak var inventoryView: UIView!
    
    
    
    @IBOutlet weak var reportsView: UIView!
    
    @IBOutlet weak var badgeLabel: UILabel!
    
    
    @IBOutlet weak var settingsView: UIView!
    
    var imageView:UIImageView!
    @IBOutlet weak var barChartView: BarChartView!
    var serverUrl:String=String()
    var dateForServer:String=String()
    var dashBoardCompanyName1:String=String()
    var dashBoardElementValueForFn:String=String()
    var db_name:String=String()
    let months = ["Jan", "Feb", "Mar", "Apr", "May","June","July","Aug","Sept","Oct","Nov","Dec"]
    let unitsSold = [80.0, 70.0, 60.0, 30.0, 20.0,10.0,60.0, 70.0, 50.0, 30.0, 52.0,10.0]
    var selection:Int!
   // let unitsBought = [60.0, 54.0, 80.0, 50.0, 70.0,20.0, 60.0, 80.0, 60.0, 70.0,60.0,80.0]
    var monthsFromServer=[String]()
    var valuesFromServer=[Int]()
    var x=0
    var notificationCountValueText=String()
    var notificationResetValue=String()
    var section1:Int=0
    let section3Images=["purchase_entry.png","purchase_entry.png","purchase_entry.png","purchase_entry.png","purchase_entry.png","purchase_entry.png","purchase_entry.png","purchase_entry.png"]
    let section3Titles=["Cash Payment","Cash Receive","Bank Payment","Bank Receive","Cash Bank Withdraw","Cash Bank Deposit","Contra Voucher","Journal Voucher"]
    let section0Titles=["Create Ledger","Create Item","Item Company Master","Dept Master","Sub-Dept master","Unit Master"]
    let section1Titles=["Purchase Entry","Purchase Edit","Sale Entry","Sale Edit","Purchase Return","Sale Return"]
    let section1Images=["purchase_entry.png","purchase_edit.png","credit_sale_entry.png","credit_sale_edit.png","purchase_return.png","sale_return.png"]
    let section0Images=[
        "create_ledger1.png","create_item.png","company_master.png","dept_master.png","sub_dept_master.png","unit_master.png","terms_and_conditions.png"]
    let section2Titles=["Purchase List","Sale List","Stock List","Party Ledger","GST R1","Sale Item Wise","Sale Company Wise","Sale Bill Wise","Party Ledger1"]
    let section2Images=["purchase_list.png","sale_list.png","stock_list.png","party_ledger.png","demo.png","item_wise.png","company_wise.png","bill_wise.png","party_ledger.png"]
     let section4Titles=["Invoice TnC Master","Invoice Setting Master","Company Profile Update"]
    
    let section4Images=["terms_and_conditions.png","invoice_setting_master.png","edit_company_profile.png"]
    @IBOutlet weak var slideCollectionView: UICollectionView!
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var graphView: UIView!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var companyNameTitle: UILabel!
    
 @IBOutlet weak var tableView1: UITableView!
    
    @IBOutlet weak var pagecontrols: UIPageControl!
    
    
    @IBOutlet weak var companyFinancialYear: UILabel!
    
    @IBOutlet weak var trailingEdge: NSLayoutConstraint!
    var viewBackGroundColor=UIColor(red: 234/255, green: 233/255, blue: 233/255, alpha: 1.0)
    var categories = ["Masters","Accounting Vouchers", "Inventory Vouchers", "Reports"]
    var titleNames=[String]()
    var links=[String]()
    var imageLinks=[String]()
    var currentDate:String=String()
      var firstStringsValues=[String]()
    var count1:Int=0
    var countPrevious:Int=0
    
    
    @IBAction func notificationIconButton(_ sender: UIButton) {
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
        self.view.isUserInteractionEnabled=false
        
        setNotificationChecked()
        
        
        
        
    }
    
    var timer=Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.set(nil, forKey: "byValue")
        UserDefaults.standard.set(nil, forKey: "toValue")
        UserDefaults.standard.set(nil, forKey: "byAmount")
        UserDefaults.standard.set(nil, forKey: "toAmount")
       badgeLabel.isHidden=true
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
     
        
         timer = Timer.scheduledTimer(timeInterval: 10, target: self,   selector: (#selector(DashBoardViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
         mastersView.layer.cornerRadius=10
         mastersView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
         serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
         db_name=UserDefaults.standard.object(forKey: "db_name") as! String
         print(serverUrl,"bvspServerUrl")
         getbanners()
     
         let date = Date()
         let formatter = DateFormatter()
     
        
         formatter.dateFormat = "dd/MM/yyyy"
         let formatter12 = DateFormatter()
         formatter12.dateFormat="yyyy-MM-dd"
         dateForServer=formatter12.string(from: date)
       
        
        
        dateField1.text="\(formatter.string(from: date))"
      /*  let today_time=String(hour!)  + ":" + String(minute!)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm"
        
        let date1 = dateFormatter1.date(from: today_time)
        dateFormatter1.dateFormat = "hh:mm a"
        let Date12 = dateFormatter1.string(from: date1!)
        let dateString:String="\(Date12)"
        print("12 hour formatted Date:",Date12)*/
        

        
        
        
       
       
      
         UserDefaults.standard.set(-1, forKey: "section")
      dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
            companyFinancialYear.text="(\(dashBoardElementValueForFn))"
            /////barChartSetup
        
        
       dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        companyNameTitle.text=dashBoardCompanyName1
        getTheGraphDataFromTheServer()
        menuView.isHidden=true
       
    
        badgeLabel.clipsToBounds=true
        badgeLabel.layer.cornerRadius=5
        badgeLabel.layer.borderWidth=1
        badgeLabel.layer.borderColor=UIColor.black.cgColor
    
        let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleTap1(_:)))
        tapGR1.delegate = self
        tapGR1.numberOfTapsRequired = 1
        barChartView.addGestureRecognizer(tapGR1)
        
    
       // barChartView.delegate = self
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.chartDescription?.text = ""
        
       
        //legend
        let legend = barChartView.legend
        legend.enabled = true
      /*  legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        
        */
       
        legend.yEntrySpace = 0.0;
        
       
        /// xaxis.valueFormatter = IAxisValueFormatter(values:months)
        
  //      xaxis.valueFormatter = IndexAxisValueFormatter(values:months)
        let xaxis = barChartView.xAxis
      
        xaxis.labelPosition = .top
       
        xaxis.labelTextColor=UIColor.black
        xaxis.drawAxisLineEnabled=true
       // xaxis.centerAxisLabelsEnabled = true
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        let rightAxisFormatter = NumberFormatter()
        rightAxisFormatter.maximumFractionDigits=1
        barChartView.xAxis.axisMinimum=0
        let yaxisRight=barChartView.rightAxis
        yaxisRight.spaceTop=0.35
        yaxisRight.axisMinimum=0
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        //yaxis.drawAxisLineEnabled=true
        yaxis.drawAxisLineEnabled = true
        
        barChartView.rightAxis.enabled = true
        //axisFormatDelegate = self
        
  
        
        
     createDatePicker()
        AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
        getNotificationCountValue()
        getPOS()
       
    }
    @objc func updateTimer()
    {getNotificationCountValue()
        
    }
 /* func checkMenuView()
  {let tapGR = UITapGestureRecognizer(target: self, action: #selector(DashBoardViewController.handleTap(_:)))
    tapGR.delegate = self
    tapGR.numberOfTapsRequired = 1
        if menuView.isHidden==true {
            
            manuCollectionView.addGestureRecognizer(tapGR)
        }
        else
        {
            manuCollectionView.removeGestureRecognizer(tapGR)
        }
    }*/
    
    @IBOutlet weak var manuCollectionView: UICollectionView!
    
    @IBAction func masters(_ sender: UIButton) {
        if menuView.isHidden==true
        {
        section1=0
        mastersView.backgroundColor=viewBackGroundColor
        mastersView.layer.cornerRadius=10
        mastersView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        accountingView.layer.cornerRadius=0
        inventoryView.layer.cornerRadius=0
        reportsView.layer.cornerRadius=0
        settingsView.layer.cornerRadius=0
        accountingView.backgroundColor=UIColor.white
        inventoryView.backgroundColor=UIColor.white
        reportsView.backgroundColor=UIColor.white
        settingsView.backgroundColor=UIColor.white
        if animateUpAndDown % 2 == 0
        {
         AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
        animateUpAndDown=animateUpAndDown+1
        }else
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "down")
            animateUpAndDown=animateUpAndDown+1
        }
       // manuCollectionView.reloadData()
        }
        else
        {
            menuView.isHidden=true
        }
        
    }
    
    
    @IBOutlet weak var Accounting: UIButton!
    
    
    @IBAction func Accounting1(_ sender: UIButton) {
        if menuView.isHidden==true
        {
        section1=1
        mastersView.backgroundColor=UIColor.white
        //accountingView.layer.cornerRadius=10
        mastersView.layer.cornerRadius=0
        accountingView.layer.cornerRadius=10
        accountingView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        inventoryView.layer.cornerRadius=0
        reportsView.layer.cornerRadius=0
        settingsView.layer.cornerRadius=0
        accountingView.backgroundColor=viewBackGroundColor
        inventoryView.backgroundColor=UIColor.white
        reportsView.backgroundColor=UIColor.white
        if animateUpAndDown % 2 == 0
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
            animateUpAndDown=animateUpAndDown+1
        }else
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "down")
            animateUpAndDown=animateUpAndDown+1
        }
        settingsView.backgroundColor=UIColor.white
      //  manuCollectionView.reloadData()
        }
        else{
            menuView.isHidden=true
        }
        
    }
    
    
    @IBAction func Inventory(_ sender: UIButton) {
        if menuView.isHidden==true
        {
        section1=2
        mastersView.backgroundColor=UIColor.white
        accountingView.backgroundColor=UIColor.white
        inventoryView.backgroundColor=viewBackGroundColor
        mastersView.layer.cornerRadius=0
        accountingView.layer.cornerRadius=0
        inventoryView.layer.cornerRadius=10
        inventoryView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        reportsView.layer.cornerRadius=0
        settingsView.layer.cornerRadius=0
        reportsView.backgroundColor=UIColor.white
        settingsView.backgroundColor=UIColor.white
        
        
        if animateUpAndDown % 2 == 0
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
            animateUpAndDown=animateUpAndDown+1
        }else
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "down")
            animateUpAndDown=animateUpAndDown+1
        }
        }
        else
        {
            menuView.isHidden=true
        }
       // manuCollectionView.reloadData()
        
    }
    
    @IBOutlet weak var Vouchers: UIButton!
    
    
    @IBAction func vouchers1(_ sender: UIButton) {
        if menuView.isHidden==true
        {
        ///vouchers Nothing Is "reports"
        section1=3
        mastersView.backgroundColor=UIColor.white
        accountingView.backgroundColor=UIColor.white
        inventoryView.backgroundColor=UIColor.white
        reportsView.backgroundColor=viewBackGroundColor
        mastersView.layer.cornerRadius=0
        accountingView.layer.cornerRadius=0
        inventoryView.layer.cornerRadius=0
        reportsView.layer.cornerRadius=10
        reportsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        settingsView.layer.cornerRadius=0
        settingsView.backgroundColor=UIColor.white
        if animateUpAndDown % 2 == 0
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
            animateUpAndDown=animateUpAndDown+1
        }else
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "down")
            animateUpAndDown=animateUpAndDown+1
        }
        //manuCollectionView.reloadData()
        }
        else
        {
            menuView.isHidden=true
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
        animateUpAndDown=animateUpAndDown+1
        
    }
   /* override func viewDidAppear(_ animated: Bool) {
        AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
    }*/
    @IBAction func Settings(_ sender: UIButton) {
        if menuView.isHidden==true
        {
       section1=4
        mastersView.backgroundColor=UIColor.white
        accountingView.backgroundColor=UIColor.white
        inventoryView.backgroundColor=UIColor.white
        reportsView.backgroundColor=UIColor.white
        settingsView.backgroundColor=viewBackGroundColor
        mastersView.layer.cornerRadius=0
        accountingView.layer.cornerRadius=0
        inventoryView.layer.cornerRadius=0
        reportsView.layer.cornerRadius=0
        settingsView.layer.cornerRadius=10
        settingsView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        if animateUpAndDown % 2 == 0
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "up")
            animateUpAndDown=animateUpAndDown+1
        }else
        {
            AnimatableReload.reload(collectionView: self.manuCollectionView, animationDirection: "down")
            animateUpAndDown=animateUpAndDown+1
        }
        //manuCollectionView.reloadData()
        }
        else
        {
            menuView.isHidden=true
        }
    }
    
    
    
    
    func setChart() {
        barChartView.noDataText = "You need to provide data for the chart."
        let xaxis = barChartView.xAxis
        xaxis.valueFormatter =  DefaultAxisValueFormatter(block: {(index, _) in
            return self.monthsFromServer[Int(index)]
        })
      //  xaxis.setLabelCount(months.count, force: false)
        var dataEntries: [BarChartDataEntry] = []
      // var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.monthsFromServer.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.valuesFromServer[i]))
            dataEntries.append(dataEntry)
            
          //  let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.unitsBought[i])
          //  dataEntries1.append(dataEntry1)
            
            //stack barchart
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")
            
            
            
        }
    
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
      //  let chartDataSet1 = BarChartDataSet(values: dataEntries1, label: "Unit Bought")
        
        let dataSets: [BarChartDataSet] = [chartDataSet]
        
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
   
     /*   let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        
        
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)*/
        barChartView.notifyDataSetChanged()
        
        barChartView.data = chartData
        
        
        
        
        
        
        //background color
       ///// barChartView.backgroundColor = UIColor.lightGray
        
        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        DispatchQueue.main.async {
            self.imageView.isHidden=true
        }
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
    
        menuView.isHidden=true
    }
    @objc func handleTap1(_ gesture: UITapGestureRecognizer){
        
        menuView.isHidden=true
    }
    @IBAction func menu(_ sender: UIButton) {
   //checkMenuView()
        if menuView.isHidden == true
        {UIView.animate(withDuration: 0.7, delay: 0, options: .transitionCurlDown, animations: {
            self.menuView.isHidden=false
            self.menuView.alpha=0
            self.menuView.alpha=1
        }, completion: nil)
            
            
      
        }
        else
        {
            UIView.animate(withDuration: 0.7, delay: 0, options: .transitionCurlDown, animations: {//self.menuView.alpha=1
                //self.menuView.alpha=0
                self.menuView.isHidden=true
                
            }, completion: nil)
        }
        
    }
  
    @IBAction func changeFinancialYear(_ sender: UIButton) {
        if UserDefaults.standard.object(forKey: "fnlist") != nil
        {
        var fnList:[String]=UserDefaults.standard.object(forKey: "fnlist") as! [String]
        
        
        if fnList.count > 1
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "changeFn") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }else
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            
            var messageDescription="Options are not available "
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
            
            }
        }
        else
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            
            var messageDescription="Options are not available "
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
   
      /*  var oKaction:Int=4
        UserDefaults.standard.set(oKaction, forKey: "oKaction")
        
        var messageDescription="Options are not available "
        UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
        self.present(vc, animated: true, completion: nil)*/
    }
    
    @IBAction func changeCompany(_ sender: UIButton) {
        var companyNames123=UserDefaults.standard.object(forKey: "company_names") as! [String]
        if companyNames123.count > 1
        {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoardPopUp1") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        }
        else
        {
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            
            var messageDescription="Options are not available "
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func feedBack(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "feedback") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func contactUS(_ sender: UIButton) {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "contactUS") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        

        
        
    }
    
    
    
    
    @IBAction func logOut(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "logOut") as! UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(DashBoardViewController.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        self.pagecontrols.currentPage = x
        if self.x < count1 {
           
           // print(x)
            let indexPath = IndexPath(item: x, section: 0)
            self.slideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
        } else {
            self.x = 0
            self.slideCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedItem != nil) {
            slideCollectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.slideCollectionView
        {
        return titleNames.count
        }
        else
        {switch (section1) {
        case 0:
            
            return section0Titles.count
        case 1:
            
            return section3Titles.count
        case 2:
            
            return section1Titles.count
        case 3:
            
            return section2Titles.count
            
        default:
            return section4Titles.count
            }
            
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.slideCollectionView
        {
        var cell = slideCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! slideCollectionViewCell
       
        var smallImage:String=imageLinks[indexPath.row]
        DispatchQueue.global().async {
            let url = URL(string: "\(smallImage)")
            
            let imageData = try? Data(contentsOf: url!)
            
            DispatchQueue.main.sync {
                if imageData != nil
                {
                cell.image1.image = UIImage(data: imageData!)
            }
                
            }
        }
        cell.label1.text="   \(titleNames[indexPath.row])"
       
     
        return cell
        }
        else{
            let cell = manuCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionView1Cell
            
            switch (section1) {
            case 0:
                cell.label.text=section0Titles[indexPath.row]
                cell.image1.image=UIImage(named:"\(section0Images[indexPath.row])")
                
            case 1:
                cell.label.text=section3Titles[indexPath.row]
                cell.image1.image=UIImage(named:"\(section3Images[indexPath.row])")
                
            case 2:
                cell.label.text=section1Titles[indexPath.row]
                cell.image1.image=UIImage(named:"\(section1Images[indexPath.row])")
            case 3:
                cell.label.text=section2Titles[indexPath.row]
                cell.image1.image=UIImage(named:"\(section2Images[indexPath.row])")
                
            default:
                cell.label.text=section4Titles[indexPath.row]
                cell.image1.image=UIImage(named:"\(section4Images[indexPath.row])")
                
            }
return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
           /* if collectionView == self.slideCollectionView
            {
                
            }*/
  
       
     if collectionView==manuCollectionView
        { let itemsPerRow:CGFloat = 5
            //let hardCodedPadding:CGFloat = 5
            let itemWidth = (manuCollectionView.bounds.width / itemsPerRow) - 6
           
         return CGSize(width:itemWidth, height: 80)
     }else{
        return CGSize(width: self.view.frame.size.width, height: 180)
        }
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if menuView.isHidden == true
        {
        if collectionView == self.slideCollectionView
        {
          UIApplication.shared.openURL(NSURL(string:"\(links[indexPath.row])")! as URL)
        let sUrl = "googlechrome://\(links[indexPath.row])"
        UIApplication.shared.openURL(NSURL(string: sUrl) as! URL)
        }
        else
        {
            var serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
            var db_name=UserDefaults.standard.object(forKey: "db_name") as! String
            var fnYear=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
            var dashBoardCompanyName=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
            //let urlForWebView=serverUrl+"Process/CashSale?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
            
            
            //http://wservice.khatabahi.online/Process/PartyLedger?DB=KhataBahiCommonBaseAndroid&CompanyName=Admin&FnYear=2017-2018
            
            
            //print(urlForWebView,"urlForWebViewbvsp")
            
            // print("\(indexPath)bvsp indexPathRo")
            let cell=manuCollectionView.cellForItem(at: indexPath) as! collectionView1Cell
            let labe=cell.label.text as! String
            
            switch (labe) {
            case "Create Item":
                let urlForWebView=serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                
                
            case "Sale Entry":
                let urlForWebView=serverUrl+"Process/CashSale?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                
            case "Create Ledger":
                let urlForWebView=serverUrl+"process/createLedger?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                
            case "Sale Edit":
                let urlForWebView=serverUrl+"Process/CreditSaleEdit?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Party Ledger":
                let urlForWebView=serverUrl+"Process/PartyLedger?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "PartyLedger") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Party Ledger1":
                let urlForWebView=serverUrl+"Process/PartyLedger?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Purchase Edit":
                let urlForWebView=serverUrl+"Process/PurchaseEdit?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Purchase Entry":
                let urlForWebView=serverUrl+"Process/PurchaseEntry?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                
            case "Stock List":
                let urlForWebView=serverUrl+"Process/StockDetail?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
                UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: false, completion: nil)
            case "Item Company Master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "itemCompanyMaster") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Dept Master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "dept") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Sub-Dept master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "subDept") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Unit Master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "unitMaster") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Sale List":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "saleList") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Purchase List":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "purchaseList") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "GST R1":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "gst") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            
            case "Invoice TnC Master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "T&C") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                
            case "Invoice Setting Master":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "invoiceSettingMaster") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Company Profile Update":
                
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "profileEdit") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            case "Cash Payment":
                if posSelectionGo == 0
                {
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "cashPayment") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Cash Receive":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "cashReceipt") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Bank Payment":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Bank Statement") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Bank Receive":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Bank Receive") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Cash Bank Withdraw":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Cash Bank Withdraw") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Cash Bank Deposit":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Cash Bank Deposit") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Contra Voucher":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Contra Voucher") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
            case "Journal Voucher":
                if posSelectionGo == 0
                {
                    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "Journal Voucher") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                }
                else
                {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyBoard.instantiateViewController(withIdentifier: "multiplePOSnames") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    
                }
                
            default:
                print("bvspRock")
            }
        }
        }
        else
        {
            menuView.isHidden=true
        }
    }
  
    func getbanners()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetBannersForAndrod xmlns=\"http://tempuri.org/\"><SecurityKey>#111000$</SecurityKey></GetBannersForAndrod></soap:Body></soap:Envelope>"
        let is_URL: String = "http://admin.khatabahi.com/KhataBahiService.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("admin.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetBannersForAndrod", forHTTPHeaderField: "SOAPAction")
        
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
    var elementValue1: String?
    var success = false
    var graphData:String!
    var pos=String()
    var posResult=String()
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetBannersForAndrodResponse" {
            elementValue1 = String()
            selection = 0
            
        }
        if elementName == "GetDataForGraphResult"
        {
            graphData=String()
            selection=1
        }
        if elementName == "GetCountNotificationResult"
        {
            notificationCountValueText=String()
            selection=2
            
            
        }
        if elementName == "SetNotificationNewCheckedResult"
        {
            notificationResetValue=String()
            selection=3
            
            
        }
        if elementName == "GetPosResult"
        {
            pos=String()
            selection=4
            
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue1 != nil && selection == 0{
            elementValue1! += string
            //print(elementValue1)
            firstStringsValues=elementValue1!.components(separatedBy:"^")
            //  print(firstStringsValues)
            count1=firstStringsValues.count
            print(count1,"bvsp count")
            if count1 > 3
            {
            for index in 0..<count1
            {//print(firstStringsValues[index])
                var value:String=firstStringsValues[index]
                print(value)
                
                var titleLinkImage=value.components(separatedBy: "~")
                print(titleLinkImage)
           
                    titleNames.append(titleLinkImage[0])
                    links.append(titleLinkImage[1])
                    imageLinks.append(titleLinkImage[2])
              
            }
            
            print(titleNames.count,"**********")
            print(links.count,"+++++++++++")
            print(imageLinks.count,"------------")
                DispatchQueue.main.async {
                    self.pagecontrols.numberOfPages=self.count1
                    self.slideCollectionView.reloadData()
                     self.setTimer()
                   
                }
            }
       
        }
     if graphData != nil && selection == 1
     {monthsFromServer=[String]()
  valuesFromServer=[Int]()
        graphData! += string

    var dummyGraphList=graphData.components(separatedBy: "^")
     for value in dummyGraphList
     {
        var dummyValue=value
        var dummyValueList=dummyValue.components(separatedBy: ":")
        monthsFromServer.append(dummyValueList[1])
        valuesFromServer.append(Int(dummyValueList[2])!)
        
    }
        if valuesFromServer.count<9
        {
            switch(valuesFromServer.count)
            {
            case 1:
                for i in 0..<8
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
                
            case 2:
                for i in 0..<7
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
            case 3:
                for i in 0..<6
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
            case 4:
                for i in 0..<5
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
            case 5:
                for i in 0..<4
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
                
            case 6:
                for i in 0..<3
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
            case 7:
                for i in 0..<2
                {valuesFromServer.append(0)
                    monthsFromServer.append("")
                    
                }
            default:
                var siva="bv"
            }
        }
        
        
        DispatchQueue.main.async {
            self.barChartView.delegate=self
            self.setChart()
        }
        
        }
      if notificationCountValueText != nil && selection == 2
      {
       notificationCountValueText = string
       // print(notificationCountValueText,"bvsp ***")
        
        if Int(notificationCountValueText)! != 0 && Int(notificationCountValueText)! > 0
        {DispatchQueue.main.async {
            self.badgeLabel.isHidden=false
            self.badgeLabel.text=self.notificationCountValueText
            }
            
        }
        else
        {
            DispatchQueue.main.async {
                self.badgeLabel.isHidden=true
            }
        }
        }
        if notificationResetValue != nil && selection == 3
        {
            
            notificationResetValue = string
           // print(notificationResetValue,"bvsp ***")
            DispatchQueue.main.async {
               self.imageView.isHidden=true
                
                
                self.view.isUserInteractionEnabled=true
                let storyBoard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyBoard.instantiateViewController(withIdentifier: "notificationView") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            }
            
            
            /*if Int(notificationCountValueText)! != 0 && Int(notificationCountValueText)! > 0
            {DispatchQueue.main.async {
                self.badgeLabel.isHidden=false
                self.badgeLabel.text=self.notificationCountValueText
                }
                
            }
            else
            {
                DispatchQueue.main.async {
                    self.badgeLabel.isHidden=true
                }
            }*/
        }
       if pos != nil && selection==4
       {
        pos += string
        posResult=pos
        
        
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetBannersForAndrodResponse" {
            elementValue1 = String()
            selection=0
        }
        if elementName == "GetDataForGraphResult"
        {
            graphData=String()
            selection=1
            
           
        }
        if elementName == "GetCountNotificationResult"
        {
            notificationCountValueText=String()
            selection=2
            
            
        }
        if elementName == "SetNotificationNewCheckedResult"
        {
            notificationResetValue=String()
            selection=3
            
            
        }
        if elementName == "GetPosResult"
        {
            pos=String()
            selection=4
            
            
        }
    
    }
    var picker=UIDatePicker()
   func createDatePicker()
    {let toolBar=UIToolbar()
        toolBar.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([done], animated: false)
        dateField1.inputAccessoryView=toolBar
        dateField1.inputView=picker
        picker.datePickerMode = .date
    
    }
    @objc func donePressed()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        dateForServer=formatter1.string(from: picker.date)
      
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        dateField1.text=formatter.string(from: picker.date)
         getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    @IBOutlet weak var dateField1: UITextField!
    @IBOutlet weak var datefield: UIButton!
    
    @IBAction func dateSelect(_ sender: UIButton) {
        
        let picker : UIDatePicker = UIDatePicker()
        picker.datePickerMode = UIDatePickerMode.date
       let toolbar=UIToolbar()
        
       // picker.sizeToFit()
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:  #selector(dueDateChanged(sender:)))
        toolbar.setItems([done], animated: false)
     
        picker.frame = CGRect(x:0.0, y:260, width:self.view.frame.width, height:460)
        
        picker.addSubview(toolbar)
        // you probably don't want to set background color as black
       picker.backgroundColor = UIColor.gray
        self.view.addSubview(picker)
    }
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        datefield.setTitle(dateFormatter.string(from: sender.date), for: .normal)
        
    }
    
    func getTheGraphDataFromTheServer()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetDataForGraph xmlns=\"http://tempuri.org/\"><FnYear>\(dashBoardElementValueForFn)</FnYear><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SaleDte>\(dateForServer)</SaleDte><SecurityKey>KBRE@#4321</SecurityKey></GetDataForGraph></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/GetDataForGraph", forHTTPHeaderField: "SOAPAction")
        
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
    func getNotificationCountValue()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCountNotification xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetCountNotification></soap:Body></soap:Envelope>"
       // print(is_SoapMessage,"getGraphdataBvsp")
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
        lobj_Request.addValue("http://tempuri.org/GetCountNotification", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            
           // print("Response: \(response)")
            if data != nil
            {
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            //print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            }
            //XMLparser.shouldResolveExternalEntities = true
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
           
            
        })
        task.resume()
        
    }
    func setNotificationChecked()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SetNotificationNewChecked xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></SetNotificationNewChecked></soap:Body></soap:Envelope>"
       // print(is_SoapMessage,"getGraphdataBvsp")
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
        lobj_Request.addValue("http://tempuri.org/SetNotificationNewChecked", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
           // print("Response: \(response)")
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
    func getPOS()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetPos xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetPos></soap:Body></soap:Envelope>"
        // print(is_SoapMessage,"getGraphdataBvsp")
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
        lobj_Request.addValue("http://tempuri.org/GetPos", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
           // print("Response: \(response)")
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
                var posResult1:String=self.posResult
                var dummyList=posResult1.components(separatedBy: "^")
                if dummyList.count>1
                {
                    self.posSelectionGo=1
                for value in dummyList
                {
                    var dummySRAndName=value.components(separatedBy: "~")
                    self.posSRNo.append(dummySRAndName[0])
                    self.posNames.append(dummySRAndName[1])
                    
                    
                }
                    UserDefaults.standard.set(self.posSRNo, forKey: "posMultipleSrno")
                    UserDefaults.standard.set(self.posNames, forKey: "posMultipleName")
                }
                else
                {
                var dummySRAndName=posResult1.components(separatedBy: "~")
                    var posSingleSrno:String=dummySRAndName[0]
                    var posSingleName:String=dummySRAndName[1]
                    UserDefaults.standard.set(posSingleName, forKey: "posSingleName")
                    UserDefaults.standard.set(posSingleSrno, forKey: "posSingleSrno")
                }
                
            }
        })
        task.resume()
        
    }
    
   
}
extension DashBoardViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath,"bvspTableView")
    }
}

extension DashBoardViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! tableView1Cell
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor=UIColor.lightGray
      
            guard let header = view as? UITableViewHeaderFooterView else { return }
        
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
           // header.textLabel?.frame = header.frame
           // header.textLabel?.textAlignment = .center
        }
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
    if identifier == "abc"
    {let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        }
    }
    }

