ポイントは「オーバーフロー・アンダーフロー」。

```tsx
  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }
```

上記の関数内で `require(balances[msg.sender] - _value >= 0);` このようにチェックをする部分があるが、例えば `balances[msg.sender]` が0で `_value` が1000000とかの場合は、アンダーフローによって計算結果がとても大きな数になり（ (2**256-1) - 1000000）、チェックをクリアしてしまう。

そして、 `_to` を自分のアドレスにすれば設定した `_value` の数が自分の残高に加算されることになる。

OpenZeppelinの `SafeMath` を使って予防することができる。