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

    mapping (uint => address) public zombieToOwner;                     //mapping to show who zombie belongs to
    mapping (address => uint) ownerZombieCount;                         //mapping to see how many zombies owner has

    function createZombie(string memory _name, uint _dna) public {      //public function that puts zombies in array
        uint id = zombies.push(Zombie(_name, _dna)) - 1;                //array.push - 1 to get the last zombie we just created
        zombieToOwner[id] = msg.sender;                                 //take the id and store msg.sender under it
        ownerZombieCount[msg.sender]++;                                 //increment count of zombie by +1
        emit NewZombie(id, _name, _dna);                                 //fire off event taking all params
    }

    function _generateRandomDna(string memory _str) private view returns(uint){     //private function that generates a random dna for zombie
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public{            //public function that gives zombie dna and name
        uint randDna = _generateRandomDna(_name);
        require(ownerZombieCount[msg.sender] == 0);                     //make sure the owner has 0 zombies so they cannot spawn indefinite amount  
        createZombie(_name, randDna);
    }
}

//pick up on the morrow