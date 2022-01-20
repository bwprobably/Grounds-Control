//
//  CoffeListViewController.swift
//  Grounds Control
//
//  Created by Brett on 10/21/21.
//

import UIKit
import CoreData

class CoffeeListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var coffeeCountLbl: UILabel!
    private let searchController = UISearchController()
    
    
    private var fetchedResultsController: NSFetchedResultsController<Coffee>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        configureSearchBar()
        setupFetchedResultsController()
        refreshCountLbl()
        tableView.reloadData()
    }
    
    
    func refreshCountLbl(){
        let count = fetchedResultsController.sections![0].numberOfObjects
        coffeeCountLbl.text = "\(count) \(count == 1 ? "drinks recorded" : "drinks recorded")"
    }
    
    func setupFetchedResultsController(filter: String? = nil){
        fetchedResultsController = coreDataMngr.shared.createNotesFetchedResultsController(filter:filter)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        refreshCountLbl()
    }
    
    func setupScopeFilterREsults(filter: String? = nil){
        //TODO: Scope Filter
    }
    
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.scopeButtonTitles = ["All","Garbage", "Just \"OK\"","Outstanding"]
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    @IBAction func createNewNoteClicked(_ sender: UIButton) {
        goToEditNote(createNote())
    }
    
    
    private func goToStats(_ drink: Coffee){
        let controller = storyboard?.instantiateViewController(withIdentifier: CoffeeStatsView.identifier) as! CoffeeStatsView
        navigationController?.pushViewController(controller, animated: true)
        controller.items = drink
    }
    
    private func goToEditNote(_ drink: Coffee) {
        let controller = storyboard?.instantiateViewController(identifier: EditCoffeeController.identifier) as! EditCoffeeController
        
        controller.drink = drink
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func createNote() -> Coffee {
        let drink = coreDataMngr.shared.createNote()
        refreshCountLbl()
        return drink
    }
    
    private func deleteNoteFromStorage(_ drink: Coffee) {
        coreDataMngr.shared.deleteNote(drink)
        // Update the list
       
    }

    
}


// MARK: - Tableview Config

extension CoffeeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return fetchedResultsController.sections?.count ?? 1
        }
        let notes = fetchedResultsController.sections![section]
        return notes.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoffeeListTableViewCell.identifier) as! CoffeeListTableViewCell
        let drink = fetchedResultsController.object(at: indexPath)
        cell.setup(drink: drink)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = fetchedResultsController.object(at: indexPath)
        goToEditNote(note)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = fetchedResultsController.object(at: indexPath)
            deleteNoteFromStorage(note)
            refreshCountLbl()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self]
            (action, view, completionHandler) in
            let note = self.fetchedResultsController.object(at: indexPath)
            goToEditNote(note)
            completionHandler(true)
        }
        
        editAction.backgroundColor = UIColor(red: 255/255.0, green: 200/255.0, blue: 1/255.0, alpha: 1)
        
        let statsAction = UIContextualAction(style: .normal, title: "Stats") { [self]
            (action, view, completionHandler) in
            let note = self.fetchedResultsController.object(at: indexPath)
            goToStats(note)
                completionHandler(true)
            }
        statsAction.backgroundColor = UIColor(red: 80/255.0, green: 160/255.0 , blue: 204/255.0, alpha: 1.0)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [editAction, statsAction])
                // Delete should not delete automatically
                swipeConfiguration.performsFirstActionWithFullSwipe = true
    
                return swipeConfiguration
    }

}



// MARK: - Serch Controller Config
extension CoffeeListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("new scope index is \(selectedScope)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text ?? "")
    }
    
    func search(_ query: String) {
        if query.count >= 1 {
           setupFetchedResultsController(filter: query)
        } else{
            setupFetchedResultsController()
        }
        
        tableView.reloadData()
    }
    
    //TODO: Fix Scope Filter
    func scope(_ query: String) {
        if query.count >= 0 {
            
        }
    }
}



//MARK: - NSFetchedResults Controller Delegate
extension CoffeeListViewController: NSFetchedResultsControllerDelegate {
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        default: tableView.reloadData()
        }
    }
}


