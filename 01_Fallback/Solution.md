`contribute` 関数と `receive` 関数内に `owner = msg.sender` があるので、どちらかを使って `owner` 変数に自分のウォレットアドレスを代入する。その後に `withdraw` 関数を使ってコントラクトに送金した残高を全て引き出す。

`contribute` 関数を使って `owner` を更新するためには、注目するべき制約が2つある。

- `require(msg.value < 0.001 ether);`
- `if(contributions[msg.sender] > contributions[owner])`

1回に `0.001 ether` 未満のetherしか送ることが出来ず、且つ初期オーナーのcontribution額（ `1000 ether` ）より自分のcontribution額の方が大きくなる必要があるため、何回もこの関数を実行しなければいけない。

なのでまずは

```tsx
  await contract.contribute({value: toWei("0.0001")}) 
```

を実行して自分のcontribution額を0以上にし、その後に `receive` 関数を呼び出すために

```tsx
  await sendTransaction({from: player, to: contract.address, value: toWei("0.0001")})
```

を実行する。

よって自分が `owner` になることが出来たので残高を引き出すことができる。