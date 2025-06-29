# 更新日志 (Changelog)

---

## [0.1.5]

## 优化组件性能

## [0.1.5]

### 修复 (Fixed)

- 修复了图片组件。

## [0.1.4]

### 修复 (Fixed)

- 修复了 `JsonViewer` 组件在显示值为多行文本时，key 会占用多行空白的问题。

## [0.1.3]

### 新增 (Added)

- 添加了 `Splitter` 组件，用于创建可拖动分隔的布局。

## [0.1.2]

### 新增 (Added)

- 添加了 `IntlText` 组件，用于处理国际化文本。

## [0.1.1]

### 新增 (Added)

- 为 `ToggleButtonGroup` 组件添加了 `itemBuilder` 属性，以支持更灵活的自定义。

### 移除 (Removed)

- 移除了部分冗余封装的组件，精简代码。

## [0.1.0]

### 新增 (Added)

- 添加了 `DioLoggerScreen` 组件，用于在界面上方便地查看 Dio 网络请求日志。

## [0.0.9]

### 修复 (Fixed)

- 修复了 `JsonViewer` 组件在显示集合（List）时的缩进异常问题。

### 移除 (Removed)

- 移除了 `JsonViewer` 组件在集合中显示长度和索引的特性，以简化逻辑。

## [0.0.8]

### 更改 (Changed)

- 恢复了 `IntlBackButton` 的图标至 Flutter 默认的 `BackButton` 图标，保持原生体验。

### 新增 (Added)

- 为 `IntlBackButton` 添加了可更换图标的属性。

## [0.0.7]

### 修复 (Fixed)

- 修复了当 `IntlAppBar` 的 `leading` 属性为 `null` 时，在根路由页面依然会显示返回按钮的问题。

## [0.0.6]

### 新增 (Added)

- 添加了 `JsonViewer` 组件，用于美观地可视化 JSON 数据结构。

## [0.0.5]

### 修复 (Fixed)

- 修复了部分组件未能正确导出的问题。

## [0.0.4]

### 新增 (Added)

- 添加了用于显示圆形图片的组件。

## [0.0.3]

### 更改 (Changed)

- 重构了 `IntlAppBar` 组件，使其 API 更加完善和通用。

## [0.0.2]

### 新增 (Added)

- 添加了 `example` 示例项目，用于演示组件用法。

### 修复 (Fixed)

- 修复了一些已知的 bug。

## [0.0.1]

### 新增 (Added)

- 项目初版发布，包含了 `IntlAppBar`、`IntlBackButton` 等核心国际化组件。