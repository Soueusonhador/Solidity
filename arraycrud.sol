// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CryptoChoice {
    
    struct Choice {
        uint id;
        address hash;
    }
      
    Choice[] listaDeHash;
        
    function inserirHash(uint _id, address _hash) public {                      
        listaDeHash.push(Choice(_id, _hash));
    }   
   
    function obterHashs() view public returns (Choice[] memory ) {
        return listaDeHash;
    }     

    function obterHash(uint _indice) view public returns (uint id, address hash) {
         Choice storage h = listaDeHash[_indice];
        
        return (h.id, h.hash);
    }

    function atualizarHash(uint _indice, uint _id, address _hash) external {
        Choice storage h = listaDeHash[_indice];
        h.id = _id;
        h.hash = _hash;
        listaDeHash[_indice] = h;
    }
    
    function deletarHash(uint _indice) external {
        delete listaDeHash[_indice];
    }
    
    function totalDeHashes() view public returns (uint) {
        return listaDeHash.length;
    }
}