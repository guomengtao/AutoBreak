# 开发笔记

## 技术实现

### 核心功能
- 使用 `NSStatusItem` 实现菜单栏集成
- 使用 `Timer` 实现倒计时功能
- 使用 `AppleScript` 实现系统锁屏
- 使用 `Process` 实现自定义锁屏程序调用

### 代码结构
```
Sources/
  └── HelloWorldTopMenu/
      └── main.swift       # 主程序入口
Tests/
  └── CountdownLockScreenTests/
      └── ScreenLockTests.swift  # 单元测试
```

### 依赖管理
- 使用 Swift Package Manager
- 最低支持 macOS 11.0
- Swift 5.5+ 要求

## 开发计划

### 近期计划
- [ ] 添加更多锁屏方式支持
- [ ] 优化倒计时显示效果
- [ ] 添加更多自定义选项
- [ ] 完善错误处理机制

### 长期计划
- [ ] 支持更多操作系统版本
- [ ] 添加国际化支持
- [ ] 实现插件系统
- [ ] 添加更多自定义主题

## 已知问题
1. 某些系统版本可能需要额外权限
2. 自定义锁屏程序需要完整路径
3. 倒计时显示可能在某些分辨率下不完美

## 贡献指南
1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 测试说明
- 使用自定义测试框架
- 支持单元测试和集成测试
- 测试覆盖核心功能
- 支持自动化测试

## 发布流程
1. 更新版本号
2. 更新 CHANGELOG.md
3. 运行测试套件
4. 构建发布版本
5. 创建 GitHub Release 