import sqlite3
import tkinter as tk
from tkinter import messagebox, ttk


class SistemaCadastroClientes:

  def __init__(self, root):
    self.root = root
    self.root.title("Cadastro de Clientes")
    self.root.geometry("450x260")
    self.root.resizable(False, False)

    # Inicializa o banco de dados
    self.criar_banco()

    # Cria os elementos da interface principal
    self.criar_interface()

  def criar_banco(self):
    """Cria o banco de dados SQLite e a tabela de clientes caso não existam."""
    conexao = sqlite3.connect("clientes.db")
    cursor = conexao.cursor()
    cursor.execute("""
            CREATE TABLE IF NOT EXISTS clientes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                nome TEXT NOT NULL,
                email TEXT NOT NULL,
                telefone TEXT NOT NULL
            )
        """)
    conexao.commit()
    conexao.close()

  def criar_interface(self):
    """Constrói os campos de entrada e botões na janela Tkinter."""
    frame_principal = tk.Frame(self.root, padx=20, pady=20)
    frame_principal.pack(fill=tk.BOTH, expand=True)

    # Campo Nome
    tk.Label(frame_principal, text="Nome Completo:", font=("Arial", 10)).grid(
        row=0, column=0, sticky="w", pady=5
    )
    self.entry_nome = tk.Entry(frame_principal, width=35, font=("Arial", 10))
    self.entry_nome.grid(row=0, column=1, pady=5)

    # Campo E-mail
    tk.Label(frame_principal, text="E-mail:", font=("Arial", 10)).grid(
        row=1, column=0, sticky="w", pady=5
    )
    self.entry_email = tk.Entry(frame_principal, width=35, font=("Arial", 10))
    self.entry_email.grid(row=1, column=1, pady=5)

    # Campo Telefone
    tk.Label(frame_principal, text="Telefone:", font=("Arial", 10)).grid(
        row=2, column=0, sticky="w", pady=5
    )
    self.entry_telefone = tk.Entry(
        frame_principal, width=35, font=("Arial", 10)
    )
    self.entry_telefone.grid(row=2, column=1, pady=5)

    # Frame para os botões
    frame_botoes = tk.Frame(frame_principal, pady=20)
    frame_botoes.grid(row=3, column=0, columnspan=2)

    # Botão Salvar
    btn_salvar = tk.Button(
        frame_botoes,
        text="Salvar Cliente",
        command=self.salvar_cliente,
        bg="#4CAF50",
        fg="white",
        font=("Arial", 9, "bold"),
        width=14,
    )
    btn_salvar.pack(side=tk.LEFT, padx=5)

    # Botão Limpar
    btn_limpar = tk.Button(
        frame_botoes,
        text="Limpar",
        command=self.limpar_formulario,
        bg="#f44336",
        fg="white",
        font=("Arial", 9, "bold"),
        width=12,
    )
    btn_limpar.pack(side=tk.LEFT, padx=5)

    # Botão Visualizar Clientes (Novo)
    btn_visualizar = tk.Button(
        frame_botoes,
        text="Visualizar Clientes",
        command=self.visualizar_clientes,
        bg="#2196F3",
        fg="white",
        font=("Arial", 9, "bold"),
        width=16,
    )
    btn_visualizar.pack(side=tk.LEFT, padx=5)

  def salvar_cliente(self):
    """Valida os dados e insere o registro no banco SQLite."""
    nome = self.entry_nome.get().strip()
    email = self.entry_email.get().strip()
    telefone = self.entry_telefone.get().strip()

    if not nome or not email or not telefone:
      messagebox.showwarning(
          "Campos Obrigatórios",
          "Por favor, preencha todos os campos antes de salvar.",
      )
      return

    try:
      conexao = sqlite3.connect("clientes.db")
      cursor = conexao.cursor()
      cursor.execute(
          "INSERT INTO clientes (nome, email, telefone) VALUES (?, ?, ?)",
          (nome, email, telefone),
      )
      conexao.commit()
      conexao.close()

      messagebox.showinfo("Sucesso", "Cliente cadastrado com sucesso!")
      self.limpar_formulario()

    except sqlite3.Error as erro:
      messagebox.showerror(
          "Erro no Banco de Dados", f"Não foi possível salvar os dados:\n{erro}"
      )

  def limpar_formulario(self):
    """Apaga o conteúdo de todos os campos e retorna o foco ao primeiro campo."""
    self.entry_nome.delete(0, tk.END)
    self.entry_email.delete(0, tk.END)
    self.entry_telefone.delete(0, tk.END)
    self.entry_nome.focus()

  def visualizar_clientes(self):
    """Abre uma nova janela exibindo todos os clientes cadastrados em uma tabela."""
    try:
      conexao = sqlite3.connect("clientes.db")
      cursor = conexao.cursor()
      cursor.execute("SELECT id, nome, email, telefone FROM clientes")
      registros = cursor.fetchall()
      conexao.close()
    except sqlite3.Error as erro:
      messagebox.showerror(
          "Erro no Banco de Dados", f"Erro ao consultar os dados:\n{erro}"
      )
      return

    if not registros:
      messagebox.showinfo(
          "Lista Vazia", "Ainda não há clientes cadastrados no banco de dados."
      )
      return

    # Cria uma janela secundária (Toplevel)
    janela_lista = tk.Toplevel(self.root)
    janela_lista.title("Clientes Cadastrados")
    janela_lista.geometry("620x350")

    # Frame para organizar a tabela e a barra de rolagem
    frame_tabela = tk.Frame(janela_lista, padx=10, pady=10)
    frame_tabela.pack(fill=tk.BOTH, expand=True)

    # Configuração da barra de rolagem vertical
    scrollbar = ttk.Scrollbar(frame_tabela, orient=tk.VERTICAL)
    scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

    # Criação da tabela (Treeview)
    colunas = ("id", "nome", "email", "telefone")
    tabela = ttk.Treeview(
        frame_tabela,
        columns=colunas,
        show="headings",
        yscrollcommand=scrollbar.set,
    )

    # Definição dos cabeçalhos
    tabela.heading("id", text="ID")
    tabela.heading("nome", text="Nome Completo")
    tabela.heading("email", text="E-mail")
    tabela.heading("telefone", text="Telefone")

    # Configuração da largura e alinhamento das colunas
    tabela.column("id", width=40, anchor=tk.CENTER)
    tabela.column("nome", width=200, anchor=tk.W)
    tabela.column("email", width=200, anchor=tk.W)
    tabela.column("telefone", width=130, anchor=tk.CENTER)

    # Insere cada linha retornada do banco na tabela
    for cliente in registros:
      tabela.insert("", tk.END, values=cliente)

    tabela.pack(fill=tk.BOTH, expand=True)
    scrollbar.config(command=tabela.yview)


if __name__ == "__main__":
  janela = tk.Tk()
  app = SistemaCadastroClientes(janela)
  janela.mainloop()

