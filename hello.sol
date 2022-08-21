pragma solidity ^0.4.25;

contract Hello {
    string public message;

    function Inbox(string initialMessage) public{
        message = initialMessage;
    }

    function setMesaage(string newMessage) public {
        message = newMessage
    }

    function getMessage() public view returns (string) {
        return message
    }
}

