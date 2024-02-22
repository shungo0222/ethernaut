`Fal1out` 関数がコンストラクタとして使われる予定だったがタイポにより誰でも呼び出せてしまうので、

```tsx
await contract.Fal1out()
```

と実行すると `owner` になることができる。