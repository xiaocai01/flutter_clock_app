# Flutter Clock App

一个简单的时钟效果 - A simple Flutter clock app with analog and digital clock display.

## 功能特性 (Features)

- ✨ **数字时钟显示** - Shows current time in HH:MM:SS format
- 🕐 **模拟时钟显示** - Analog clock with hour, minute, and second hands
- 🎨 **现代化设计** - Material Design 3 with light and dark theme support
- 🔄 **实时更新** - Real-time clock updates
- 📱 **响应式布局** - Responsive design for different screen sizes

## 项目结构 (Project Structure)

```
flutter_clock_app/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── screens/
│   │   └── clock_screen.dart  # 时钟主屏幕
│   └── widgets/
│       ├── analog_clock.dart  # 模拟时钟组件
│       └── digital_clock.dart # 数字时钟组件
├── pubspec.yaml               # 项目配置和依赖
└── README.md                  # 项目说明文档
```

## 快速开始 (Getting Started)

### 前置条件 (Prerequisites)

- Flutter SDK (>=3.0.0)
- Dart SDK
- 任意 IDE (VS Code / Android Studio)

### 安装 (Installation)

1. 克隆仓库
```bash
git clone https://github.com/xiaocai01/flutter_clock_app.git
cd flutter_clock_app
```

2. 获取依赖
```bash
flutter pub get
```

3. 运行应用
```bash
flutter run
```

## 组件说明 (Component Description)

### DigitalClock Widget

显示数字格式的时间 (HH:MM:SS 和 YYYY-MM-DD)，每秒更新一次。

**主要特性：**
- 大号字体显示时间
- 实时日期显示
- 高对比度设计

### AnalogClock Widget

使用 `CustomPaint` 绘制模拟时钟，包括：
- **时针、分针、秒针** (Hour, minute, and second hands)
- **时钟刻度** (Clock marks)
- **数字标记** (Numbers 1-12)
- **中心点** (Center dot)

**绘制细节：**
- 精确的角度计算
- 流畅的动画效果（100ms 刷新率）
- 美观的外观设计

## 主要特性 (Main Features)

✅ **精确的时间计算** - Accurate time calculation for all hands
✅ **流畅的动画** - Smooth animations with 100ms refresh rate
✅ **主题支持** - Light and dark theme support
✅ **响应式设计** - Responsive to different screen sizes
✅ **无外部依赖** - Only uses Flutter built-in packages

## 版本 (Version)

- v1.0.0

## 许可证 (License)

MIT License - 详见 LICENSE 文件

## 贡献 (Contributing)

欢迎提交 Issues 和 Pull Requests！

## 开发者 (Author)

- xiaocai01
