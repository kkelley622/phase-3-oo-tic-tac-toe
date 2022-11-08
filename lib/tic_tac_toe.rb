require "pry"

class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]

    ]

    def initialize(board=[" ", " ", " ", " ", " ", " ", " ", " ", " "])
        @board = board
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
        puts "-----------"
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end

    def turn_count
        @board.count{ |space| space != " "}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end
    
    def turn
        puts "Please enter a number (1-9): "
        user_input = gets.strip
        idx = input_to_index(user_input)
        if valid_move?(idx)
            move(idx, current_player)
            display_board
        else
            puts "Invalid Position"
            turn
        end
    end


    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            @board[win_combo[0]] == @board[win_combo[1]] && @board[win_combo[1]] == @board[win_combo[2]] && position_taken?(win_combo[1])
        end
    end

    def full? 
        !@board.any?(" ")
    end

    def draw?
        full? && !won? 
    end

    def over?
        draw? || won?
    end

    def winner
        if win_combo = won?
            @board[win_combo[0]]
        end
    end

    def play 
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end