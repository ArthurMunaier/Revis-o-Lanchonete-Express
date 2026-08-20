import 'package:flutter/material.dart';

void main() {
  runApp(const LanchoneteApp());
}

class LanchoneteApp extends StatelessWidget {
  const LanchoneteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lanchonete Express',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

// Widget personalizado para evitar repetir o mesmo código dos produtos.
class CardProduto extends StatelessWidget {
  final String nome;
  final String preco;
  final String descricao;
  final VoidCallback aoClicar;

  const CardProduto({
    super.key,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nome,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(preco,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800])),
            const SizedBox(height: 6),
            Text(descricao),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: aoClicar,
                child: const Text('Ver detalhes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  void abrirDetalhes(BuildContext context, String nome, String preco,
      String descricao) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaDetalhes(
          nome: nome,
          preco: preco,
          descricao: descricao,
        ),
      ),
    );
  }

  void mostrarPromocao(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_offer, size: 45, color: Colors.orange),
              SizedBox(height: 10),
              Text('Promoção do dia',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                'Na compra de um X-Burguer, o suco sai pela metade do preço!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final produtos = [
      {
        'nome': 'X-Burguer',
        'preco': 'R\$ 18,00',
        'descricao': 'Pão, carne, queijo e molho especial.',
      },
      {
        'nome': 'Batata Frita',
        'preco': 'R\$ 12,00',
        'descricao': 'Porção individual crocante.',
      },
      {
        'nome': 'Suco Natural',
        'preco': 'R\$ 8,00',
        'descricao': 'Suco gelado da fruta.',
      },
      {
        'nome': 'Combo Especial',
        'preco': 'R\$ 28,00',
        'descricao': 'X-Burguer, batata e suco.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lanchonete Express'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo à Lanchonete Express!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Escolha seu produto e confira os detalhes.'),
            const SizedBox(height: 20),
            ...produtos.map(
              (produto) => CardProduto(
                nome: produto['nome']!,
                preco: produto['preco']!,
                descricao: produto['descricao']!,
                aoClicar: () => abrirDetalhes(
                  context,
                  produto['nome']!,
                  produto['preco']!,
                  produto['descricao']!,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaPedido(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Fazer Pedido'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => mostrarPromocao(context),
                icon: const Icon(Icons.local_offer),
                label: const Text('Ver promoção'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDetalhes extends StatefulWidget {
  final String nome;
  final String preco;
  final String descricao;

  const TelaDetalhes({
    super.key,
    required this.nome,
    required this.preco,
    required this.descricao,
  });

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  bool destaque = false;

  void adicionarDestaque() {
    setState(() {
      destaque = !destaque;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do produto'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: destaque ? 220 : 180,
              height: destaque ? 220 : 180,
              decoration: BoxDecoration(
                color: destaque ? Colors.orange.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(destaque ? 35 : 15),
                border: Border.all(
                  color: destaque ? Colors.orange : Colors.grey,
                  width: destaque ? 4 : 1,
                ),
              ),
              child: Icon(
                Icons.fastfood,
                size: destaque ? 90 : 70,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 25),
            Text(widget.nome,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.preco,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800)),
            const SizedBox(height: 15),
            Text(widget.descricao,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17)),
            const SizedBox(height: 25),
            if (destaque)
              const Text(
                'Produto mais pedido da semana!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: adicionarDestaque,
              icon: Icon(
                destaque ? Icons.star : Icons.star_border,
              ),
              label: Text(
                destaque ? 'Remover destaque' : 'Adicionar destaque',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaPedido extends StatefulWidget {
  const TelaPedido({super.key});

  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  final nomeController = TextEditingController();
  final produtoController = TextEditingController();
  final observacaoController = TextEditingController();

  int pedidosEnviados = 0;

  void enviarPedido() {
    final nome = nomeController.text.trim();
    final produto = produtoController.text.trim();

    if (nome.isEmpty || produto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o nome e o produto antes de enviar.'),
        ),
      );
      return;
    }

    setState(() {
      pedidosEnviados++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pedido enviado com sucesso!'),
      ),
    );

    nomeController.clear();
    produtoController.clear();
    observacaoController.clear();
  }

  @override
  void dispose() {
    nomeController.dispose();
    produtoController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazer Pedido'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pedidos enviados: $pedidosEnviados',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: produtoController,
              decoration: const InputDecoration(
                labelText: 'Produto desejado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: observacaoController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Observação do pedido',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: enviarPedido,
                icon: const Icon(Icons.send),
                label: const Text('Enviar Pedido'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
