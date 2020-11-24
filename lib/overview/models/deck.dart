class Deck{
  final String deckname;
  final String desc;
  final String tag;

  Deck({ this.deckname, this.desc, this.tag});
  
}

class FlashCard{
  final String deckId;
  final String front;
  final String back;

  FlashCard({ this.deckId, this.front, this.back});
}