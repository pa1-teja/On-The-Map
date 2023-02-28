//
//  StudentProfileTableTableViewController.swift
//  On The Map
//
//  Created by TEJAKO3-Old Mac on 24/02/23.
//

import UIKit

class StudentProfileTableTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    
    var studentProfiles : StudentLocationResults.StudentResults!{
        let sharedAppDelegateObject = UIApplication.shared.delegate as! AppDelegate
        return sharedAppDelegateObject.studentProfiles
    }
    
    @IBOutlet weak var studentProfilesTableView: UITableView!
    
    @IBOutlet weak var noStudentProfilesMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.toolbar.isHidden = false
        studentProfilesTableView.dataSource = self
        studentProfilesTableView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if(studentProfiles.results.isEmpty){
            toggleNoProfilesMsgVisibility(isHidden: true)
        }else{
            toggleNoProfilesMsgVisibility(isHidden: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

            refreshStudentProfilesDataOnTableView()
    }

    private func toggleNoProfilesMsgVisibility(isHidden: Bool){
        noStudentProfilesMessage.isHidden = isHidden
    }
    
    func refreshStudentProfilesDataOnTableView(){
        studentProfilesTableView.reloadData()
    }
    // MARK: - Table view data source


    func numberOfSections(in tableView: UITableView) -> Int {
        return studentProfiles.results.count
    }

  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentProfiles.results.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Student Profile", for: indexPath) as! ProfilesTableViewCell
        
        // Configure the cell...
        let profile = studentProfiles.results[(indexPath as NSIndexPath).row]
        
        cell.studentName.text  = profile.firstName + " " +  profile.lastName
        cell.profileLink.text = profile.mediaURL

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProfile = studentProfiles.results[(indexPath as NSIndexPath).row]
        
        let url = URL(string: selectedProfile.mediaURL)!
        
        UIApplication.shared.open(url)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
