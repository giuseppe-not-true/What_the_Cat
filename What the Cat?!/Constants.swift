//
//  Constants.swift
//  What the Cat?!
//
//  Created by Giuseppe Falso on 04/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

enum GameState {
    case mainScreen
    case playing
//    case gameOver
}

//Ingredients types

let ingredients = [
    Ingredient(imageNamed: "ingredient-atom"),
    Ingredient(imageNamed: "ingredient-belt"),
    Ingredient(imageNamed: "ingredient-boot"),
    Ingredient(imageNamed: "ingredient-lightbulb"),
    Ingredient(imageNamed: "ingredient-dirt"),
    Ingredient(imageNamed: "ingredient-bread-jam"),
    Ingredient(imageNamed: "ingredient-discoball"),
    Ingredient(imageNamed: "ingredient-fish"),
    Ingredient(imageNamed: "ingredient-nekonomicon"),
    Ingredient(imageNamed: "ingredient-bow"),
    Ingredient(imageNamed: "ingredient-scepter"),
    Ingredient(imageNamed: "ingredient-sword")
]

let ingredientsName = ["atom", "belt", "boot", "lightbulb", "dirt", "bread-jam", "discoball", "fish", "nekonomicon", "bow", "scepter", "sword"]

//Cat types

let ordinaryCattos = [SKTexture(imageNamed: "catto-1"), SKTexture(imageNamed: "catto-2"), SKTexture(imageNamed: "catto-3"), SKTexture(imageNamed: "catto-4"), SKTexture(imageNamed: "catto-5"), SKTexture(imageNamed: "catto-6")]

let firstTierCats: [String: (String, String, String)] = [
    "Warrior Cat": ("A cat perfect for any fight.", "catto-warrior", "sword"),
    "Hunter Cat": ("No more mice.", "catto-hunter", "bow"),
    "Wizard Cat": ("It’s so soft it is magical.", "catto-wizard", "scepter"),
    "Cat in the Boot": ("Just a chilling ball of fluff.", "catto-boot", "boot"),
    "Funky Cat": ("These cats are made for dancing!", "catto-funky", "discoball"),
    "Anti-gravitational Cat": ("A living feline paradox.", "catto-jam", "bread-jam"),
    "Nuclear Cat": ("Look! It glows in the dark!", "catto-atom", "atom"),
    "Eurekat": ("Such a brilliant kitty.", "catto-eureka", "lightbulb"),
    "Shrekat": ("Kittens are like onions", "catto-shrek", "dirt"),
    "Chubby Cat": ("Maybe too fluffy, but surely lovable.", "catto-chubby", "fish"),
    "Evil Cat": ("Dangerous, but really cute.", "catto-evil", "nekonomicon"),
    "Karate Cat": ("A cat trained for the strongest cuddles.", "catto-karate", "belt")]

let secondTierCats: [String: (String, String, String)] = [
    "Pope Cat": ("Holy cat!", "catto-pope", "scepter lightbulb"),
    "Puss in Boots": ("Legendary swordmaster and cute looking kitty.", "catto-puss-in-boots", "sword boots"),
    "Nyan Cat": ("nyan nyan nyan nyan nyan nyan nyan…", "catto-nyan", "discoball bread-jam"),
    "Catfish": ("What did you expect?", "catto-fish", "atom fish"),
    "Exploding Kitty": ("A kickstarterbreaking cat.", "catto-exploding", "dirt atom"),
    "Nekomancer": ("Master of dark arts and napping.", "catto-nekomancer", "scepter nekonomicon"),
    "Subfeline": ("It comes with portholes!", "catto-subfeline", "lightbulb fish"),
    "Uncat": ("It kinda smells, but at least it doesn't need food.", "catto-uncat", "dirt nekonomicon"),
    "Ninja Cat": ("Silent and stealthy, ready to attack!", "catto-ninja", "bow belt"),
    "Jedi Cat": ("The powers of the force, in a little fluffy kitty.", "catto-jedi", "sword lightbulb"),
    "Supercat": ("It can fly and lift buildings, probably it will just take a nap.", "catto-super", "atom belt")]

let thirdTierCats: [String: (String, String, String)] = [
    "Sith Cat": ("Join the fluffy side of the force.", "catto-sith", "sword lightbulb nekonomicon"),
    "Cat Norris": ("On the 7th day, God rested … Cat Norris took over.", "catto-norris", "boots dirt belt"),
    "Purrrada": ("The coolest and most stylish of all cats.", "catto-prada", "boots discoball belt"),
    "Cathulhu": ("A great fluff one, fear it.", "catto-cathulhu", "dirt fish nekonomicon"),
    "Dalai Cat": ("Be fluffy whenever possible. It is always possible.", "catto-dalai", "atom discoball lightbulb")]

