//
//  ContentView.swift
//  TestNavStack
//
//  Created by Tim Yoon on 12/9/22.
//

import SwiftUI
struct Person: Identifiable, Hashable {
    var id: String? = UUID().uuidString
    var name = ""
    var imageName = ""
    var logs: [String] = []
}

enum PersonViewType: CaseIterable {
    case string, image
}
class PersonListVM: ObservableObject {
    @Published var persons: [Person] = []
    init(){
        persons.append(Person(name: "John", imageName: "person", logs: ["hellow", "goodbey"]))
        persons.append(Person(name: "Mary", imageName: "photo", logs: ["Christopher", "🥹"]))
    }
}
struct PersonImageView: View {
    let person: Person
    
    var body: some View {
        
        VStack {
            Image(systemName: person.imageName)
            List {
                ForEach(person.logs, id: \.self) { log in
                    NavigationLink {
                        LogStringView(person: person, log: log)
                    } label: {
                        Text("\(log)")
                    }
                    
                    
                }
            }
        }
    }
    
}

struct LogStringView: View{
    let person: Person
    let log: String
    
    var body: some View{
        Text(log)
    }
}

struct PersonStringView: View {
    let person: Person
    var body: some View {
        Text("Name: \(person.name)")
    }
}
struct ContentView: View {
    @StateObject var vm = PersonListVM()
    @State private var selectedPerson: Person?
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(vm.persons) { person in
                    NavigationLink(value: person) {
                        Text("\(person.name)")
                    }
                }
            }
            .navigationDestination(for: Person.self){ person in
                PersonImageView(person: person)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
