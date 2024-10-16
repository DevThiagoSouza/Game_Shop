import '../models/game.dart';

class GameService {
  final List<Game> _games = [
    Game(
      title: 'God of War',
      imageUrl: 'lib/assets/images/banner/banner-god-of-war.jpg',
      price: 59.99,
      description: '''Após os eventos da trilogia original, Kratos, mais velho e buscando redenção por suas ações violentas no passado, tenta viver uma vida tranquila no reino de Midgard. Ele está criando Atreus, após a morte de sua esposa Faye. Juntos, eles embarcam em uma jornada para cumprir o último desejo de Faye: espalhar suas cinzas no pico mais alto de todos os reinos.
       Ao longo dessa jornada, Kratos e Atreus enfrentam criaturas mitológicas, deuses nórdicos e revelações emocionais, enquanto Kratos luta para esconder sua verdadeira natureza de deus e guerreiro sanguinário de Atreus. O jogo é marcado por uma relação complexa entre pai e filho, com Kratos ensinando Atreus a sobreviver e amadurecer, enquanto tenta ser um melhor exemplo para ele''',
      videoUrl: 'https://www.youtube.com/watch?v=FyIwEFXOcaE',
      platforms: [Platform.PlayStation, Platform.PC],
      images: ["lib/assets/images/banner/banner-god-of-war.jpg"],
    ),
    Game(
      title: 'EA FC 24',
      imageUrl: 'lib/assets/images/banner/fc-24.png',
      price: 39.99,
      description: 'A FC 2024 ocorrerá em um amplo espaço ao ar livre, decorado com faixas coloridas e luzes que refletem as culturas dos participantes. Haverá áreas temáticas representando várias regiões do mundo, onde os visitantes poderão explorar tradições, arte e gastronomia de diferentes países.',
      videoUrl: '',
      platforms: [Platform.Xbox , Platform.PlayStation, Platform.PC, Platform.Switch], images: [],
    ),
    Game(
      title: 'The Last Of Us Part 2',
      imageUrl: 'lib/assets/images/banner/the-last-of-us-4k.jpg',
      price: 49.99,
      description: 'The Last of Us Part II combina elementos de stealth, combate e exploração. Os jogadores podem usar uma variedade de armas e táticas para enfrentar inimigos humanos e criaturas infectadas. A jogabilidade também enfatiza a liberdade de escolha, permitindo que os jogadores abordem situações de diferentes maneiras.',
      videoUrl: '',
      platforms: [Platform.PlayStation, Platform.PC], images: [],
    ),
    Game(
      title: 'Cyberpunk 2077',
      imageUrl: 'lib/assets/images/banner/ciberpunk.jpg',
      price: 29.99,
      description: 'A história gira em torno de V, um mercenário que busca um futuro melhor em uma sociedade dominada por corporações e tecnologia. O enredo é impulsionado pela busca de V por um implante cibernético que promete imortalidade, mas que também traz consigo a consciência do lendário rockstar Johnny Silverhand, interpretado por Keanu Reeves. A narrativa se desenrola em missões que exploram temas como identidade, poder e a luta contra opressões.',
      videoUrl: '', platforms: [Platform.PC, Platform.PlayStation, Platform.Xbox], images: [],
    ),
    Game(
      title: 'Forza Horizon 5',
      imageUrl: 'lib/assets/images/banner/forza-horizon.jpg',
      price: 39.99,
      description: 'O jogo se passa no México, apresentando uma variedade impressionante de paisagens, incluindo praias, desertos, florestas tropicais, montanhas e cidades vibrantes. A diversidade do ambiente oferece diferentes desafios e oportunidades para os jogadores explorarem.',
      videoUrl: '', platforms: [Platform.Xbox, Platform.PC], images: [],
    ),
    Game(
      title: 'Mario Kart 8',
      imageUrl: 'lib/assets/images/banner/mario-kart-8.jpg',
      price: 29.99,
      description: 'O jogo permite que os jogadores escolham entre uma variedade de personagens do universo Mario, cada um com suas próprias características. Os corredores competem em diversas pistas coloridas e criativas, utilizando itens como cascas de tartaruga, estrelas e cogumelos para ganhar vantagem sobre os oponentes. Mario Kart 8 introduz a mecânica de "antigravidade", permitindo que os jogadores corram em superfícies inclinadas e de lado, adicionando uma nova dimensão às corridas.',
      videoUrl: '', platforms: [Platform.Switch], images: [],
    ),
    Game(
      title: 'Marvels Spider-Man',
      imageUrl: 'lib/assets/images/banner/Marvels_Spider-Man.jpg',
      price: 39.99,
      description: 'O jogo se passa em uma Nova York aberta, onde o jogador assume o papel de Peter Parker, que é o Homem-Aranha. A história gira em torno do conflito entre Peter e uma série de vilões clássicos, incluindo o Rei do Crime e o Dr. Octopus, enquanto ele tenta equilibrar sua vida como super-herói e sua vida pessoal. A narrativa explora temas de responsabilidade, amizade e sacrifício.',
      videoUrl: '', platforms: [Platform.PlayStation, Platform.PC], images: [],
    ),
    Game(
      title: 'Ghost of Tsushima',
      imageUrl: 'lib/assets/images/banner/ghostoftsushima.jpg',
      price: 49.99,
      description: 'Os jogadores assumem o papel de Jin Sakai, um samurai que luta para proteger sua terra natal e seu povo da invasão mongol. Após um ataque devastador, Jin deve se adaptar e adotar métodos não tradicionais de combate, incluindo técnicas de furtividade, para derrotar os invasores. A história explora temas como honra, sacrifício e a luta interna entre as tradições samurais e novas abordagens para a guerra.',
      videoUrl: '',
      platforms: [Platform.PlayStation, Platform.PC], images: [],
    ),
    Game(
      title: 'Gran Theft Auto V',
      imageUrl: 'lib/assets/images/banner/gta.jpg',
      price: 19.99,
      description: 'A história de GTA V se passa na fictícia cidade de Los Santos, uma recriação de Los Angeles, e acompanha três protagonistas jogáveis: Michael De Santa, um ex-assaltante de bancos; Franklin Clinton, um jovem que busca ascender na vida; e Trevor Philips, um ex-militar e criminal imprevisível. O enredo gira em torno de suas interações e atividades criminosas, incluindo assaltos a banco, perseguições e conflitos com gangues e autoridades.',
      videoUrl: '',
      platforms: [Platform.PC, Platform.PlayStation, Platform.Xbox], images: [],
    ),
  ];

  List<Game> getAllGames() {
    return _games;
  }

  List<Game> getBestSellers() {
    return _games.where((game) => game.price > 30).toList();
  }

  List<Game> getPreOrders() {
    return _games.where((game) => game.price < 30).toList();
  }
}
