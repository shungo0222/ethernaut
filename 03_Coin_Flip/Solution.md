`CoinFlip` コントラクト内の `flip` 関数に着目してみると、

```tsx
uint256 blockValue = uint256(blockhash(block.number - 1));
uint256 coinFlip = blockValue / FACTOR;
bool side = coinFlip == 1 ? true : false;
```

この3行分のコードを実行できれば結果が `true` なのか `false` なのかを判断することができる。

なので方針としては、上記の3行を計算する関数を新しいコントラクト内に作成し、その結果を使って `CoinFlip.flip` 関数を呼び出す。

（ `AttackCoinFlip.sol` 参照） `AttackCoinFlip.flip` 関数を呼び出す。