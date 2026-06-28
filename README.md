# 知识漫游 / Zhishi Manyou

一个给 Claude Code 用的深度学习 skill。输入任何概念词，以它为入口漫游整张知识网络——多学科视角、争议、边界、延伸节点，自动保存到 Obsidian，自动维护双链。

---

## 效果预览

输入：`/知识漫游 元认知倾向`

你会得到：
- **一句话定义** — 用你自己能说出口的语言
- **来源与演变** — 这个词从哪里来，经历了什么
- **不同学科怎么看** — 认知心理学/神经科学/哲学/东方哲学等各自的解读，每个学科都是可继续深入的入口
- **争议在哪里** — 支持者和质疑者各自的核心论点
- **边界与对立面** — 容易混淆的概念、对立面、局限
- **知识地图** — 上游/同层/下游概念，带双链
- **延伸节点** — 5-8 个值得深入的方向，标注已有/待建状态
- **和你的关联** — 结合你的具体工作场景给出可直接用的连接
- **自动保存** — 完整文章存入 Obsidian，双链自动维护

---

## 安装

```bash
mkdir -p ~/.claude/skills/zhishi-manyou
curl -o ~/.claude/skills/zhishi-manyou/SKILL.md \
  https://raw.githubusercontent.com/sanhechuanmei-stack/zhishi-manyou-skill/main/SKILL.md
curl -o ~/.claude/skills/zhishi-manyou/update-links.sh \
  https://raw.githubusercontent.com/sanhechuanmei-stack/zhishi-manyou-skill/main/update-links.sh
chmod +x ~/.claude/skills/zhishi-manyou/update-links.sh
```

重启 Claude Code，skill 自动生效。

---

## 使用方法

```
/知识漫游 概念词
```

**首次运行**会询问你的 Obsidian 库路径，配置一次，之后自动记住。

其他指令：

```
/知识漫游 待建清单        # 查看所有还没深入的概念
/知识漫游 更新 概念词     # 手动清理原文中已建词的（待建）标注
```

---

## 双链自动维护

- 每次生成文章，新出现的概念词带简单定义标注：`[[工作记忆]]（待建，暂时存储和操作信息的心理空间）`
- 每次你用 `/知识漫游 工作记忆` 建完这篇文章，所有旧文章里的 `（待建）` 标注**自动消失**，变成干净的 `[[工作记忆]]`
- 无需手动操作，hook 在后台自动跑

---

## 待建清单

每次生成文章后，`00-待建清单.md` 自动更新：

```markdown
## 待处理
- [ ] 工作记忆（来源：元认知倾向）
- [ ] 刻意练习（来源：元认知倾向）

## 已完成
- [x] 元认知倾向
- [x] 执行功能
```

输入 `/知识漫游 待建清单` 随时查看。

---

## 换电脑

重新安装 skill 后，第一次运行 `/知识漫游 任意概念词` 会自动：
1. 询问 Obsidian 库路径（配置一次）
2. 写入 hook 到 settings.json（自动完成）

之后完全正常使用。

---

## 文件结构

安装后 skill 目录：

```
~/.claude/skills/zhishi-manyou/
├── SKILL.md          # skill 主体
├── update-links.sh   # 双链自动更新脚本
└── config.sh         # 本地配置（首次运行自动生成，不上传 GitHub）
```

Obsidian 输出目录：

```
你的 Obsidian 库/
└── 3.Sources(原材料)/
    └── 知识漫游/
        ├── 00-待建清单.md
        ├── 元认知倾向.md
        └── 执行功能.md
```
