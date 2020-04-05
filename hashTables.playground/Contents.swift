import UIKit

//Hash table function

var voter_hash: Dictionary<String, Bool?> = ["Bob" : false]

func check_voter(name: String, dict: inout Dictionary<String,Bool?>) {
    if dict[name] == nil {
        dict[name] = true
    } else {
        print("Name is already on the list. Kick out.")
    }
}

check_voter(name: "Alex", dict: &voter_hash)
check_voter(name: "Alex", dict: &voter_hash)
check_voter(name: "Gerald", dict: &voter_hash)

//Playing around with a graph hash

var graphHash: [String: Array<String>] = [:]

graphHash["you"] = ["alice", "bob", "claire"]

graphHash["bob"] = ["anuj", "peggy"]

graphHash["alice"] = ["peggy"]

graphHash["claire"] = ["thom", "jonny"]

graphHash["anuj"] = []; graphHash["peggy"] = []; graphHash["thom"] = []; graphHash["jonny"] = []

var arrayOne = [1,2,3]

var arrayTwo = [4,5,6]

arrayOne += arrayTwo


// Breadth First Search Implementatino

func breadthFirstSearch() -> Bool {
    
    var search_queue: [String] = []
    var searchedPeople : [String] = []
    
    //Add the array from graph[key] to the queue
    search_queue += graphHash["you"]!

    while search_queue.count > 0 {
        //Grab the first person off the queue
        let person = search_queue.removeFirst()
        
        //Check to see if person has already been searched
        if !searchedPeople.contains(person) {
            //Jonny is the Mango Seller
            if person == "jonny" {
                print("\(person) is the mango seller!")
                return true
                //Add person's friends to the queue
            } else {
                search_queue += graphHash[person]!
                //Add person to the searched list
                searchedPeople.append(person)
            }
            
        }
    }
    //No mango seller in the group
    return false
}

breadthFirstSearch()


// Dijkstra's Algorithm Implementation

//Graph dict stores nodes and weights
var graph = ["start" : ["a" : 6, "b" : 2],
             "a" : ["a" : nil, "finish" : 1],
             "b" : ["a" : 3, "finish" : 5]]

//Cost dict stores initial and eventual cost
let infinity = Double.greatestFiniteMagnitude
var cost = ["a" : 6, "b" : 2, "fin" : infinity]

//Parents dict stores initial and future parents
var parents = ["a" : "start", "b" : "start", "a" : "b", "finish" : "a", "finish" : "b"]

//Processed nodes array
var processed: [String] = []
