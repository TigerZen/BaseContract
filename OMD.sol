pragma solidity >= 0.4.25;
//operator and manager(OMD)

contract Manager{

    address public manager;

    constructor() public{
        manager = msg.sender;
    }

    modifier onlyManager{
        require(msg.sender == manager, "Is not owner");
        _;
    }

    function transferownership(address _new_manager) public onlyManager {
        manager = _new_manager;
    }
}

interface operatorInterface{
    function inqContract(string name) external view returns(address);
    function inqEquContract(uint8 equIndex) external view returns(address);
    function inqEqusAmount() external view returns(uint8);
}

contract setOperator is Manager{
    address operator;

    function setOperatorAddr(address operatorAddress) public{
        require(operatorAddress != address(0), "null contract!!!!!");
        operator = operatorAddress;
    }

    modifier onlyOperator{
        require(msg.sender == operator, "You are not operator");
        _;
    }

    modifier only(string contractName){
        address contractAddress = operatorInterface(operator).inqContract(contractName);
        require(msg.sender == contractAddress, "You are not have permission");
        _;
    }

    function addr(string contractName) public view returns(address){
        if(operatorInterface(operator).inqContract(contractName) == address(0)){
            revert("You use a null contract");
        }
        else{
            return operatorInterface(operator).inqContract(contractName);
        }
    }

    // function equ(uint8 equIndex) public view returns(address){
    //     return operatorInterface(operator).inqEquContract(equIndex);
    // }

    // function equAmount() public view returns(uint8){
    //     return operatorInterface(operator).inqEqusAmount();
    // }
}
