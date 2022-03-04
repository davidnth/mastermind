# Mastermind
In this project I built a mastermind game from command line. In the original game, one player creates a code - a sequence of 4 colors of which there are 6 to choose from and the other player's objective is to guess this code. For this project, I've chosen to use numbers instead of colors - the code is a sequence of 4 digits each being between 1-6.

The player is able to assume the role of the code guesser or creator. 

## Guesser 
The guesser is allowed 12 attempts to guess the code. With each guess, the guesser is given feedback in the form of the number of correct guesses - correct numbers in the correct order in the sequence and the number of partially correct guesses - correct numbers but in the incorrect order in the sequence. 

## Creator 
I've implemented a bot in this game which uses the [Swaszek](https://puzzling.stackexchange.com/questions/546/clever-ways-to-solve-mastermind) strategy. On average this bot guesses the code created by the user in 5 or less turns. 

## What have I learnt?
This project was another great introduction to object oriented programming. As the bot/computer shared much the same functions as the guesser/player, I made use of class inheritance here which I think was the biggest takeaway. 