# 🔧 Sistema de Gestão de Oficina Mecânica

Este projeto tem como objetivo modelar e implementar um banco de dados relacional para o gerenciamento de ordens de serviço em uma oficina mecânica, incluindo o cadastro de clientes, veículos, ordens de serviço, serviços realizados, peças utilizadas e os mecânicos responsáveis.

## 📌 Objetivo

- Estruturar o banco de dados conforme as boas práticas de modelagem conceitual e lógica;
- Implementar o banco no MySQL;
- Realizar inserções de dados fictícios;
- Criar queries SQL para fornecer informações úteis sobre o funcionamento da oficina.

---

## 🧱 Modelo Lógico

O modelo contempla as seguintes entidades e relacionamentos principais:

- **Cliente (PF/PJ)**: pode ter um ou mais veículos cadastrados.
- **Veículo**: pertence a um cliente e pode ter várias ordens de serviço.
- **Ordem de Serviço**: associada a um veículo, pode ter múltiplos serviços e peças vinculadas, bem como mecânicos responsáveis.
- **Serviço**: catálogo de serviços prestados pela oficina.
- **Peça**: estoque de peças utilizadas nas ordens.
- **Mecânico**: profissionais que executam os serviços e podem estar associados a múltiplas ordens.

---

## 🛠️ Criação do Banco de Dados

O script `oficina_script.sql` contém a estrutura SQL com todas as tabelas, relacionamentos e chaves definidas.

### ✅ Tabelas criadas:

- `Cliente`
- `Veiculo`
- `Ordem_Servico`
- `Servico`
- `Peca`
- `Mecanico`
- Tabelas associativas:
  - `Ordem_Servico_Servico`
  - `Ordem_Servico_Peca`
  - `Mecanico_Ordem`

---

## 📋 Dados Fictícios

Foram inseridos dados simulando clientes reais (PF e PJ), veículos, ordens, serviços e peças.

---
