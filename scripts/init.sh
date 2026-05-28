#!/bin/bash
# init.sh — 初始化新小说项目
# 用法: bash init.sh

set -e

echo "=============================="
echo "  小说项目初始化工具"
echo "=============================="
echo ""

# 书名
read -p "📖 书名: " BOOK_NAME
read -p "✍️ 作者名(可选): " AUTHOR_NAME
read -p "🧑 主角名: " PROTAGONIST
read -p "🎭 主角性格(一句话): " PERSONALITY
read -p "🌍 世界观一句话简介: " WORLD_INTRO
read -p "📏 预计总章数(如:100、300、500): " TOTAL_CHAPS

# 小说类型选择
echo ""
echo "📚 选择小说类型（输入编号）:"
echo "  1) 爽文/升级流     — 番茄、起点     — 打脸快、升级不停"
echo "  2) 悬疑/解谜        — 起点、豆瓣     — 反转多、信息挤压"
echo "  3) 情感/煽情        — 晋江、番茄女频  — 刀糖交替、关系驱动"
echo "  4) 无限流/副本      — 起点、番茄     — 独立副本+主线钩子"
echo "  5) 日常/轻松        — 番茄、晋江     — 人设驱动、氛围感"
echo "  6) 设定/规则创新    — 番茄、起点     — 新奇规则、信息差"
echo "  7) 自定义           — 自己定义写作规则"
read -p "请输入编号(1-7): " TYPE_NUM

case $TYPE_NUM in
  1) TYPE_NAME="爽文/升级流" ;;
  2) TYPE_NAME="悬疑/解谜" ;;
  3) TYPE_NAME="情感/煽情" ;;
  4) TYPE_NAME="无限流/副本" ;;
  5) TYPE_NAME="日常/轻松" ;;
  6) TYPE_NAME="设定/规则创新" ;;
  7) TYPE_NAME="自定义" ;;
  *) TYPE_NAME="爽文/升级流" ;;
esac

if [ "$TYPE_NUM" = "7" ]; then
  echo ""
  echo "📝 请描述你想要的写作规则（一句话概括节奏和核心驱动力）:"
  read -p "> " CUSTOM_RULE
fi

# 发布平台
echo ""
echo "📱 选择主要发布平台（选填）:"
echo "  0) 不指定"
echo "  1) 番茄小说"
echo "  2) 起点中文网"
echo "  3) 晋江文学城"
echo "  4) 其他"
read -p "请输入编号(0-4): " PLATFORM_NUM

case $PLATFORM_NUM in
  0) PLATFORM="" ;;
  1) PLATFORM="番茄小说" ;;
  2) PLATFORM="起点中文网" ;;
  3) PLATFORM="晋江文学城" ;;
  4) PLATFORM="其他" ;;
  *) PLATFORM="" ;;
esac

echo ""
echo "正在生成项目文件..."

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# 替换 CLAUDE.md 中的占位符
sed -i "s/{{书名}}/$BOOK_NAME/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{主角名}}/$PROTAGONIST/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{主角性格}}/$PERSONALITY/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{世界观简介}}/$WORLD_INTRO/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{总章数}}/$TOTAL_CHAPS/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{作者名}}/$AUTHOR_NAME/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{小说类型}}/$TYPE_NAME/g" "$PROJECT_DIR/CLAUDE.md"
sed -i "s/{{发布平台}}/$PLATFORM/g" "$PROJECT_DIR/CLAUDE.md"

if [ "$TYPE_NUM" = "7" ]; then
  sed -i "s/{{自定义规则}}/$CUSTOM_RULE/g" "$PROJECT_DIR/CLAUDE.md"
fi

# 写入设定集基础信息
cat > "$PROJECT_DIR/完整作品设定集.md" << EOF
# 《${BOOK_NAME}》
## 完整作品设定集

**作者**：${AUTHOR_NAME}
**类型**：${TYPE_NAME}
**发布平台**：${PLATFORM}
**预计总篇幅**：${TOTAL_CHAPS}章

---

## 一、世界观

${WORLD_INTRO}

### 世界背景

（详细描述故事发生的世界）

### 核心设定

（独特的规则、能力体系、世界观底层逻辑）

### 力量/能力体系（如适用）

（等级划分、成长路径、特殊能力说明）

---

## 二、角色设定

### 主角：${PROTAGONIST}
- **年龄**：
- **性格**：${PERSONALITY}
- **背景故事**：
- **核心驱动力**：
- **角色成长弧线**：

### 重要配角

#### 配角A
- **身份**：
- **性格**：
- **与主角关系**：
- **角色作用**：

#### 配角B
（同上）

### 反派/冲突方
- **身份**：
- **动机**：
- **与主角的冲突核心**：

---

## 三、剧情大纲

### 整体结构（共${TOTAL_CHAPS}章）

（按幕/季划分，每季注明核心主题、反派、情感高潮）

### 详细章节规划

#### 单元一：第1章-第X章
- **核心事件**：
- **爽点/高潮安排**：
- **煽情点**：
- **伏笔埋设**：

#### 单元二：第X章-第X章
（同上）

---

## 四、伏笔清单

### 长线伏笔
（贯穿全书的伏笔）

### 短线伏笔
（单卷/单元内的伏笔）

---

## 五、节奏设计

### 核心节奏公式
（根据所选类型 ${TYPE_NAME} 自动适配，详见 CLAUDE.md）

### 情感高潮 / 关键转折点

| 章节 | 事件 | 类型 |
|------|------|------|
| 第X章 | XXX | 爽点/煽情/反转 |
EOF

echo ""
echo "✅ 项目初始化完成！"
echo "=============================="
echo "📖 书名: $BOOK_NAME"
echo "🧑 主角: $PROTAGONIST"
echo "📚 类型: $TYPE_NAME"
echo "📏 预计: ${TOTAL_CHAPS}章"
echo ""
echo "接下来："
echo "1. 打开 完整作品设定集.md 补充世界观和角色细节"
echo "2. 在 Claude Code 中说"写第一章"开始写作"
echo "=============================="