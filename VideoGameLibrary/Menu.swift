//
//  Menu.swift
//  VideoGameLibrary
//
//  Created by Matthew Riley on 8/30/18.
//  Copyright © 2018 Matthew Riley. All rights reserved.
//

import Foundation

//Video Game Library
//1 Add game
//2 Remove game
//3 List games available
//4 Check out game
//5 Check in game
//6 List checked out games
//7 Help
//8 Quit

// 2 - Menu
// 1 - Game Model
// 0 - Library Array

// 1. Print options
// 2. Select options & run
// 3. Accept & validate input

class Menu {
    var shouldQuit = false
    
    let library = Library() // Create a new instance of the Library class
    
    func go() {
        // Display the menu
        help()
        
        repeat {
            var input = getInput()
            
            while validateInput(input) == false {
                print("Invalid input")
                input = getInput()
            }
            handleInput(input)
        } while !shouldQuit
    }
    
    // Function to display video game menu
    func help() {
        print("""

    Menu
    1 Add game
    2 Remove game
    3 List games available
    4 Check out game
    5 Check in game
    6 List checked out games
    7 Help
    8 Quit
    
    """)
    }
    
    // Switch is like a big if statement
    func handleInput(_ input: String) {
        switch input {
        case "1": // if input == 1
            library.addGame() // Call the library's addGame function
            help() // Show the menu again
        case "2": // if input == 2
            library.removeGame() // Call the library's removeGame function
            help() // Show the menu again
        case "3": // if input == 3
            library.listAvailableGames() // Call the library's listAvailableGames function
            help() // Show the menu again
        case "4": // if input == 4
            library.checkGameOut() // Call the library's checkGameOut function
            help() // Show the menu again
        case "5": // if input == 5
            library.checkGameIn() // Call the library's checkGameIn function
            help() // Show the menu again
        case "6": // if input == 6
            library.listUnavailableGames() // Call the library's listUnavailableGames function
            help() // Show the menu again
        case "7": // if input == 7
            help() // Show the menu
        case "8": // if input == 8
            quit() // Call the quit function
        default: // if input is anything else
            break
        }
    }
    
    func quit() {
        print("Are you sure you would like to quit? Y or N?")
        let input = readLine()!
        if input.lowercased() == "y" {
            shouldQuit = true
            print("Thanks for using the video game library")
        }
    }
    
    func validateInput(_ input: String) -> Bool {
        let menuOptions = Array(1...8)
        
        guard let number = Int(input) else {return false}
        
        return menuOptions.contains(number)
    }
    
    func getInput() -> String {
        var input: String? = nil
        repeat {
            let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if line != "" {
                input = line
            } else {
                print("Invalid input.")
            }
        } while input == nil
        
        return input!
    }
}
















