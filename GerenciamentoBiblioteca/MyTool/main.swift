import Foundation

// Protocolo do documento
protocol Documento {
    var id: UUID { get }
    func exibirDetalhes()
}

// Classe do livro adotando o protocolo
class Livro: Documento {
    
    private(set) var id: UUID
    private(set) var titulo: String
    private(set) var autor: String
    private(set) var anoPublicacao: Int
    private(set) var isEmprestado: Bool
    
    init(titulo: String, autor: String, anoPublicacao: Int) {
        self.id = UUID()
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
        self.isEmprestado = false
    }
    
    func atualizarDados(titulo: String, autor: String, anoPublicacao: Int) {
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
    }
    
    func emprestar() -> Bool {
        if isEmprestado { return false }
        isEmprestado = true
        return true
    }
    
    func devolver() -> Bool {
        if !isEmprestado { return false }
        isEmprestado = false
        return false
    }
    
    func exibirDetalhes() {
        let status = isEmprestado ? "Emprestado" : "Disponivel"
        print("""
        [LIVRO FÍSICO] -----------------------
        ID: \(id.uuidString)
        Título: \(titulo)
        Autor: \(autor)
        Ano: \(anoPublicacao)
        Status: \(status)
        --------------------------------------
        """)
    }
}

class LivroDigital: Livro {
    private(set) var tamanhoEmMB: Double
    
    init(titulo: String, autor: String, anoPublicacao: Int, tamanhoEmMB: Double) {
        self.tamanhoEmMB = tamanhoEmMB
        super.init(titulo: titulo, autor: autor, anoPublicacao: anoPublicacao)
    }
    
    func atualizarTamanho(novoTamanho: Double) {
        self.tamanhoEmMB = novoTamanho
    }
    
    override func exibirDetalhes() {
        let status = isEmprestado ? "Emprestado" : "Disponivel"
        print("""
        [LIVRO DIGITAL] -----------------------
        ID: \(id.uuidString)
        Título: \(titulo)
        Autor: \(autor)
        Ano: \(anoPublicacao)
        Tamanho: \(tamanhoEmMB) MB
        Status: \(status)
        --------------------------------------
        """)
    }
}


//Gerenciador da Biblioteca

class GerenciadorDeLivros {
    private var acervo: [Livro] = []
    
    func cadastrar(livro: Livro) {
        acervo.append(livro)
        print(" '\(livro.titulo)' cadastrado com sucesso!")
    }
    
    func listarTodos() {
        if acervo.isEmpty {
            print("A blibloteca esta vazia")
            return
        }
        print("\n=== ACERVO DE LIVROS ===")
        for livro in acervo {
            livro.exibirDetalhes()
        }
    }
    
    func buscar(termo: String) {
        let resultados = acervo.filter {
            livro in livro.id.uuidString.lowercased() == termo.lowercased()
            || livro.titulo.lowercased().contains(termo.lowercased())
        }
        
        if resultados.isEmpty {
            print("Nenhum livro encontrado para o termo: \(termo)")
            return
        }
        
        print("\n Resultados encontrados (\(resultados.count)): ")
        resultados.forEach { $0.exibirDetalhes() }
    }
    
    func encontrarPorId(_ id: String) -> Livro? {
        return acervo.first { $0.id.uuidString.lowercased() == id.lowercased()}
    }
    
    func remover(id: String) -> Bool {
        if let idx = acervo.firstIndex(where: { $0.id.uuidString.lowercased() == id.lowercased() }) {
            let removido = acervo.remove(at: idx)
            print(" Livro '\(removido.titulo)' froi removido com sucesso!")
            return true
        }
        return false
    }
    
}

// Interface para o usuario

let gerenciador = GerenciadorDeLivros()

gerenciador.cadastrar(livro: Livro(titulo: "O Senhor dos anéis", autor: "J.R.R. Tolkien", anoPublicacao: 1954 ))
gerenciador.cadastrar(livro: LivroDigital(titulo: "1984 (E-book)", autor: "George Orwell", anoPublicacao: 1949, tamanhoEmMB: 4.3 ))

var executando = true

print("Bem-vindo ao Sistema de Biblioteca - Claiton - v1.0!")

