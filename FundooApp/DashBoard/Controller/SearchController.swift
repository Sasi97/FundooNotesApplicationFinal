import Foundation
import UIKit
extension DashboardVC: UISearchBarDelegate {

//    func searchBarIsEmpty() -> Bool {
//        return searchBar.text?.isEmpty ?? true
//    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
       NotificationCenter.default.post(name: Notification.Name("SearchBarActive"), object: nil, userInfo: ["isSearching": isSearching])
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        NotificationCenter.default.post(name: Notification.Name("SearchBarEndEditing"), object: nil, userInfo: ["isSearching": isSearching])
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        NotificationCenter.default.post(name: Notification.Name("SearchButtonClicked"), object: nil, userInfo: ["isSearching": isSearching])
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.isHidden = true
         NotificationCenter.default.post(name: Notification.Name("EndSearching"), object: nil)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NotificationCenter.default.post(name: Notification.Name("SearchingNote"), object: nil, userInfo: ["searchText": searchText])
//        filteredArchiveNotes.removeAll()
//        filteredNotes.removeAll()
//        let searchPredicate = searchBar.text!
//        filteredNotes = listOfNotes.filter( {$0.title.lowercased().range(of: searchPredicate.lowercased()) != nil || $0.description.lowercased().range(of: searchPredicate.lowercased()) != nil})
////         filteredArchiveNotes = archivedNotes.filter( {$0.title.lowercased().range(of: searchPredicate.lowercased()) != nil || $0.description.lowercased().range(of: searchPredicate.lowercased()) != nil})
//        isSearching = (filteredNotes.count == 0 && filteredArchiveNotes.count == 0) ? false: true
//        notesCollectionView.reloadData()
    }


}

