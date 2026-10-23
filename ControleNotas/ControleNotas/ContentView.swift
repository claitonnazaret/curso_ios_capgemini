import SwiftUI

struct ContentView: View {
    
    @State private var listaAlunos: [Aluno] = []
    
    private func adicionarAlunos(aluno: Aluno) -> Void {
        listaAlunos.append(aluno)
    }
    
    private func removerAluno(id: UUID) -> Void {
        listaAlunos.removeAll {$0.id == id}
    }
    
    private var totalAlunos: Int {
        listaAlunos.count
    }
    
    private var totalAprovados: Int {
        listaAlunos.filter { $0.isAprovado }.count
    }
    
    private var totalReprovados: Int {
        listaAlunos.filter { !$0.isAprovado }.count
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        HeaderAlunosView()
                    
                        FormularioAlunosView { novoAluno in
                            adicionarAlunos(aluno: novoAluno)
                        }
                        
                        ResumoAlunosView(totalAlunos: totalAlunos, totalAlunosAprovados: totalAprovados, totalAlunosReprovados: totalReprovados)
                        
                        TabelaAlunosView(alunos: listaAlunos) { id in
                            removerAluno(id: id)
                        }
                    }
                    
                }
                .background(LinearGradient(colors: [.blue, .cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea())
            }
        }
    }
    
}

#Preview {
    ContentView()
}
