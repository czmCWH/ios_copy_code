## 一、git切换ssh和http协议
```
// 1. 查看当前remote

git remote -v

// 2. 切换到http：

git remote set-url origin https://github.com/username/repository.git

// 3. 切换到ssh：

git remote set-url origin git@github.com:username/repository.git
```

## 二、项目中添加 .gitignore 忽略相关的内容无效

 1. 情况一
例如会遇到添加 `Pods/`  文件夹无效，请检查前面是否有空格。
 2. 情况二
 我们在之后项目开发中，在 `.gitignore` 文件中新增忽略内容时无效，需要按照如下 `git` 命令清除本地缓存
 ```
git rm -r --cached .
git add .
git commit -m 'update .gitignore'
```

这是因为 `.gitignore` 文件只能作用于未被跟踪的文件，也就是那些从来没有被git记录过的文件（自添加以后，从未 `add` 及 `commit` 过的文件）。如果文件曾经被 `git` 记录过，那么 `.gitignore` 就对他们完全无效。参考自 [博客园 菁欣](https://www.cnblogs.com/jingxin1992/p/10281441.html)
