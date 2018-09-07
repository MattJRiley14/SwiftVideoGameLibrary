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
    private var gameArray: [Game] = [
        Game(title: "Mario Kart", rating: "E"),
        Game(title: "Fruit Ninja", rating: "E"),
        Game(title: "EA Sports UFC", rating: "T"),
        Game(title: "Worms", rating: "E"),
        Game(title: "Gears of War", rating: "M")]
    
    //MARK:- Functions
    
    func addGame() {
        print("Please enter password: ")
        
        var enteredPassword = readLine()
        
        while enteredPassword != "Izaak" {
            print("Incorrect password")
            enteredPassword = readLine()
        }
        
        // When we make a new game, we need a title for the game.
        // Prompt the user to enter in the title for the new game.
        print("Please enter the title of the game: ")
        // We need to be able to get user input for the title.
        var newGameTitle = readLine()
        
        // We need to add input validation to make sure that the newGameTitle isn't nil or an empty string
        while newGameTitle == nil || newGameTitle == "" {
            print("Invalid title, please try again: ")
            newGameTitle = readLine()
        }
        
        print("Plase enter the rating of the game: ")
        
        var newGameRating: String? = nil
        
        repeat {
            let line = readLine()!
            if line == "M" || line == "T" || line == "E" {
                newGameRating = line
            } else {
                print("Invalid rating. Please enter a valid rating: ")
            }
        } while newGameRating == nil
        
        // We need to create a new game object using that title.
        let newGame = Game(title: newGameTitle!, rating: newGameRating!)
        // We need to add the game to our gameArray.
        gameArray.append(newGame)
        
        // Placeholder: Since we don't have a way to list our games yet, this will go through each game and print the title
        for game in gameArray {
            print("\(game.title) \(game.rating)")
        }
    }
    
    func removeGame() {
        print("Please enter password: ")
        
        var enteredPassword = readLine()
        
        while enteredPassword != "Christian" {
            print("Incorrect password")
            enteredPassword = readLine()
        }
        
        // We need to go through our array and list out the title of the game as well as it's index. The user can then enter an index and we'll remove the game at that index.
        for index in 0..<gameArray.count { // Go through each index in the gameArray. Since arrays start at index 0, our indexes will go from 0 to 1 less than the number of elements in the array
            print("\(index). \(gameArray[index].title) \(gameArray[index].rating)")
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
    
    func getAvailableGames() -> [Game] {
        var availableGames = [Game]()
        
        for game in gameArray {
            if game.checkedIn {
                availableGames.append(game)
            }
        }
        return availableGames
    }
    
    func listAvailableGames() {
        //We need to go through our gameArray, and check to see if each game is checked out or not. If it isn't, print out the title of the game.
        
        //        gameArray[0].checkedIn = false // This will check out the first game in the array for testing
        
        // 0. Get available games
        let availableGames = getAvailableGames()
        
        if availableGames.count == 0 {
            print("There are currently no games available for checkout.")
        }
        
        for game in gameArray {
            if game.checkedIn {
                print("\(game.title) \(game.rating)")
            }
        }
    }
    
    func getUnavailableGames() -> [Game] {
        var unavailableGames = [Game]()
        
        for game in gameArray {
            if game.checkedIn == false {
                unavailableGames.append(game)
            }
        }
        return unavailableGames
    }
    
    func listUnavailableGames() {
        //We need to go through our gameArray, and check to see if each game is checked out or not. If it is, print out the title of the game.
        //        gameArray[0].checkedIn = false // This will check out the first game in the array for testing
        
        let unavailableGames = getUnavailableGames()
        
        if unavailableGames.count == 0 {
            print("There are currently no games checked out.")
        }
        
        for game in gameArray {
            if !game.checkedIn {
                print("\(game.title) \(game.rating)")
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
        
        // 0. Get available games
        let availableGames = getAvailableGames()
        
        if availableGames.count == 0 {
            print("Sorry, but there are currently no games available for checkout.")
        } else {
            // 1. Print out available games. We also need to set the due date for the game.
            for index in 0..<availableGames.count {
                print("\(index). \(availableGames[index].title) \(availableGames[index].rating)")
            }
            
            // 2. Ask the user for the index of the game to check out.
            print("Please enter the index of the game you wish to check out: ")
            
            // 3. Getting user input
            var index: Int? = nil
            
            // 4. Validate user input
            repeat {
                // 1. Get user input
                var userInput = Int(readLine()!)
                
                // 2. Validate user input is an Int
                while userInput == nil {
                    print("Invalid input. Please enter a valid index.")
                    userInput = Int(readLine()!)
                }
                
                // 3. Validate user input is within array bounds.
                if userInput! >= 0 && userInput! < availableGames.count {
                    // If input is valid, set index equal to user input.
                    index = userInput!
                } else {
                    // If input is not valid, tell the user and let the while loop continue.
                    print("Invalid input. Please enter a valid index.")
                }
            } while index == nil
            
            if availableGames[index!].rating == "M" || availableGames[index!].rating == "T" {
                print("You have chosen a game with a \(availableGames[index!].rating) rating. Please enter your age")
                
                var age = Int(readLine()!)
                
                while age == nil {
                    print("Invalid input. Please enter a valid index.")
                    age = Int(readLine()!)
                }
                if let age = age {
                    if availableGames[index!].rating == "M" {
                        if age < 17 {
                            print("Sorry, but you are not old enough to rent this game.")
                            menu.go()
                        }
                    }
                    if availableGames[index!].rating == "T" {
                        if age < 13 {
                            print("Sorry, but you are not old enough to rent this game.")
                            menu.go()
                        }
                    }
                }
            }
            
            
            // 5. Check game out.
            
            availableGames[index!].checkedIn = false
            
            // We also need to set the due date for the game.
            let currentCalendar = Calendar.current // This gets the currect calendar for the user
            let dueDate = currentCalendar.date(byAdding: .day, value: 14, to: Date()) // This generates a new Date object 2 weeks in the future by adding 14 days to the currect date
            
            gameArray[index!].dueDate = dueDate // Set the due date of the game being checked out to the new date 2 weeks in the future
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            print("This game is due back by: \(dateFormatter.string(from: dueDate!))")
        }
    }
    
    func checkGameIn() {
        
        let unavailableGames = getUnavailableGames()
        
        if unavailableGames.count == 0 {
            print("Sorry, but there are currently no games checked out.")
        } else {
            
            for index in 0..<unavailableGames.count {
                print("\(index). \(unavailableGames[index].title) \(unavailableGames[index].rating)")
            }
            
            // Ask the user for the index of the game to check in.
            print("Please enter the index of the game you wish to check in: ")
            
            var index: Int? = nil
            
            repeat {
                // Ge the input from the user and validate it.
                var userInput = Int(readLine()!)
                
                // If user has entered something that can't be converted to an Int, make them put in more input
                while userInput == nil {
                    print("Invalid input. Please enter a usable index.")
                    userInput = Int(readLine()!)
                }
                // 3. Validate user input is within array bounds.
                if userInput! >= 0 && userInput! < unavailableGames.count {
                    // If input is valid, set index equal to user input.
                    index = userInput!
                } else {
                    // If input is not valid, tell the user and let the while loop continue.
                    print("Invalid input. Please enter a valid index.")
                }
            } while index == nil
            
            
            // Check the selected game in.
            unavailableGames[index!].checkedIn = true
            
            unavailableGames[index!].dueDate = nil // Since the game is checked in, we don't need a due date anymore, so set this equal to nil
        }
    }
}




