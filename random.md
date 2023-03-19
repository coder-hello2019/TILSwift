# A doc of random tidbits of Swift  and SwiftUI wisdom picked up while coding

## Swift UI

| Question / topic | Answer | Relevant links |
|------------------|--------|----------------|
| When is it better to create customer view modifiers, as opposed to just using an extension? | No clear answer - it's a matter of preference / good practice. | Helpful SO discussion [here](https://stackoverflow.com/questions/57411656/difference-between-creating-viewmodifier-and-view-extension-in-swiftui).| 
| Architecture / design patterns | Why bother with delegates in MVVM? We've already got ObservableObjects etc. | * Similar in spirit in that both achieve communication between the View and the VM.
* However, ObservableObjects are more passive. Delegates allow you to be more selective about what events you respond to - it's a 'reactive' pattern. ObservableObjects on the other hand just notify all other interested parties of changes (e.g. in the Model). |

