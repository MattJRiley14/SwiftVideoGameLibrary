//
//  Library.swift
//  VideoGameLibrary
//
//  Created by Matthew Riley on 9/4/18.
//  Copyright © 2018 Matthew Riley. All rights reserved.
//

import Foundation

// This class will handle storing our array of Games. It will also handle all the interactions with that array.
class Library {
    // An array of Game objects that will be handled by this class
    private var gameArray: [Game] = [Game(title: "Mario Kart"), Game(title: "Fruit Ninja"), Game(title: "EA Sports UFC"), Game(title: "Worms")]
    
    //MARK:- Functions
    
    func addGame() {
        // When we make a new game, we need a title for the game.
        // Prompt the user to enter in the title for the new game.
        print("Please enter the title of the game: ")
        // We need to be able to get user input for the title.
        var newGameTitle = readLine()
        
        // We need to add input validation to make sure that the newGameTItle ins't nil or an empty string
        while newGameTitle == nil || newGameTitle == "" {
            print("Invalid title, please try again: ")
            newGameTitle = readLine()
        }
        // We need to create a new game object using that title.
        let newGame = Game(title: newGameTitle!)
        // We need to add the game to our gameArray.
        gameArray.append(newGame)
        
        // Placeholder: Since we don't have a way to list our games yet, this will go through each game and print the title
        for game in gameArray {
            print(game.title
            )
        }
    }
    
    func removeGame() {
        // We need to go through our array and list out the title of the game as well as it's index. The user can then enter an index and we'll remove the game at that index.
        for index in 0..<gameArray.count { // Go through each index in the gameArray. Since arrays start at index 0, our indexes will go from 0 to 1 less than the number of elements in the array
            print("\(index). \(gameArray[index].title)")
        }
        print("Please enter the index of the game you wish to remove: ")
        
        var userInput = Int(readLine()!)
        
        // If user has entered something that can't be converted to an Int, make them put in more input
        while userInput == nil {
            print("Invalid input. Please enter a usable index.")
            userInput = Int(readLine()!)
        }
        // Removing the game at the index the user specified
        gameArray.remove(at: userInput!)
    }
    
    func listAvailableGames() {
        //We need to go through our gameArray, and check to see if each game is checked out or not. If it isn't, print out the title of the game.
        
        //        gameArray[0].checkedIn = false // This will check out the first game in the array for testing
        
        for game in gameArray {
            if game.checkedIn {
                print(game.title)
            }
        }
    }
    
    func listUnavailableGames() {
        //We need to go through our gameArray, and check to see if each game is checked out or not. If it is, print out the title of the game.
        //        gameArray[0].checkedIn = false // This will check out the first game in the array for testing
        
        for game in gameArray {
            if !game.checkedIn {
                print(game.title)
                if let dueDate = game.dueDate {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy" // Setting the format we want to use for the dateFormatter. In this case, it will use 2 digits for the month, 2 digits for the day, and 4 digits for the year.
                    print("This game is due back by: \(dateFormatter.string(from: dueDate))") // This will make a string from the dueDate using the format we've specified above.
                }
            }
        }
    }
    
    func checkGameOut() {
        //We need to go through our gameArray, list out each game and its index, and take user input for which game they want to check out.
        
        // We also need to set the due date for the game.
        for index in 0..<gameArray.count {
            print("\(index). \(gameArray[index].title)")
        }
        print("Please enter the index of the game you wish to check out: ")
        
        var userInput = Int(readLine()!)
        
        // If user has entered something that can't be converted to an Int, make them put in more input
        while userInput == nil {
            print("Invalid input. Please enter a usable index.")
            userInput = Int(readLine()!)
        }
        gameArray[userInput!].checkedIn = false
        
        // We also need to set the due date for the game.
        let currentCalendar = Calendar.current // This gets the currect calendar for the user
        let dueDate = currentCalendar.date(byAdding: .day, value: 14, to: Date()) // This generates a new Date object 2 weeks in the future by adding 14 days to the currect date
        
        gameArray[userInput!].dueDate = dueDate // Set the due date of the game being checked out to the new date 2 weeks in the future
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        print("This game is due back by: \(dateFormatter.string(from: dueDate!))")
    }
    
    func checkGameIn() {
        for index in 0..<gameArray.count {
            print("\(index). \(gameArray[index].title)")
            
            print("Please enter the index of the game you wish to check in: ")
            
            var userInput = Int(readLine()!)
            
            // If user has entered something that can't be converted to an Int, make them put in more input
            while userInput == nil {
                print("Invalid input. Please enter a usable index.")
                userInput = Int(readLine()!)
            }
            gameArray[userInput!].checkedIn = true
            
            gameArray[userInput!].dueDate = nil // Since the game is checked in, we don't need a due date anymore, so set this equal to nil
        }
    }
}




