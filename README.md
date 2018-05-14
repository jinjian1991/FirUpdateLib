# FirUpdateLib
Fir.im version update static library

* 引入工程: 编译FirUpdateLib 生成 *LibFirUpdateLib.a* 和 *FirUpdateLib.h* 倒入工程中

* 使用方法：
`[[FirUpdateLib shared] newVersion];`

根据 Build Version 来判断是否强制退出 App 并跳转至 Fir 指定 URL
