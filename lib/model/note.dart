class Note {
  int id;
  String title;
  String date;

  Note({
    this.id,
    this.title,
    this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    title: json["title"],
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "date": date,
  };
}
