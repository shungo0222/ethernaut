ポイントは「delegatecall」の仕様。

`delegatecall` では、呼び出し元のコンテクスト（msg.sender, msg.dataなど）を使って呼び出し先の関数を呼び出す。なので、最終的に更新されるのは呼び出し元のコントラクトのストレージである。

方針としては2つのコントラクトを見比べてみて、 `Delegate` コントラクトの方に以下の関数があって `owner` を更新しているので、それを `delegatecall` することを考える。

```tsx
function pwn() public {
  owner = msg.sender;
}
```

`Delegation` コントラクトの方を確認してみると `delegatecall` を使っているのは `fallback` 関数の中にある。 `fallback` 関数を呼び出す方法としては、コントラクト内に存在しない関数を呼び出せば良い。

なのでまとめると、 `Delegation` コントラクトに対して `pwn` 関数を呼び出すトランザクションを送信すれば、 `Delegation` コントラクトに `pwn` 関数はなくて `fallback` 関数が呼ばれ、 `delegatecall` は呼び出し元のコンテクストを使って呼び出し先のコントラクト関数を呼び出すため、 `msg.data` の部分はそのまま保持され `pwn` 関数が実行される。

あとは `pwn` 関数のシグネチャを `msg.data` に設定すれば良い。

`pwn` 関数のシグネチャは、 `pwn()` を `keccak256` ハッシュ関数に渡した後の値の先頭4バイトを取得すれば良い。

結果的には、以下のコマンドとなる。

```tsx
await sendTransaction({from: player, to: instance, data: "dd365b8b"})
```

また、 `owner` 変数は2つのコントラクト内のストレージの1つ目のスロットに入っている（コントラクト内の1番上で定義されているということ）ため対応している。