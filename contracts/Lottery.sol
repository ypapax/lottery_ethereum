pragma solidity ^0.5.4;

contract Lottery {
    uint public constant TICKET_PRICE = 1e16;
    address payable[] public  tickets;
    address payable public winner;
    uint public ticketingCloses;

    function SimpleLottery(uint duration) public {
        ticketingCloses = now + duration;
    }

    function buy() public payable {
        require(msg.value == TICKET_PRICE);
        require(now < ticketingCloses);
        tickets.push(msg.sender);
    }

    function drawWinner() public {
        require(now > ticketingCloses + 5 minutes);
        require(winner == address(0));

        winner = tickets[random() % tickets.length];
        winner.transfer(address(this).balance);
    }

    function random() private returns (uint){
        uint source = block.difficulty + now;
        bytes memory source_b = toBytes(source);
        return uint(keccak256(source_b));
    }

    function toBytes(uint256 x) public returns (bytes memory b) {
        b = new bytes(32);
        assembly {mstore(add(b, 32), x)}
    }

    function() payable external {
        buy();
    }
}