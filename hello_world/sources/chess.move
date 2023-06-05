
module Chess::game {
    // Part 1: imports
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use std::vector;
    use std::string;
    use sui::event;
    //use sui::test_scenario;

    const ChessBoardsize: u64 = 20;
    
    struct Game has key, store {
        id: UID,
        admin:address,
        chessBoard:vector<vector<Node>>,
        stepsCount: u64,
        player1 : address, 
        player2 : address,
    } 
    struct Node has store {
        value: u8
    }

    struct ChessEvent has copy, drop {
        name: string::String,
    }


    // Part 3: transfer the counter object to the sender
    entry public fun createChess(player1:address,  player2:address, ctx: &mut TxContext ) {
        // sender address
        let sender = tx_context::sender(ctx);
        let game_obj = Game {
            id: object::new(ctx),
            admin:sender,
            chessBoard: vector::empty<vector<Node>>(),
            stepsCount : 0,
            player1 : player1, 
            player2 : player2,
        };

        let i:u64 = 0;
        while(i < ChessBoardsize){
            let row = vector::empty<Node>();
            let j:u64 = 0;
            while(j < ChessBoardsize){
                let value:Node = Node{
                    value: 0
                };
                vector::push_back(&mut row, value);
                
                j = j + 1;
            };
            vector::push_back(&mut game_obj.chessBoard, row);
            i = i + 1;
        };
        transfer::transfer(game_obj, sender);
    }

    entry public fun setChessBoardValue(game: &mut Game,
                                        x:u64, y:u64,
                                        ctx: &mut TxContext
                                        ) {
        // sender address
        let sender = tx_context::sender(ctx);
        assert!(sender==game.admin, 0);

        assert!(x < ChessBoardsize, 0);
        assert!(y < ChessBoardsize, 0);
        let row = vector::borrow_mut(&mut game.chessBoard, x);
        let node = vector::borrow_mut(row, y);
        node.value = 1
        
    }

    entry public fun getChessBoardValue(game: &mut Game,
                                        x:u64, y:u64,
                                        ctx: &mut TxContext): u8{

         // sender address
        let sender = tx_context::sender(ctx);
        assert!(sender==game.admin, 0);

        assert!(x < ChessBoardsize, 0);
        assert!(y < ChessBoardsize, 0);
        let row = vector::borrow_mut(&mut game.chessBoard, x);
        let node = vector::borrow_mut(row, y);
        node.value
        
    }

    entry public fun play(game:&mut Game, x:u64, y:u64, ctx: &mut TxContext) {

        let sender = tx_context::sender(ctx);
        let currentSenderValue:u8;
        if (game.stepsCount % 2 == 0) {
            assert!(sender==game.player1, 0);
            currentSenderValue = 1;
        } else{
            assert!(sender==game.player2, 0);
            currentSenderValue = 2
        };





        assert!(x < ChessBoardsize, 0);
        assert!(y < ChessBoardsize, 0);
        let row = vector::borrow_mut(&mut game.chessBoard, x);
        let node = vector::borrow_mut(row, y);
        node.value = currentSenderValue;

        game.stepsCount = game.stepsCount + 1;
        if (game.stepsCount == ChessBoardsize * ChessBoardsize) {
            //send event, game board is full.
            let eventname= b"the chessBoard is full";

             event::emit(ChessEvent{
                name: string::utf8(eventname),
             });
            
        } else {

        };


        //todo: add check win logic, 
        {

        }

    }

    entry public fun resetGame(game: &mut Game, 
                                ctx: &mut TxContext) {
           // sender address
        let sender = tx_context::sender(ctx);
        assert!(sender==game.admin, 0);

         let i:u64 = 0;
        while(i < ChessBoardsize){
            let row = vector::borrow_mut(&mut game.chessBoard, i);
       
            let j:u64 = 0;
            while(j < ChessBoardsize){
              
                let node = vector::borrow_mut(row, j);
                node.value = 0;
                
                j = j + 1;
            };
            i = i + 1;
        };               
        game.stepsCount = 0;

    }



    #[test]
    public fun test_chess_init(){
        // let owner = @0xC0FFEE;
        // let user1 = @0xA1;


        // let scenario_val = test_scenario::begin(user1);
        // let scenario = &mut scenario_val;

        // test_scenario::next_tx(scenario, owner);
        // {
        //     createChess(test_scenario::ctx(scenario));
        // };

       

        // test_scenario::end(scenario_val);

    

    }
}




//https://suiexplorer.com/object/0xe9db03e16cc663e1a15e1f9caf462e4c19e6f9d20982482a2e9c1ae999367247?network=devnet