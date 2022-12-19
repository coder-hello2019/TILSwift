import UIKit

import SwiftUI
import PlaygroundSupport

/* Generics - fundamentals
 
 - Useful when manipulating data structures that we're type-agnostic about. But the problem is that Swift is very strongly-typed i.e. doesn't like 'untyped' variables. Types allow the compiler to look at our code and figure out if it's likely to work.
 - So we use a 'don't care type' if we don't care what type something is. E.g. Arrays are able to work with different element types. It's probs defined something like:
 
    Struct Array<Element> {
        func append(_ element: Element) {...}
    }
 
    var a= Array<Int>() -->> so we need to tell the code what 'Element' is. This allows the compiler to type-check.
 
 - It's legal to have multiple 'don't care' types i,e, 'type parameters' e.g. Array<Element, Foo>
 
 - Generics can be combined with parameters - see Lecture 6.
 
 */


struct BookNote {
    var author: String?
    var title: String?
}

struct PublishedNote {
    var author: String?
    var title: String?
    
    var isPublished: Bool
}

struct NoteView<Note>: View {
    var note: Note
    
    var body: some View {
        VStack {
            Text("yo hithere")
            Text(note.title ?? "no title")
        }
        .padding()
    }
}

struct ContentView: View {
    
    var testNote = BookNote(author: "Jack Edwards", title: "UniversiTEA")
    
    var body: some View {
        Text("Author: \(testNote.author ?? "none"), title: \(testNote.title ?? "none")")
        NoteView<BookNote>(note: testNote)
//        Text("Swift Wombating")
//            .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())



