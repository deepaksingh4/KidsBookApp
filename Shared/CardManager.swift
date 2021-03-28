//
//  CardManager.swift
//  KidsUI
//
//  Created by Vivek Singh on 28/03/21.
//

import Foundation

class ContentManager {
    private var allBooks : [Book] = []
    
    init() {
        self.addBooks()
    }
    func getfeaturdBooks() -> [Book]{
        return allBooks.filter({ (book) -> Bool in
            return book.featurd
        })
    }
    
    func getRecentlyReadBooks() -> [Book]{
        return allBooks.filter({ (book) -> Bool in
            return book.recentlyRead
        })
    }
    
    func addBooks(){
        
        let bookTitle = ["Harry Potter and the Philosopher's Stone", "The Hunger Games", "The BFG", "The Very Hungry Caterpillar", "Winnie-the-Pooh"]
        let description = ["Harry Potter and the Philosopher's Stone is a fiction ", "The Hunger Games is all about strategy and war", "The BFG is unknown to me", "The Very Hungry Caterpillar sounds like someone with cravings", "Winnie-the-Pooh is all time favorite"]
        var featured = true
        
        for i in 1...5{
            featured = !featured
            
            let book = Book(id: i, title: bookTitle[i - 1], coverImage: "\(i)", featurd: featured, recentlyRead: true, oneLiner: description[i - 1])
            self.allBooks.append(book)
        }
    }
}


struct Book  : Identifiable{
    var id : Int
    var title : String
    var coverImage : String
    var featurd : Bool = false
    var recentlyRead : Bool = false
    var oneLiner : String
    
}

