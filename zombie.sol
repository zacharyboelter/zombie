pragma solidity ^0.4.25;

contract ZombieFactory {                        //name of contract

    uint dnaDigits = 16;                        //data type unsigned integer
    uint dnaModulus = 10 ** dnaDigits; 

    struct Zombie {                             //data structure type
        string name;
        uint dna;
    }

    Zombie[] public zombies;                    //create array to store the zombies we create later

    function createZombie(string memory _name, uint _dna) public {      //public function that puts zombies in array
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string memory _str) private view returns(uint){     //private function that generates a random dna for zombie
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public{            //public function that gives zombie dna and name
        uint randDna = _generateRandomDna(_name);
        createZombie(_name, randDna);
    }
}