while executando {
    print("""
        ================= MENU PRINCIPAL ================= 
        1. Cadastrar novo Livro (Físico / Digital )
        2. Listar acervo
        3. Buscar livro (id / titulo)
        4. Editar dados de um livro
        5. Emprestar / Devolver livro
        6. Excluir livro do acervo
        7. Sair do sistema
        ==================================================
        
        Escolha uma opcao: 
        """, terminator: "")
    
    guard let entradaMenu = readLine(), let opt = Int(entradaMenu) else {
        print("Entrada inválida! Digite um numero de 1 a 7.")
        continue
    }
    
    switch opt {
    case 1:
        print("\n --- NOVO CADASTRO ---")
        print("Tipo de Livro: (1) - Físico | (2) - Digital: ", terminator: "")
        let tipo = readLine() ?? ""
        if tipo != "1" && tipo != "2" {
            print("Tipo de livro inválido. Cancelando Cadastro.")
            continue
        }
        
        print("Titulo: ", terminator: "")
        let titulo = readLine() ?? "Sem Titulo"
        
        print("Autor: ", terminator: "")
        let autor = readLine() ?? "Anonimo"
        
        print("Ano de publicacao: ", terminator: "")
        let anoPublicacao = Int(readLine() ?? "") ?? 2026
        
        if tipo == "1" {
            let novoFisico = Livro(titulo: titulo, autor: autor, anoPublicacao: anoPublicacao)
            gerenciador.cadastrar(livro: novoFisico)
        } else {
            print("Tamanho do arquivo (MB): ", terminator: "")
            let tamanho = Double(readLine() ?? "") ?? 0.0
            let novoDigital = LivroDigital(titulo: titulo, autor: autor, anoPublicacao: anoPublicacao, tamanhoEmMB: tamanho)
            gerenciador.cadastrar(livro: novoDigital)
        }
        
    case 2:
        gerenciador.listarTodos()
        
    case 3:
        print("\nDigite o ID exato ou um trecho do titulo: ", terminator: "")
        if let busca = readLine(), !busca.isEmpty {
            gerenciador.buscar(termo: busca)
        } else {
            print("Termo inválido")
        }
        
    case 4:
        print("\nDigite o Id do livro que deseja editar: ", terminator: "")
        if let idInput = readLine(), let livro = gerenciador.encontrarPorId(idInput) {
            print("Novo titulo [Atual: \(livro.titulo)]: ", terminator: "")
            let novoTitulo = readLine() ?? ""
            let tituloFinal = novoTitulo.isEmpty ? livro.titulo : novoTitulo
            
            print("Novo autor [Atual: \(livro.autor)]: ", terminator: "")
            let novoAutor = readLine() ?? ""
            let autorFinal = novoAutor.isEmpty ? livro.autor : novoAutor
            
            print("Novo ano [Atual: \(livro.anoPublicacao)]: ", terminator: "")
            let anoFinal = Int(readLine() ?? "") ?? livro.anoPublicacao
            
            livro.atualizarDados(titulo: tituloFinal, autor: autorFinal, anoPublicacao: anoFinal)
            
            if let livroDigital = livro as? LivroDigital {
                print("Novo tamanho MB [Atual: \(livroDigital.tamanhoEmMB)]: )", terminator: "")
                if let tamInput = readLine(), let novoTam = Double(tamInput) {
                    livroDigital.atualizarTamanho(novoTamanho: novoTam)
                }
            }
            print("Dados atualizados com sucesso!")
        } else {
            print("Livro não encontrado.")
        }
        
    case 5:
        print("\nDigite o ID do livro: ", terminator: "")
        if let idInput = readLine(), let livro = gerenciador.encontrarPorId(idInput) {
            print("Acao: (1) - Emprestar | (2) - Devolver: ", terminator: "")
            let acao = readLine() ?? ""
            if acao == "1" {
                print(livro.emprestar() ? "Sucesso! Livro emprestado." : "O livro já se encontra emprestado")
            } else if acao == "2" {
                print(livro.devolver() ? "Sucesso! Livro devolvido." : "Esse livro ja estava na biblioteca.")
            } else {
                print("Livro nao encontrado.")
            }
        }
        
    case 6:
        print("\nDigite o ID do livro que deseja remover do acervo: ", terminator: "")
        if let idInput = readLine() {
            if !gerenciador.remover(id: idInput) {
                print("Nao foi possivel remover. ID não encontrado.")
            }
        }
        
    case 7:
        print("\nSaindo do sistema. Ate logo!")
        exit(0)
        
    default:
        print("Opcao invalida. Tente novamente.")
        continue
    }
}
