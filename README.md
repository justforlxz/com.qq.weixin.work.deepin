# com.deepin.wine

deepin-wine flatpak runtime

## 安装依赖

需要先安装或构建 [deepin-wine runtime](https://github.com/justforlxz/com.deepin.wine)

## 构建运行时

```shell
flatpak-builder --repo=repo .build com.qq.weixin.work.deepin.yaml
```

## 安装运行时

```shell
flatpak remote-add --user --no-gpg-verify deepin-wine-apps ./repo
flatpak install --user deepin-wine-apps com.qq.weixin.work.deepin
```
