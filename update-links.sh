#!/bin/bash
# 扫描知识漫游文件夹，将已建文件对应的（待建，...）标注自动清理

CONFIG=~/.claude/skills/zhishi-manyou/config.sh
[ ! -f "$CONFIG" ] && exit 0

source "$CONFIG"
[ -z "$OBSIDIAN_VAULT" ] && exit 0

FOLDER="$OBSIDIAN_VAULT/3.Sources(原材料)/知识漫游"
[ ! -d "$FOLDER" ] && exit 0

# 获取所有已建文件名（去掉 .md 后缀，排除待建清单）
BUILT=$(ls "$FOLDER" 2>/dev/null | sed 's/\.md$//' | grep -v '^00-')

for FILE in "$FOLDER"/*.md; do
  [ ! -f "$FILE" ] && continue
  [ "$(basename "$FILE")" = "00-待建清单.md" ] && continue

  CONTENT=$(cat "$FILE")
  ORIGINAL="$CONTENT"

  for CONCEPT in $BUILT; do
    ESCAPED=$(printf '%s\n' "$CONCEPT" | sed 's/[][]/\\&/g')
    # 替换带定义的待建格式：[[概念词]]（待建，...）
    CONTENT=$(echo "$CONTENT" | sed "s/\[\[$ESCAPED\]\]（待建，[^）]*）/[[$CONCEPT]]/g")
    # 替换无定义的旧格式：[[概念词]]（待建）
    CONTENT=$(echo "$CONTENT" | sed "s/\[\[$ESCAPED\]\]（待建）/[[$CONCEPT]]/g")
  done

  if [ "$CONTENT" != "$ORIGINAL" ]; then
    echo "$CONTENT" > "$FILE"
  fi
done
