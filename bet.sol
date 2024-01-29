/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "hardhat/console.sol";

contract Bet {
        
    address public owner;
    uint256 public totalBetValue;
    uint256 public totalBetAmount;
    address private escolhido;

    struct Player {        
        address addressPlayer;
        uint256 betValue;           
     }  

    
    Player[] public playerBets;
      
    modifier isOwner() {
        require(msg.sender == owner, "Somente o owner pode chamar esse metodo!");
        _;
    }
    
    event Winner(address indexed addressPlayer, uint256 valueToPaywinner, uint256 valueToHost);

    constructor () {
        owner = msg.sender; 
        totalBetValue = 0;
        totalBetAmount = 0;      
    }

   function bet(uint256 betValue) public payable {
        
        totalBetAmount++; 
       // uint256 betValue = msg.value;
        console.log("Valor apostado:", betValue);            
        playerBets.push(Player(msg.sender, betValue));
        totalBetValue += betValue;
        console.log("Valor total apostado:", totalBetValue);
    }
                         
    function escolher() public isOwner {
        uint256  i;
        escolhido = playerBets[i].addressPlayer;
        console.log(escolhido);

}
       

    function paywinners() public isOwner {                  

        for (uint i=0; i < playerBets.length; i++) {
            if (playerBets[i].addressPlayer == escolhido)
            {               
                uint256 valueToPaywinner = (totalBetValue * 80) / 100 ;  
                uint256 valueToHost = totalBetValue - valueToPaywinner;
                payable(playerBets[i].addressPlayer).transfer(valueToPaywinner);
                payable(owner).transfer(valueToHost);
                emit Winner(playerBets[i].addressPlayer,valueToPaywinner, valueToHost); 
               
            }
        }                      
    }
}