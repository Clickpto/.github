#!/bin/bash

# Script para validar e visualizar templates de issue do GitHub

TEMPLATE_DIR=".github/ISSUE_TEMPLATE"

echo "🔍 Validando templates de issue..."
echo ""

# Validar sintaxe YAML de todos os templates
ERRORS=0
for file in "$TEMPLATE_DIR"/*.yml; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        if python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>/dev/null; then
            echo "✅ $filename - YAML válido"
        else
            echo "❌ $filename - ERRO no YAML"
            ERRORS=$((ERRORS + 1))
        fi
    fi
done

echo ""

if [ $ERRORS -eq 0 ]; then
    echo "✨ Todos os templates estão válidos!"
    echo ""
    echo "📝 Templates encontrados:"
    for file in "$TEMPLATE_DIR"/*.yml; do
        if [ -f "$file" ] && [ "$(basename "$file")" != "config.yml" ]; then
            name=$(python3 -c "import yaml; data=yaml.safe_load(open('$file')); print(data.get('name', 'N/A'))" 2>/dev/null)
            desc=$(python3 -c "import yaml; data=yaml.safe_load(open('$file')); print(data.get('description', 'N/A'))" 2>/dev/null)
            echo "  • $name - $desc"
        fi
    done
    echo ""
    echo "💡 Para visualizar o template completo no GitHub:"
    echo "   1. Faça commit e push das alterações"
    echo "   2. Vá em Issues → New issue"
    echo "   3. Selecione o template desejado"
    exit 0
else
    echo "❌ Encontrados $ERRORS erro(s). Corrija antes de fazer commit."
    exit 1
fi

