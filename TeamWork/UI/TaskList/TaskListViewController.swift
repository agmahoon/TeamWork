//
//  TaskListTableViewController.swift
//  TeamWorkChallenge
//
//  Created by Abdul Ghafoor on 09/08/2017.
//  Copyright © 2017 Abdul Ghafoor. All rights reserved.
//

import UIKit
import MBProgressHUD

class TaskListViewController: UIViewController {
    fileprivate var tasklistCollection: Array<TaskList> = []
    @IBOutlet var tableView: UITableView!
    var projectId: String? = nil {
        didSet {
            self.getTaskList()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTaskList()
        self.title = "TASK LIST"
        let refresh = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(self.refresh)
        )
        
        let add = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(self.addTaskList)
        )
        self.navigationItem.setRightBarButtonItems([refresh, add], animated: true)
    }
    
    @objc private func addTaskList() {
        // add task list code here.
    }
    
    @objc private func refresh() {
        self.getTaskList()
    }
    
    private func getTaskList() {
        guard let projectId = projectId else {
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let projectRequest = TaskListService(projectId: projectId, successBlock: { [weak self] (tasklist) in
            MBProgressHUD.hideAllHUDs(for: self?.view, animated: true)
            self?.tasklistCollection = tasklist
            self?.tableView.reloadData()
            
        }) { [weak self] (error) in
            MBProgressHUD.hideAllHUDs(for: self?.view, animated: true)
            self?.showDialog(message: error.localizedDescription)
            self?.tasklistCollection.removeAll()
            self?.tableView.reloadData()
        }
        ClientAssembly.sharedAssembly.getClientManager().enqueueRequest(projectRequest)
    }

    private func showDialog(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Dismiss",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension TaskListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let taskListId = self.tasklistCollection[indexPath.row].id
        // Tasks controller will be here.
    }
}

extension TaskListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "tasklistCellIdentifier"
        var cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier
        )
        
        if cell == nil {
            cell = UITableViewCell(
                style: UITableViewCellStyle.value1,
                reuseIdentifier: reuseIdentifier
            )
        }
        
        let tasklist = self.tasklistCollection[indexPath.row]
        cell!.textLabel?.text = tasklist.name
        if let totalTasks = tasklist.uncompletedCount {
            cell!.detailTextLabel?.text = "\(String(describing: totalTasks)) tasks"
        } else {
            cell!.detailTextLabel?.text = "no task"
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasklistCollection.count
    }
}


