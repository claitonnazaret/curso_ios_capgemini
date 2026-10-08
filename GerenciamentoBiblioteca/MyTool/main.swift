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
    
    func devolver() {
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
        super,.init(titulo: titulo, autor: autor, anoPublicacao: anoPublicacao)
    }
    
    func atualizarTamanho(novoTamanho: Double) {
        self.tamanhoEmMB = novoTamanho
    }
    
    func exibirDetalhes() {
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

class GerenciadorBiclioteca {
    private var acervo: [Livro] = []
    
    func cadastrar(livro: Livro) {
        acervo.append(livro)
        print(" '\(livro.titulo)' cadastrado com sucesso!")
    }
}








































