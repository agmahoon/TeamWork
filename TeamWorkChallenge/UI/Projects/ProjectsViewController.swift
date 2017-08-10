//
//  ProjectsTableViewController.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 08/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import UIKit
import SDWebImage
import Toucan
import MBProgressHUD

class ProjectsViewController: UIViewController {
    fileprivate var projectCollection: Array<Project> = []
    @IBOutlet var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            tableView.register(
                UINib(nibName: "ProjectTableViewCell", bundle: nil),
                forCellReuseIdentifier: "projectCellIdentifier"
            )
            self.tableView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProjectCollection()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.title = "PROJECTS"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(self.refresh)
        )
    }
    
    @objc private func refresh() {
        self.getProjectCollection()
    }

    private func getProjectCollection() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let projectRequest = ProjectService(successBlock: { [weak self] (projects) in
            MBProgressHUD.hideAllHUDs(for: self?.view, animated: true)
            self?.projectCollection = projects
            self?.tableView.reloadData()
            
        }) { [weak self] (error) in
            MBProgressHUD.hideAllHUDs(for: self?.view, animated: true)
            self?.showDialog(message: error.localizedDescription)
        }
        ClientAssembly.sharedAssembly.getClientManager().enqueueRequest(projectRequest)
    }

    fileprivate func showDialog(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProjectsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectId = self.projectCollection[indexPath.row].id
        let taskList = TaskListViewController(nibName: "TaskListViewController", bundle: nil)
        taskList.projectId = projectId
        self.navigationController?.pushViewController(taskList, animated: true)
    }
}

extension ProjectsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "projectCellIdentifier",
            for: indexPath
            ) as! ProjectTableViewCell
        
        let project = self.projectCollection[indexPath.row]
        
        if let url = project.logo, url.characters.count > 0 {
            cell.logo.sd_setImage(
                with: URL(string: url),
                completed: { (image, error, cacheType, imageURL) in
                    if error == nil {
                        if let myImage = image {
                            cell.logo.image = Toucan(image: myImage).resize(
                                cell.logo.bounds.size,
                                fitMode: Toucan.Resize.FitMode.clip
                                ).image
                        }
                    }
            })
        }
        cell.name.text = project.name
        cell.pDescription.text = project.description
        cell.startDate.text = project.startDate?.convertDateFormater()
        cell.endDate.text = project.endDate?.convertDateFormater()
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectCollection.count
    }
}
