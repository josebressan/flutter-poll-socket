

class Poll {
  String id;
  String name;
  int votes;

  Poll ({
    this.id,
    this.name,
    this.votes
  });

  factory Poll.fromMap( Map<String, dynamic> obj) 
  => Poll(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes'],
  );

}