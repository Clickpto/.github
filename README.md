# .github

Repositório de configurações e templates do GitHub para projetos da organização.

## Estrutura

```
.github/
├── ISSUE_TEMPLATE/          # Templates de issues
├── workflows/               # GitHub Actions workflows
└── setup/
    └── develop/             # Pasta de desenvolvimento (pode ser movida para raiz)
        ├── .secrets         # Tokens e configurações locais
        ├── create-test-event.sh
        ├── events/
        │   ├── issue-opened.json
        │   └── README.md
        ├── run-act.sh
        └── validate_templates.sh
```

## Desenvolvimento Local

### Estrutura de Desenvolvimento

A pasta `develop/` contém todos os arquivos necessários para desenvolvimento e testes locais:
- **`.secrets`** - Tokens GitHub para execução local (não versionado)
- **`run-act.sh`** - Executa workflows localmente com `act`
- **`validate_templates.sh`** - Valida templates de issues
- **`create-test-event.sh`** - Cria eventos de teste para simular criação de issues
- **`events/`** - Arquivos JSON de eventos de teste

### Uso

#### Opção 1: Com develop em setup/develop/ (padrão)

```bash
cd setup/develop
./validate_templates.sh    # Validar templates
./create-test-event.sh     # Criar evento de teste
./run-act.sh               # Executar workflow
```

#### Opção 2: Com develop na raiz (para desenvolvimento local)

Para facilitar o desenvolvimento, você pode mover a pasta `develop` para a raiz:

```bash
# Mover para raiz
mv setup/develop .

# Agora os scripts funcionam da raiz
cd develop
./validate_templates.sh
./create-test-event.sh
./run-act.sh

# Quando terminar, pode mover de volta
mv develop setup/
```

## Notas Importantes

- A pasta `develop/` está no `.gitignore`, então não será versionada
- O arquivo `.secrets` contém tokens sensíveis e também está no `.gitignore`
- Todos os scripts usam caminhos relativos e funcionam independentemente da localização de `develop/`
- Veja `develop/events/README.md` para mais detalhes sobre os eventos de teste

## Workflows

### Sync Issue Form → Project fields

Workflow que sincroniza campos de formulários de issue com campos do GitHub Project.

**Trigger:** Quando uma issue é criada ou editada (`issues: [opened, edited]`)

**Funcionalidades:**
- Extrai valores do formulário da issue (Priority, Story Points, Iteration, Start date, End date, Release)
- Valida os valores extraídos
- Sincroniza com os campos correspondentes no GitHub Project
- Suporta projetos de organização (`org`) ou repositório (`repo`)

**Configuração:**
Edite as variáveis de ambiente no workflow:
- `PROJECT_NUMBER` - Número do Project
- `OWNER_LOGIN` - Login da organização/repositório
- `PROJECT_SCOPE` - "org" ou "repo"
- `DEBUG` - "true" para logs detalhados