let mistakesCats:  [String: (String, String)] = [
    "Ordinary Cat": ("Just an ordinary, cute little kitty.", "catto-1"),
    "Dogezilla": ("", ""),
    "Filimi": ("", ""),
    "Cat-astrophe": ("Wh-What have you done…", "catto-catastrophe"),
    "Cat in the Box": ("", "")]

//Quest types

let firstLevelQuests: [String: [String]] = [
    "Warrior Cat": ["I need a cat that can fight with me!", "I'm a soldier, but I wish I had a cat…", "If only I had a cat that could slay dragons…"],
    "Hunter Cat": ["I feel so alone while hunting…", "I have a problem with some mice… on the roof.", "I'm so bored… and all I have are these apples"],
    "Wizard Cat": ["I have to study some ancient runes but I don't want to do it alone.", "Fireball!", " I need someone that could help me with my homeworks!"],
    "Cat in the boot": ["I only have one leg and a lot of spare shoes!", "I have a snake in my boot!", "I want something to keep my feets warm…"],
    "Funky Cat": ["I just want to party!", "ah-ah-ah-ah stayin alive stayin alive… ", "Let’s have some fun!"],
    "Anti-gravitational Cat": ["I'm studying the paradox of physics, do you have something that can help?", "It’s so hot today, do you have a fan or something?", "If only I had something to make my boat go faster…"],
    "Nuclear Cat": ["I need more energy for my experiments!", "I want a shiny one!", "I want to be easy to find in the dark."],
    "Eurekat": ["I really need an idea…", "I have the solution on the tip of my tongue…", "What do you say when you find the perfect cat?"],
    "Shrekat": ["SOMEbody once told me the world is gonna roll me...", "I love dirty kitties.", "I need a cat that likes donkeys."],
    "Chubby Cat": ["I love eating, I want a cat like me!", "I want a slow cat", "I just want to eat and sleep with my cat"],
    "Evil Cat": ["I don’t like “good boys” ", "I drink orange juice after washing my teeths.", "I hate the world! "],
    "Karate Cat": ["I love Street Fighting", "I need someone to train me!", "Wax on Wax off…"]]

let secondLevelQuests: [String: [String]] = [
    "Pope Cat": ["I’d love to bring my cat to church!", "I need a cat to heal the wounds of my soul", "Some holy magic would help me"],
    "Puss in Boots": ["I want a cat that can do this “*-*” ", "I need a heroic swordsman!", "There was a fairytale about a cat…"],
    "Nyan Cat": ["Nyan nyan nyan nyan nyan nyan", "I had the strangest dream.. there was this magic cat with hypnotic music and a rainbow…", "Ehy, what about a flying and singing cat?"],
    "Catfish": ["I heard that someone has seen a cat mermaid!", "Is there any cat that can swim?", "I discovered the girl I was talking to was actually a married man, do you have any advice?"],
    "Exploding Kitty": ["BOOM", "Do you have a cat that can help in the mines?", "I heard about this card game that broke every record…"],
    "Nekomancer": ["I need someone to help me do my blood rituals", "I'm trying to summon the dark lord, any advice?", "I love sacrifices and kittens, something for me?"],
    "Subfeline": ["We all live in a yellow…", "I love deep diving but I'd like more light…", "If only there was a way to travel by sea and have a look at what's under the water…"],
    "Uncat": ["I’d love to have a cat that doesn't need food or water… or air.", "I’d love to have someone to keep me company at the cemetery.", "I loved my old cat, I don't want another one."],
    "Ninja Cat": ["I need a cat that is deadly silent.", "I love being one with the shadows…", "I want to be Hokage!"],
    "Jedi Cat": ["May the force be with you.", "What about a Space Paladin?", "I’d love a cat that can bring me things with telekinesis"],
    "Supercat": ["Is it a bird? is it a plane? it’s…", "I need the most heroic cat you have!", "What about a flying cat?"]]

let thirdLevelQuests: [String: [String]] = [
    "Sith Cat": ["May the force be with you, but make it evil", "What about a Space AntiPaladin?", "I'd love a cat that can take things with telekinesis and throw them on the face of random people!"],
    "Cat Norris": ["I want the strongest cat you have!", "I'm a ranger that loves to walk in Texas", "For the eyes of the ranger are upon you!"],
    "Purrrada": ["I want the most fabulous cat you have!", "I’ve seen the scariest woman in the world! Her name was ”Miranda”", "Im going to the Fashion week, help me!"],
    "Cathulhu": ["ph'nglui mglw'nafh Cathulhu R'lyeh wgah'nagl fhtagn.", "I just want to destroy the world…", "I keep hearing strange voices from the deep…"],
    "Dalai Cat": ["I wish to reach Nirvana", "I want more clarity in my life", "I just wish for a guide"]]
