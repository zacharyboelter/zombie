pragma solidity ^0.4.25;

contract ZombieFactory {                        //establish contract

    event NewZombie(uint zombieId, string name, uint dna);              //event to be triggered in createZombie function

    uint dnaDigits = 16;                        //data type unsigned integer
    uint dnaModulus = 10 ** dnaDigits; 

    struct Zombie {                             //data structure type
        string name;
        uint dna;
    }

    Zombie[] public zombies;                    //create array to store the zombies we create later

    function createZombie(string memory _name, uint _dna) public {      //public function that puts zombies in array
        uint id = zombies.push(Zombie(_name, _dna)) - 1;                //array.push - 1 to get the last zombie we just created
        emit NewZombie(id, _name, _dna)                                 //fire off event taking all params
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